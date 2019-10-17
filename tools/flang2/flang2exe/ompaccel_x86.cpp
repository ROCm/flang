/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for x86-64 OpenMP offloading
 * Last modified: Oct 2019
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

static std::set<SPTR> ompaccel_x86_parallel_func_set;
static std::set<SPTR> ompaccel_x86_fork_wrapper_func_set;
static std::set<SPTR> ompaccel_x86_reduced_func_set;

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

  // If we already did the reduction, then ignore.
  if (ompaccel_x86_reduced_func_set.find(func_sptr) !=
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

  ompaccel_x86_reduced_func_set.insert(func_sptr);
}

void ompaccel_x86_add_parallel_func(SPTR func_sptr) {
  bool debug_me = false;
  if (debug_me)
    printf("[ompaccel-x86]: adding as parallel: %s\n", SYMNAME(func_sptr));
  ompaccel_x86_parallel_func_set.insert(func_sptr);
  return;
}

bool ompaccel_x86_is_parallel_func(SPTR func_sptr) {
  if (ompaccel_x86_parallel_func_set.find(func_sptr) !=
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
  ompaccel_x86_fork_wrapper_func_set.insert(func_sptr);
  return;
}

bool ompaccel_x86_is_fork_wrapper_func(SPTR func_sptr) {
  if (ompaccel_x86_fork_wrapper_func_set.find(func_sptr) !=
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

void ompaccel_x86_add_tid_params(SPTR func_sptr) {
  static std::set<SPTR> processed_func;

  // If we already added the tid params for func_sptr then ignore.
  if (processed_func.find(func_sptr) != processed_func.end())
    return;

  int func_dpsc = DPDSCG(func_sptr);
  int func_paramct = PARAMCTG(func_sptr);
  int sym;
  SPTR orig_params[func_paramct];

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
  aux.dpdsc_base[aux.dpdsc_avl + 0] = sym;

  sym = mk_ompaccel_addsymbol("bound_tid", DT_INT, SC_DUMMY, ST_VAR);
  OMPACCDEVSYMP(sym, TRUE);
  aux.dpdsc_base[aux.dpdsc_avl + 1] = sym;

  // Append the original params.
  for (int i = 0; i < func_paramct; i++) {
    aux.dpdsc_base[aux.dpdsc_avl + 2 + i] = orig_params[i];
  }

  // Update the param-count and aux DS
  PARAMCTP(func_sptr, func_paramct + 2);
  aux.dpdsc_avl += func_paramct + 2;
  processed_func.insert(func_sptr);
}

void ompaccel_x86_gen_fork_wrapper(SPTR target_func) {
  // TODO: Perhaps add special "Q" flags for x86 offloading ?
  bool debug_me = false;

  // Must be a valid outlined function
  if (!target_func || !gbl.outlined)
    return;

  // Must be a function that's expected to be parallelized.
  if (!ompaccel_x86_is_toplevel_parallel_func(target_func))
    return;

  SPTR orig_func = gbl.currsub;
  int orig_bih = expb.curbih;

  char func_name[1024];
  // device functions gets "_" in the end.
  sprintf(func_name, "%s_x86_entry_", SYMNAME(target_func));
  SPTR func_sptr;

  int target_func_args_count;
  OMPACCEL_TINFO *omptinfo;
  omptinfo = ompaccel_tinfo_get(target_func);

  target_func_args_count = omptinfo->n_symbols;
  SPTR func_args[target_func_args_count];

  if (debug_me) {
    printf("[ompaccel-x86]: Fork wrapper target: %s (SPTR: %d) with %d args\n",
        SYMNAME(target_func), target_func, target_func_args_count);
  }

  for (int i = 0; i < target_func_args_count; ++i) {
    SPTR dev_sptr = omptinfo->symbols[i].device_sym;
    SPTR host_sptr = omptinfo->symbols[i].host_sym;

    char new_arg_name[1024];
    sprintf(new_arg_name, "%s_x86", SYMNAME(dev_sptr));

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
#endif
