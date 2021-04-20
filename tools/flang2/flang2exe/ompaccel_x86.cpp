/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/*
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 *
 * Support for x86-64 OpenMP offloading
 * Last Modified: Jun 2020
 */
#ifdef OMP_OFFLOAD_LLVM

#include "kmpcutil.h"
#include "error.h"
#include "semant.h"
#include "ilmtp.h"
#include "ilm.h"
#include "ili.h"
#include "expand.h"
#include "exputil.h"
#include "outliner.h"
#include "machreg.h"
#include "mp.h"
#include "ll_structure.h"
#include "llmputil.h"
#include "ccffinfo.h"
#include "llutil.h"
#include "ompaccel.h"
#include "tgtutil.h"
#include "dinit.h"
#include "assem.h"
#include "dinitutl.h"
#include "cgllvm.h"
#include "cgmain.h"

#include "regutil.h"
#include "dtypeutl.h"
#include "llassem.h"
#include "ll_ftn.h"
#include "symfun.h"
#include <set>
#include <map>
#include <string>

static std::set<std::string> ompaccel_x86_parallel_func_set;
static std::set<std::string> ompaccel_x86_fork_wrapper_func_set;
static std::set<std::string> ompaccel_x86_reduced_func_set;

// flang reuses SPTR values, so we mangle the name with the SPTR to get globally
// unique name for each func_sptr in a compilation unit.
static std::string ompaccel_x86_get_mangled_sptr(SPTR func_sptr) {
  std::string func_name(getprint(func_sptr));
  // FIXME: The Concatenation below results in some strange memory violations
  // in some test-cases. The outlined func_name itself is mangled at this point,
  // so we rely on the name for uniquness.
  // return func_name + std::to_string(func_sptr);

  return func_name;
}

// Returns the ompaccel-sym that corresponds to \p reduction_sym in \p tinfo
static OMPACCEL_SYM *get_ompaccel_sym_for(OMPACCEL_RED_SYM *reduction_sym, OMPACCEL_TINFO *tinfo) {
  for (int i = 0; i < tinfo->n_symbols; i++) {
    OMPACCEL_SYM *omp_sym = &(tinfo->symbols[i]);
    if (strcmp(SYMNAME(omp_sym->host_sym), SYMNAME(reduction_sym->private_sym)) == 0) {
      return omp_sym;
    }
  }

  return NULL;
}

// Returns the nth reduction-sym in \p tinfo by keeping track of duplicate
// MP_REDUCTIONITEMs.
static OMPACCEL_RED_SYM *get_ompaccel_reduction_sym(OMPACCEL_TINFO *tinfo, int n) {
  std::set<SPTR> seen_sym;

  for (int i = 0; i < tinfo->n_reduction_symbols; i++) {
    OMPACCEL_RED_SYM *reduction_sym = &(tinfo->reduction_symbols[i]);

    // There are scenarios in which flang emits 2 MP_REDUCTIONITEM ilms
    // for a single reduction variable. We keep track of those duplicates to get
    // the "real" nth reduction symbol.
    if (seen_sym.find(reduction_sym->private_sym) == seen_sym.end())
      seen_sym.insert(reduction_sym->private_sym);
    else
      n++;
    if (i == n) { return reduction_sym; }
  }

  return NULL;
}

void ompaccel_x86_emit_reduce(OMPACCEL_TINFO *tinfo) {
  bool debug_me = false;
  SPTR func_sptr = gbl.currsub;

  // Emit the reduction code only for target function.
  if (tinfo->func_sptr != func_sptr) {
    return;
  }

  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);

  // If we already did the reduction, then ignore.
  if (ompaccel_x86_reduced_func_set.find(mangled_sptr) !=
      ompaccel_x86_reduced_func_set.end())
    return;

  std::set<SPTR> reduced_syms;
  for (int i = 0; i < tinfo->n_reduction_symbols; i++) {

    OMPACCEL_RED_SYM *reduction_sym = &(tinfo->reduction_symbols[i]);
    OMPACCEL_SYM *ompaccel_sym = get_ompaccel_sym_for(reduction_sym, tinfo);
    SPTR device_sym = ompaccel_sym->device_sym;
    SPTR host_sym = ompaccel_sym->device_sym;

    // If already reduced (happens incase there are multiple MP_REDUCTIONITEM
    // for one reduction variable).
    if (reduced_syms.find(device_sym) != reduced_syms.end()) { continue; }

    if (debug_me) {
      printf("[ompaccel-x86] Reducing device_sym: %s private_sym: %s with redop: %d in %s\n",
          getprint(device_sym), getprint(reduction_sym->private_sym), reduction_sym->redop,
          getprint(func_sptr));
    }

    int ili = mk_reduction_op(reduction_sym->redop,
        mk_ompaccel_ldsptr(device_sym), DTYPEG(host_sym),
        mk_ompaccel_ldsptr(reduction_sym->private_sym), DTYPEG(reduction_sym->private_sym));

    ili = mk_ompaccel_store(ili, DTYPEG(reduction_sym->private_sym), 0, mk_address(device_sym));

    chk_block(ili);
    reduced_syms.insert(device_sym);
  }

  ompaccel_x86_reduced_func_set.insert(mangled_sptr);
}

void ompaccel_x86_fix_arg_types(SPTR func_sptr) {
  bool debug_me = false;
  int func_paramct = PARAMCTG(func_sptr);
  int func_dpsc = DPDSCG(func_sptr);
  int start_idx = 0, adjust_idx = 0;

  // See the comments in ompaccel_x86_gen_fork_entry() regarding "x86 offloading
  // friendly" variables. The same applies for args in target function that are
  // entered via omp-runtime interfaces.
  if (!gbl.ompaccel_intarget)
    return;

  if (ompaccel_x86_is_fork_wrapper_func(func_sptr))
    return;

  // -Mx,232,0x1 implementation of parallel and teams expansion uses the
  // ompaccel_x86_fork_call() which adds tid_args and fixes the arg types of the
  // callback. So func_sptr with tid_args are already fixed.
  if (XBIT(232, 0x1) && ompaccel_x86_has_tid_args(func_sptr)) {
    return;
  }

  if (ompaccel_x86_has_tid_args(func_sptr)) {
    // Then skip the first 2 tid args.
    adjust_idx = 2;
    func_paramct -= 2;
  }

  OMPACCEL_TINFO *tinfo = ompaccel_tinfo_get(func_sptr);

  // Remember all the reduction symbols of func_sptr so that we can blacklist
  // them during the type update.
  std::set<SPTR> reduc_syms;
  for (int i = 0; i < tinfo->n_reduction_symbols; i++) {
    OMPACCEL_RED_SYM *reduction_sym = &(tinfo->reduction_symbols[i]);
    OMPACCEL_SYM *ompaccel_sym = get_ompaccel_sym_for(reduction_sym, tinfo);

    if (!ompaccel_sym)
      continue;
    SPTR device_sym = ompaccel_sym->device_sym;

    if (PASSBYVALG(device_sym))
      continue;

    reduc_syms.insert(device_sym);
  }

  for (int i = 0; i < func_paramct; i++) {
    SPTR arg_sptr = (SPTR)aux.dpdsc_base[func_dpsc + i + adjust_idx];
    if (DTY(DTYPEG(arg_sptr)) != TY_ARRAY &&
#if 1 // aocc flang does not have these two lines
        DTY(DTYPEG(arg_sptr)) != TY_CMPLX &&
        DTY(DTYPEG(arg_sptr)) != TY_DCMPLX &&
#endif
        (DTY(DTYPEG(arg_sptr)) != TY_PTR)) {
      // We skip reduction variables since they'll be lowered as pointers.
      if (reduc_syms.find(arg_sptr) != reduc_syms.end()) { continue; }

      DTYPEP(arg_sptr, DT_INT8);
      if (XBIT(232, 0x1)) {
        // FIXME! This condition is not suppose to happen, but it does in
        // -Mx,232,0x1.
        if (PASSBYVALG(arg_sptr) == PASSBYREFG(arg_sptr) &&
            PASSBYREFG(arg_sptr) == 1) {
          PASSBYREFP(arg_sptr, 1);
          PASSBYVALP(arg_sptr, 0);
        }
      }
      if (debug_me) {
        printf("[ompaccel-x86]: For %s setting %s's type as DT_INT8 ",
            SYMNAME(func_sptr), SYMNAME(arg_sptr));
        printf("PASSBYVAL: %d PASSBYREF: %d\n",
            PASSBYVALG(arg_sptr), PASSBYREFG(arg_sptr));
      }
    }
  }
}

void ompaccel_x86_add_parallel_func(SPTR func_sptr) {
  bool debug_me = false;
  if (debug_me)
    printf("[ompaccel-x86]: adding as parallel: %s\n", SYMNAME(func_sptr));
  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  ompaccel_x86_parallel_func_set.insert(mangled_sptr);
  return;
}

bool ompaccel_x86_is_parallel_func(SPTR func_sptr) {
  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  if (ompaccel_x86_parallel_func_set.find(mangled_sptr) !=
      ompaccel_x86_parallel_func_set.end())
    return true;
  else
    return false;
}

bool ompaccel_x86_is_toplevel_parallel_func(SPTR func_sptr) {
  // TODO. must check for cases when the parallel func is invoked by another
  // outlined func in device.
  return ompaccel_x86_is_parallel_func(func_sptr);
}

void ompaccel_x86_add_fork_wrapper_func(SPTR func_sptr) {
  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  ompaccel_x86_fork_wrapper_func_set.insert(mangled_sptr);
  return;
}

bool ompaccel_x86_is_fork_wrapper_func(SPTR func_sptr) {
  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  if (ompaccel_x86_fork_wrapper_func_set.find(mangled_sptr) !=
      ompaccel_x86_fork_wrapper_func_set.end())
    return true;
  else
    return false;
}

bool ompaccel_x86_is_entry_func(SPTR func_sptr) {
  if (OMPACCFUNCKERNELG(func_sptr)) {
    // Most likely an outlined parallel function, we should only add the
    // fork_wrapper func corresponding to this.
    if (ompaccel_x86_is_parallel_func(func_sptr)) {
      if (XBIT(232, 0x1))
        return true;

      return false;
    } else {

      // Should be a non parallel outlined function which we can enter directly.
      return true;
    }
  }

  // In the case of a non outlined function, the only functions considered as
  // entry are the fork-wrapper generated ones.
  if (ompaccel_x86_is_fork_wrapper_func(func_sptr))
    return true;
  return false;
}

static std::set<std::string> ompaccel_x86_tid_ready;

bool ompaccel_x86_has_tid_args(SPTR func_sptr) {
  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  if (ompaccel_x86_tid_ready.find(mangled_sptr)
      != ompaccel_x86_tid_ready.end())
    return true;
  return false;
}

void ompaccel_x86_add_tid_params(SPTR func_sptr) {

  int func_dpsc = DPDSCG(func_sptr);
  int func_paramct = PARAMCTG(func_sptr);
  int sym;
  SPTR orig_params[func_paramct];

  // If we already added the tid params for func_sptr then ignore.
  if (ompaccel_x86_has_tid_args(func_sptr)) {
    if (func_paramct >= 2) {
      if (strcmp(getprint((SPTR)aux.dpdsc_base[func_dpsc + 0]),
            "global_tid") == 0 &&
          strcmp(getprint((SPTR)aux.dpdsc_base[func_dpsc + 1]),
            "bound_tid") == 0) {
        return;
      }
    }
  }

  // Store all the original params
  for (int i = 0; i < func_paramct; i++) {
    orig_params[i] = (SPTR)aux.dpdsc_base[func_dpsc + i];
  }

  // Expand the argument array memory
  // (the +100 bit is copied from llMakeFtnOutlinedSignatureTarget())
  NEED(aux.dpdsc_avl + func_paramct + 2, aux.dpdsc_base, int, aux.dpdsc_size,
    aux.dpdsc_size + func_paramct + 2 + 100);

  DPDSCP(func_sptr, aux.dpdsc_avl);

  // Prepend the thread-id params.
  sym = mk_ompaccel_addsymbol("global_tid", DT_INT, SC_DUMMY, ST_VAR);
  OMPACCDEVSYMP(sym, TRUE);

  if (XBIT(232, 0x1)) {
    PASSBYREFP(sym, 1);
    PASSBYVALP(sym, 0);
  }

  aux.dpdsc_base[aux.dpdsc_avl + 0] = sym;

  sym = mk_ompaccel_addsymbol("bound_tid", DT_INT, SC_DUMMY, ST_VAR);
  OMPACCDEVSYMP(sym, TRUE);

  if (XBIT(232, 0x1)) {
    PASSBYREFP(sym, 1);
    PASSBYVALP(sym, 0);
  }

  aux.dpdsc_base[aux.dpdsc_avl + 1] = sym;

  // Append the original params.
  for (int i = 0; i < func_paramct; i++) {
    aux.dpdsc_base[aux.dpdsc_avl + 2 + i] = orig_params[i];
  }

  // Update the param-count and aux DS
  PARAMCTP(func_sptr, func_paramct + 2);
  aux.dpdsc_avl += func_paramct + 2;

  std::string mangled_sptr = ompaccel_x86_get_mangled_sptr(func_sptr);
  ompaccel_x86_tid_ready.insert(mangled_sptr);
}

void ompaccel_x86_gen_fork_wrapper(SPTR target_func) {
  // TODO: Perhaps add special "Q" flags for x86 offloading ?
  bool debug_me = false;
  static long func_id = 0;

  // Must be a valid outlined function
  if (!target_func || !gbl.outlined)
    return;

  // Must be a function that's expected to be parallelized.
  if (!ompaccel_x86_is_toplevel_parallel_func(target_func))
    return;

  assert(ompaccel_x86_has_tid_args(target_func),
      "Expecting the fork-wrapper's target function to have tid args",
      target_func, ERR_Fatal);

  SPTR orig_func = gbl.currsub;
  int orig_bih = expb.curbih;

  char func_name[1024];
  // device functions gets "_" in the end.
  sprintf(func_name, "%s_x86_entry_", SYMNAME(target_func));
  SPTR func_sptr;

  int target_func_args_count;
  OMPACCEL_TINFO *omptinfo;
  omptinfo = ompaccel_tinfo_get(target_func);

  target_func_args_count = PARAMCTG(target_func) - 2; // - 2 to exclude tid args
  SPTR func_args[target_func_args_count];

  if (debug_me) {
    printf("[ompaccel-x86]: Fork wrapper target: %s (SPTR: %d) with %d arg(s)\n",
        SYMNAME(target_func), target_func, target_func_args_count);
  }

  int target_func_dpsc = DPDSCG(target_func);
  for (int i = 0; i < target_func_args_count; ++i) {
    SPTR dev_sptr = (SPTR)aux.dpdsc_base[target_func_dpsc + i + 2]; // + 2 to skip the tid args

    // We make each sptr names unique so that we can work on them without
    // accidentally modifying another sptr with the same name (and usually the
    // same sptr number). Although naming is a trivial thing, flang's symbol
    // creation APIs force us to make unique names across the working
    // gbl.currsub.
    char new_arg_name[1024];
    sprintf(new_arg_name, "%s_%d_%dx86", SYMNAME(dev_sptr), func_id, i);

    // Every argument must be "x86 offloading friendly". ie it should transfer
    // correctly via ffi_call() of libomptarget. So far, I only found pointers and
    // i64 in the LLVM-type-system that works for almost all cases.
    func_args[i] = mk_ompaccel_addsymbol(new_arg_name, DT_INT8, SC_DUMMY, STYPEG(dev_sptr));
    PASSBYVALP(func_args[i], 0);
    PASSBYREFP(func_args[i], 1);
  }

  func_sptr = mk_ompaccel_function(func_name, target_func_args_count,
      func_args, /* device_func */true);

  // FIXME: The function we're generating is not an
  // oulined function. If you see gen_ref_arg() which
  // stb_process_routine_parameters() eventually call if params are references,
  // there is a hard-coded "special" handling for outlined func.
  //
  // The following line is a lie! But a necessary one due to the inconsistency
  // described above.
  OUTLINEDP(func_sptr, 1);

  cr_block();
  int ilix = ll_make_kmpc_fork_call_variadic(target_func, target_func_args_count,
      func_args);

  iltb.callfg = 1;
  chk_block(ilix);
  wr_block();
  mk_ompaccel_function_end(func_sptr);
  func_id++;

  ompaccel_x86_add_fork_wrapper_func(func_sptr);
  schedule();
  assemble();
  gbl.currsub = orig_func;
  gbl.func_count++;

  if (debug_me) {
    LL_Type *ll_ty = make_lltype_from_sptr(func_sptr);
    printf("[ompaccel-x86]: Made fork wrapper %s of type %s\n",
        SYMNAME(func_sptr), ll_ty->str);
  }
  return;
}

int ompaccel_x86_fork_call(SPTR outlined_func, int kmpc_api) {
  int nargs, nme, ili, i;
  SPTR sptr;
  OMPACCEL_TINFO *omptinfo;
  omptinfo = ompaccel_tinfo_get(outlined_func);
  nargs = omptinfo->n_symbols;
  int args[nargs + 2], garg_ilis[nargs + 2];
  DTYPE arg_dtypes[nargs + 2];
  SPTR sptr_args[nargs + 2];

  DTYPEP(outlined_func, DT_NONE);
  STYPEP(outlined_func, ST_PROC);
  CFUNCP(outlined_func, 1);

  for (i = 0; i < nargs; ++i) {
    sptr_args[i] = omptinfo->symbols[i].host_sym;
  }

  ompaccel_x86_fix_arg_types(outlined_func);
  ompaccel_x86_add_tid_params(outlined_func);

  // The fork_call should be aware of the callback's type here
  ll_process_routine_parameters(outlined_func);
  return ll_make_kmpc_fork_call_variadic2(outlined_func, nargs, sptr_args);
}

#endif
