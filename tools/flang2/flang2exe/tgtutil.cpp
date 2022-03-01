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
 * Changes to support AMDGPU OpenMP offloading
 * Last modified: August 2020
 *
 * Support for x86-64 OpenMP offloading
 * Last modified: Sept 2019
 * Last Modified: Jun 2020
 */

/** \file
 * \brief tgtutil.c - Various definitions for the libomptarget runtime
 *
 */

#define _GNU_SOURCE // for vasprintf()
#include <stdio.h>
#undef _GNU_SOURCE
#include "dinit.h"
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
#include "iliutil.h"
#include "llutil.h"
#include "ompaccel.h"
#include "tgtutil.h"
#include "assem.h"
#include "dinitutl.h"
#include "cgllvm.h"
#include "cgmain.h"
#include "regutil.h"
#include "dtypeutl.h"
#include "llassem.h"
#include "symfun.h"
#include "ccffinfo.h"

// AOCC Begin
#ifdef OMP_OFFLOAD_AMD
#include <vector>
#include <algorithm>
// Vector to keep track all array accesses with constant offset within device.
extern std::vector<SPTR> constArraySymbolList;
#endif
static int updateregion = 0;
// AOCC End
#ifdef OMP_OFFLOAD_LLVM
static void change_target_func_smbols(int outlined_func_sptr, int stblk_sptr);
// AOCC additional argument
//static SPTR init_tgt_target_syms(const char *kernelname);
static SPTR init_tgt_target_syms(const char *kernelname, SPTR sptr = SPTR_NULL); 
#endif

#if defined(OMP_OFFLOAD_LLVM) || defined(OMP_OFFLOAD_PGI)

#define MXIDLEN 100
int dataregion = 0;

static DTYPE tgt_offload_entry_type = DT_NONE;
extern int HasRequiresUnifiedSharedMemory;

/* Flags for use with the entry */
#define DT_VOID_NONE DT_NONE

#ifdef __cplusplus
static class ClassTgtApiCalls
{
public:
  const struct tgt_api_entry_t operator[](int off)
  {
    switch (off) {
    case TGT_API_BAD:
      return {"__INVALID_TGT_API_NAME__", -1, (DTYPE)-1};
    case TGT_API_REGISTER_LIB:
      return {"__tgt_register_lib", 0, DT_NONE};
      // AOCC begin
    case TGT_API_REGISTER_REQUIRES:
      return {"__tgt_register_requires", 0, DT_NONE};
      // AOCC end
    case TGT_API_TARGET:
      return {"__tgt_target", 0, DT_INT};
    case TGT_API_TARGET_TEAMS:
      return {"__tgt_target_teams", 0, DT_INT};
    case TGT_API_TARGET_DATA_BEGIN:
      return {"__tgt_target_data_begin", 0, DT_NONE};
    case TGT_API_TARGET_DATA_END:
      return {"__tgt_target_data_end", 0, DT_NONE};
    case TGT_API_TARGETUPDATE:
      return {"__tgt_target_data_update", 0, DT_NONE};
    default:
      return {nullptr, 0, DT_NONE};
    }
  }
} tgt_api_calls;
#else
static const struct tgt_api_entry_t tgt_api_calls[] = {
    [TGT_API_BAD] = {"__INVALID_TGT_API_NAME__", -1, -1},
    [TGT_API_REGISTER_LIB] = {"__tgt_register_lib", 0, DT_VOID_NONE},
    // AOCC begin
    [TGT_API_REGISTER_REQUIRES] = {"__tgt_register_requires", 0, DT_VOID_NONE},
    // AOCC end
    [TGT_API_TARGET] = {"__tgt_target", 0, DT_INT},
    [TGT_API_TARGET_TEAMS] = {"__tgt_target_teams", 0, DT_INT},
    [TGT_API_TARGET_TEAMS_PARALLEL] = {"__tgt_target_teams_parallel", 0, DT_INT},
    [TGT_API_TARGET_DATA_BEGIN] = {"__tgt_target_data_begin", 0, DT_VOID_NONE},
    [TGT_API_TARGET_DATA_END] = {"__tgt_target_data_end", 0, DT_VOID_NONE},
    [TGT_API_TARGETUPDATE] = {"__tgt_target_data_update", 0, DT_VOID_NONE}};
#endif
static int
gen_null_arg()
{
  int con, ili;
  INT tmp[2];

  tmp[0] = 0;
  tmp[1] = 0;
  con = getcon(tmp, DT_INT);
  ili = ad1ili(IL_ACON, con);
  return ili;
}
/* Return ili (icon/kcon, or a loaded value) for use with mk_kmpc_api_call
 * arguments.
 */
static int
ld_sptr(SPTR sptr)
{
  ISZ_T sz = size_of(DTYPEG(sptr));

  if (STYPEG(sptr) == ST_CONST) {
    if (sz == 8)
      return ad_kcon(CONVAL1G(sptr), CONVAL2G(sptr));
    return ad_icon(CONVAL2G(sptr));
  } else {
    int nme = addnme(NT_VAR, sptr, 0, 0);
    int ili = mk_address(sptr);
    if (ILI_OPC(ili) == IL_LDA)
      nme = ILI_OPND(ili, 2);
    if(DTYPEG(sptr) == DT_DBLE)
      return ad3ili(IL_LDDP, ili, nme, MSZ_I8);
    else if (sz == 8)
      return ad3ili(IL_LDKR, ili, nme, MSZ_I8);
    else
      return ad3ili(IL_LD, ili, nme, mem_size(DTY(DTYPEG(sptr))));
  }
}

#define TGT_CHK(_api) \
  (((_api) > TGT_API_BAD && (_api) < TGT_API_N_ENTRIES) ? _api : TGT_API_BAD)

#define TGT_NAME(_api) tgt_api_calls[TGT_CHK(_api)].name
#define TGT_RET_DTYPE(_api) tgt_api_calls[TGT_CHK(_api)].ret_dtype
#define TGT_RET_ILIOPC(_api) tgt_api_calls[TGT_CHK(_api)].ret_iliopc

/* The return value is allocated and maintained locally, please do not call
 * 'free' on this, bad things will probably happen.
 *
 * Caller is responsible for calling va_end()
 *
 * This function will maintain one allocation for unique function name.
 */
static const char *
build_tgt_api_name(int tgt_api)
{
  static hashmap_t names; /* Maintained in this routine */

  if (!names)
    names = hashmap_alloc(hash_functions_strings);

  return TGT_NAME(tgt_api);
}

static int
ll_make_tgt_proto(const char *nm, int tgt_api, int argc, DTYPE *args)
{
  DTYPE ret_dtype;
  /* args contains a list of dtype.  The actual sptr of args will be create in
     ll_make_ftn_outlined_params.
   */
  const SPTR func_sptr = getsymbol(nm);

  ret_dtype = TGT_RET_DTYPE(tgt_api);

  DTYPEP(func_sptr, ret_dtype);
  SCP(func_sptr, SC_EXTERN);
  STYPEP(func_sptr, ST_PROC);
  CCSYMP(func_sptr,
         1); /* currently we make all CCSYM func varargs in Fortran. */
  CFUNCP(func_sptr, 1);
  ll_make_ftn_outlined_params(func_sptr, argc, args);
  ll_process_routine_parameters(func_sptr);
  return func_sptr;
}

/* Returns the function prototype sptr.
 * 'reg_opc'   ILI op code for return value, e.g., IL_DFRIR or 0 if void
 * 'ret_dtype' dtype representing return value
 */
static int
mk_tgt_api_call(int tgt_api, int n_args, DTYPE *arg_dtypes, int *arg_ilis)
{
  int i, ilix, altilix, gargs, garg_ilis[n_args];
  SPTR fn_sptr;
  const char *nm;
  const ILI_OP ret_opc = (ILI_OP)TGT_RET_ILIOPC(tgt_api);
  const DTYPE ret_dtype = TGT_RET_DTYPE(tgt_api);

  /* Create the prototype for the API call */
  nm = build_tgt_api_name(tgt_api);
  fn_sptr = (SPTR)ll_make_tgt_proto(nm, tgt_api, n_args, arg_dtypes);
  sym_is_refd(fn_sptr);

  /* Update ACC routine tables and then create the JSR */
  update_acc_with_fn(fn_sptr);
  ilix = ll_ad_outlined_func2(ret_opc, IL_JSR, fn_sptr, n_args, arg_ilis);

  /* Create the GJSR */
  for (i = n_args - 1; i >= 0; --i) /* Reverse the order */
    garg_ilis[i] = arg_ilis[n_args - 1 - i];
  gargs = ll_make_outlined_garg(n_args, garg_ilis, arg_dtypes);
  altilix = ad3ili(IL_GJSR, fn_sptr, gargs, 0);

  /* Add gjsr as an alt to the jsr */
  if (ret_opc)
    ILI_ALT(ILI_OPND(ilix, 1)) = altilix;
  else
    ILI_ALT(ilix) = altilix;

  return ilix;
}

SPTR
make_array_sptr(char *name, DTYPE atype, int arraysize)
{
  SPTR array;
  DTYPE dtype;
  array = getsymbol(name);
  STYPEP(array, ST_ARRAY);
  CCSYMP(array, 1);
  {
    ADSC *adsc;
    INT con[2] = {0, arraysize};

    dtype = get_array_dtype(1, atype);
    adsc = AD_DPTR(dtype);
    AD_LWBD(adsc, 0) = stb.i1;
    AD_UPBD(adsc, 0) = getcon(con, DT_INT);
    AD_NUMELM(adsc) = AD_UPBD(adsc, 0);
  }

  DTYPEP(array, dtype);
  SCP(array, SC_AUTO);
  return array;
} /* make_array_sptr*/

// AOCC Begin
static bool
is_complex_dtype(DTYPE dtype) {
  if (dtype == DT_CMPLX || dtype == DT_DCMPLX || dtype == DT_QCMPLX)
    return true;
  return false;
}
// AOCC End

static int
_tgt_target_fill_size(SPTR sptr, int map_type, int base_ili)
{
  DTYPE dtype = DTYPEG(sptr);
  int ilix, rilix;
  ADSC *ad;
  if(llis_pointer_kind(dtype)) {
    if (map_type & OMP_TGT_MAPTYPE_IMPLICIT) {
      ilix = ad_kconi(0);
    } else
      /* find the size of pointee */
      ilix = ad_kconi(size_of(DTySeqTyElement(dtype)));
  // AOCC Begin
  } else if (is_complex_dtype(dtype)) {
    ilix = ad_kconi(size_of(dtype));
  // AOCC End
  }
  else if (llis_vector_kind(dtype)) {
    ompaccelInternalFail("Vector data type is not implemented, cannot be passed to target region. ");
  } else if (llis_struct_kind(dtype)) {
    // AOCC Begin
//  ompaccelInternalFail("Struct data type is not implemented, cannot be passed to target region. ");
    int size =  DTyArrayDesc(dtype);
    ilix = ad_icon(size);
    // AOCC End
  } else if (llis_function_kind(dtype)) {
    ompaccelInternalFail("Function data type is not implemented, cannot be passed to target region. ");
  } else if (llis_integral_kind(dtype) || dtype == DT_DBLE || dtype == DT_FLOAT) {
    ilix = ad_kconi(size_of(dtype));
  } else if(llis_array_kind(dtype)) {
    if(map_type & OMP_TGT_MAPTYPE_IMPLICIT) {
      ilix = ad_kconi(0);
    } else {
      ad = AD_DPTR(dtype);
      if (SCG(sptr) == SC_STATIC) {
        ISZ_T size;
        int j, numdim = AD_NUMDIM(ad);
        size = 1;
        for (j = 0; j < numdim; ++j) {
          size = size * CONVAL2G(AD_UPBD(ad, j)) - CONVAL2G(AD_LWBD(ad, j)) + 1;
        }
        size = size_of((DTYPE)DTyAlgTyMember(dtype)) * size;
        ilix = ad_icon(size);
      } else {
        int numdim = AD_NUMDIM(ad);
        int j;
        ilix = ad_kconi(1);

        // AOCC Begin
        // For allocatable arrays section descriptor stores array size.
#ifdef OMP_OFFLOAD_AMD
        bool all_zero = true;
        for (j = 0; j < numdim; ++j) {
          if (AD_UPBD(ad, j) != 0 || AD_LWBD(ad, j) != 0) {
            all_zero = false;
          }
        }
        if (AD_SDSC(ad) && SDSCG(sptr) && all_zero) {
          SPTR sdsc = SDSCG(sptr);
          int nme = addnme(NT_VAR, sdsc, 0, 0);

          // 6th Element in section descriptor is size, 48 = 6 * 8(INT8)
          if (SCG(sdsc) == SC_NONE && base_ili) {
            ilix = ad3ili(IL_AADD, base_ili, ad_aconi(ADDRESSG(sdsc)), 0);
            ilix = ad3ili(IL_AADD, ilix, ad_aconi(48), 0);
            ilix = ad3ili(IL_LD, ilix, nme, MSZ_WORD);
          } else {
            ilix = ad3ili(IL_LD, ad_acon(sdsc, 48), nme, MSZ_WORD);
          }
          ilix = ad2ili(IL_KMUL, ilix, ad_kconi(size_of(DTySeqTyElement(dtype))));
          return ilix;
        }
#endif
        // AOCC End

        // todo ompaccel we do not support partial arrays here.
        for (j = 0; j < numdim; ++j) {
          if (AD_UPBD(ad, j) != 0) {
            SPTR ub = (SPTR) AD_UPBD(ad, j);
            SPTR lb = (SPTR) AD_LWBD(ad, j);
            rilix = ad2ili(IL_KSUB, ld_sptr(ub), ld_sptr(lb));
            rilix = ad2ili(IL_KADD, rilix, ad_kconi(1));
          } else
            rilix = ad2ili(IL_KADD, ad_kconi(0), ad_kconi(1));
          ilix = ad2ili(IL_KMUL, ilix, rilix);
        }
        if (DTY( (DTYPE) DTY((DTYPE) (dtype + 1))) != TY_STRUCT)  // AOCC
          ilix = ad2ili(IL_KMUL, ilix, ad_kconi(size_of(DTySeqTyElement(dtype))));
        // AOCC Begin
        else
          ilix = ad2ili(IL_KMUL, ilix,
                     ad_kconi(DTyArrayDesc(DTYPE((DTY((DTYPE)(dtype + 1)))))));
        // AOCC End
      }
    }
  }else {
    ompaccelInternalFail("Unknown data type");
  }
  return ilix;
}

static int
_tgt_target_fill_maptype(SPTR sptr, int maptype, int isMidnum, int midnum_maptype) {
  int final_maptype = 0;
  /*todo ompaccel there are many cases to be covered. It is not completed yet. */
  if(isMidnum)
    final_maptype |= midnum_maptype;
  else if(maptype == 0) {
    // AOCC Modification: Moving logical or of OMP_TGT_MAPTYPE_TARGET_PARAM
    //                    to end of this function. This was moved here in
    //                    Commit 1bd2b5172c227e09208b987cee27b2bcd720eed5
    final_maptype = OMP_TGT_MAPTYPE_IMPLICIT;
  } else
    final_maptype = maptype;

  DTYPE dtype = DTYPEG(sptr);
  if(final_maptype & OMP_TGT_MAPTYPE_IMPLICIT) {
    if (llis_pointer_kind(dtype)) {

    } else if (llis_array_kind(dtype)) {

    // AOCC Begin
    } else if (is_complex_dtype(dtype)) {
      final_maptype |= OMP_TGT_MAPTYPE_LITERAL;
    // AOCC End
    } else if (llis_vector_kind(dtype)) {
      ompaccelInternalFail("Don't know how to implicitly define map type for vector data type ");
    } else if (llis_integral_kind(dtype) || dtype == DT_DBLE || dtype == DT_FLOAT) {
      final_maptype |= OMP_TGT_MAPTYPE_LITERAL;
    } else if (llis_function_kind(dtype)) {
      ompaccelInternalFail("Don't know how to implicitly define map type for function data type ");
    } else if (llis_struct_kind(dtype)) {
      final_maptype |= OMP_TGT_MAPTYPE_LITERAL;
    } else {
      ompaccelInternalFail("Unknown data type");
    }
  }

  // AOCC Modification: Adding back this, this was moved up in
  //                    Commit 1bd2b5172c227e09208b987cee27b2bcd720eed5
  final_maptype |= OMP_TGT_MAPTYPE_TARGET_PARAM;
  return final_maptype;
}

void
tgt_target_fill_params(SPTR arg_base_sptr, SPTR arg_size_sptr, SPTR args_sptr,
                       SPTR args_maptypes_sptr, OMPACCEL_TINFO *targetinfo)
{
  int i, j, ilix, iliy;
  char *name_base="", *name_length="";
  // AOCC Begin
#ifdef OMP_OFFLOAD_AMD
  int temp_map_type = 0;
#endif
  // AOCC End
  OMPACCEL_SYM midnum_sym;
  DTYPE param_dtype, load_dtype;
  SPTR param_sptr;
  LOGICAL isPointer, isArray, isMidnum, showMinfo, isThis, isStruct; //AOCC
  /* fill the arrays */
  /* Build the list: (size, sptr) pairs. */

  // AOCC Begin.
  // This part of code to be emitted in host module, so disable the flag
  bool old_intarget  = gbl.ompaccel_intarget;
  gbl.ompaccel_intarget = false;
  // AOCC End

  for (i = 0; i < targetinfo->n_symbols; ++i) {
    int nme_args, nme_size, nme_base, nme_types;
    nme_args = add_arrnme(NT_ARR, args_sptr, addnme(NT_VAR, args_sptr, 0, 0), 0, ad_icon(i), FALSE);
    nme_size = add_arrnme(NT_ARR, arg_size_sptr, addnme(NT_VAR, arg_size_sptr, 0, 0), 0, ad_icon(i), FALSE);
    nme_base = add_arrnme(NT_ARR, arg_base_sptr, addnme(NT_VAR, arg_base_sptr, 0, 0), 0, ad_icon(i), FALSE);
    nme_types = add_arrnme(NT_ARR, args_maptypes_sptr, addnme(NT_VAR, args_maptypes_sptr, 0, 0), 0, ad_icon(i), FALSE);

    isMidnum = FALSE;
    param_sptr = targetinfo->symbols[i].host_sym;
    param_dtype = DTYPEG(param_sptr);
    isPointer = llis_pointer_kind(param_dtype);
    //AOCC Begin
    isArray = llis_array_kind(param_dtype);
    isStruct = llis_struct_kind(param_dtype) && !is_complex_dtype(param_dtype);
    //AOCC End

    /* This is for fortran allocatable arrays.
     * We keep the base symbol as a quiet symbol that has the map type info.
     * When the symbol is a pointer, it's base symbol might be in the quiet symbol list.
     * Then we should look for its map type.
     */
    if(isPointer) {
      for (j = 0; j < targetinfo->n_quiet_symbols; ++j) {
        SPTR midnum_sptr = MIDNUMG(targetinfo->quiet_symbols[j].host_sym);
        if (midnum_sptr == param_sptr || HASHLKG(midnum_sptr) == param_sptr) {
          midnum_sym = targetinfo->quiet_symbols[j];
          // AOCC Begin
          // No need to put `TO` in map type for 'target update from'
          if(targetinfo->mode == mode_target_update && 
                  targetinfo->quiet_symbols[j].map_type & OMP_TGT_MAPTYPE_FROM )
            targetinfo->quiet_symbols[j].map_type &= ~(OMP_TGT_MAPTYPE_TO);
          // AOCC End
          isMidnum = TRUE;
          break;
        }
      }
    }
    /* We want to show everything as default, but implicit symbols */
    showMinfo = true;
    /* Implicit map(to:) for the array descriptor */
    if(DESCARRAYG(param_sptr)) {
      // AOCC Begin
      if(targetinfo->mode == mode_target_update &&
                targetinfo->symbols[i].map_type & OMP_TGT_MAPTYPE_FROM)
        targetinfo->symbols[i].map_type &= ~(OMP_TGT_MAPTYPE_TO);
      else
      // AOCC End
        targetinfo->symbols[i].map_type = OMP_TGT_MAPTYPE_TARGET_PARAM | OMP_TGT_MAPTYPE_TO; 
      showMinfo = false;
    }
    // AOCC Begin
#ifdef OMP_OFFLOAD_AMD
    temp_map_type = 0;
    // As per OpenMP standards 4.5 data mapping rules, from section 2.15.5
    //   " If a variable is not a scalar then it is treated as if it had
    //     appeared in a map clause with a map-type of tofrom."
    if (targetinfo->symbols[i].map_type == 0 && (isArray || isPointer || isStruct)) {
      temp_map_type = OMP_TGT_MAPTYPE_FROM |
                      OMP_TGT_MAPTYPE_TO | OMP_TGT_MAPTYPE_TARGET_PARAM;
    }
#endif
    // AOCC End
    /* assign map type */
    targetinfo->symbols[i].map_type = _tgt_target_fill_maptype(param_sptr, targetinfo->symbols[i].map_type, isMidnum, midnum_sym.map_type);
    // AOCC Begin
#ifdef OMP_OFFLOAD_AMD
    if (temp_map_type != 0) {
      targetinfo->symbols[i].map_type = temp_map_type;
    }
    if (isMidnum) {
      // AOCC Begin
      if(targetinfo->mode == mode_target_update &&
        targetinfo->symbols[i].map_type & OMP_TGT_MAPTYPE_FROM)
          targetinfo->symbols[i].map_type &= ~(OMP_TGT_MAPTYPE_TO);
      else
      // AOCC End
        targetinfo->symbols[i].map_type |= OMP_TGT_MAPTYPE_TO;
    }
#endif
    // AOCC End

    ilix = ad4ili(IL_ST, ad_icon(targetinfo->symbols[i].map_type),
                  ad_acon(args_maptypes_sptr, i * TARGET_PTRSIZE), nme_types, MSZ_I8);
    chk_block(ilix);
    if(targetinfo->symbols[i].map_type & OMP_TGT_MAPTYPE_IMPLICIT)
      showMinfo = false;

    /* Find the base */
    if(targetinfo->symbols[i].in_map) {
      if(llis_array_kind(param_dtype))
        param_dtype = array_element_dtype(param_dtype);
      else if (llis_pointer_kind(param_dtype))
        param_dtype = DTySeqTyElement(param_dtype);
      // AOCC Begin
      // ILIs for base and lower bound symbols
      if(!ILI_OF(targetinfo->symbols[i].ili_base))
        targetinfo->symbols[i].ili_base = mk_address(param_sptr);
      if(!ILI_OF(targetinfo->symbols[i].ili_lowerbound))
        targetinfo->symbols[i].ili_lowerbound = 
                  mk_ompaccel_ldsptr(targetinfo->symbols[i].sptr_lowerbound);
      // AOCC End
      iliy = targetinfo->symbols[i].ili_base;
      ilix = mk_ompaccel_store(iliy, DT_ADDR, nme_base, ad_acon(arg_base_sptr, i * TARGET_PTRSIZE));
      /* Assign args */
      chk_block(ilix);
      ilix = ikmove(targetinfo->symbols[i].ili_lowerbound);
      ilix = mk_ompaccel_add(ilix, DT_INT8, ad_kconi(-1), DT_INT8); // AOCC
      ilix = mk_ompaccel_mul(ilix, DT_INT8, ad_kconi(size_of(param_dtype)), DT_INT8);
      ilix = sel_aconv(ilix);
      ilix = mk_ompaccel_add(iliy, DT_ADDR, ilix, DT_INT8);
      ilix = mk_ompaccel_store(ilix, DT_ADDR, nme_args, ad_acon(args_sptr, i * TARGET_PTRSIZE));
      chk_block(ilix);
    } else {
      ADSC *ad = AD_DPTR(param_dtype); // AOCC
      /* Optimization - Pass by value for scalar */
      // AOCC Modification : Removed use of uninitalized variable isThis from condition
      if (TY_ISSCALAR(DTY(param_dtype)) && (targetinfo->symbols[i].map_type & OMP_TGT_MAPTYPE_IMPLICIT) || isMidnum) {
        iliy = mk_ompaccel_ldsptr(param_sptr);
        load_dtype = param_dtype;
      // AOCC Begin
      } else if (targetinfo->symbols[i].ili_sptr && AD_SDSC(ad)
                                                 && AD_ZBASE(ad)) {
        iliy = targetinfo->symbols[i].ili_sptr;
        load_dtype = DT_ADDR;
      // AOCC End
      } else {
        iliy = mk_address(param_sptr);
        load_dtype = DT_ADDR;
      }
      /* Assign args */
      ilix = mk_ompaccel_store(iliy, load_dtype, nme_args, ad_acon(args_sptr, i * TARGET_PTRSIZE));
      chk_block(ilix);
      /* assign args_base */
      ilix = mk_ompaccel_store(iliy, load_dtype, nme_base, ad_acon(arg_base_sptr, i * TARGET_PTRSIZE));
      chk_block(ilix);
    }
    /* assign size */
    if(targetinfo->symbols[i].in_map && 
                      targetinfo->symbols[i].sptr_length != SPTR_NULL) {// AOCC
      // AOCC Begin
      // ILI for the length symbol
      if(!ILI_OF(targetinfo->symbols[i].sptr_length))
        targetinfo->symbols[i].ili_length = 
                      mk_ompaccel_ldsptr(targetinfo->symbols[i].sptr_length);
      // AOCC End
      ilix = ikmove(targetinfo->symbols[i].ili_length);
      ilix = mk_ompaccel_mul(ilix, DT_INT8, ad_kconi(size_of(param_dtype)), DT_INT8);
    } else {
      bool useMidnum = true;
      if(isMidnum) {
        DTYPE dtype = DTYPEG(midnum_sym.host_sym);
	if (llis_array_kind(dtype)) {
          ADSC *ad = AD_DPTR(dtype);
          int numdim = AD_NUMDIM(ad);
          if (numdim == 0 ) useMidnum = false;
        }
      }
      if(isMidnum && useMidnum )
        ilix = _tgt_target_fill_size(midnum_sym.host_sym,
                                     targetinfo->symbols[i].map_type,
                                     targetinfo->symbols[i].ili_base); // AOCC
      else
        ilix = _tgt_target_fill_size(param_sptr,
                                     targetinfo->symbols[i].map_type,
                                     targetinfo->symbols[i].ili_base); // AOCC
    }
    ilix = ad4ili(IL_STKR, ilix, ad_acon(arg_size_sptr, i * TARGET_PTRSIZE), nme_size,
                 TARGET_PTRSIZE == 8 ? MSZ_I8 : MSZ_WORD);
    chk_block(ilix);
  }

  // AOCC Begin
  gbl.ompaccel_intarget = old_intarget;
  // AOCC End
}

int
ll_make_tgt_target(SPTR outlined_func_sptr, int64_t device_id, SPTR stblk_sptr)
{
  SPTR sptr, arg_base_sptr, arg_size_sptr, args_sptr, args_maptypes_sptr;
  char *name, *rname;
  OMPACCEL_TINFO *targetinfo;
  int ili_hostptr;

  rname = SYMNAME(outlined_func_sptr);
  NEW(name, char, strlen(rname)+16); // AOCC

  targetinfo = ompaccel_tinfo_get(outlined_func_sptr);
#if OMP_OFFLOAD_LLVM
  // AOCC begin
  if (flg.x86_64_omptarget)
    sptr = init_tgt_target_syms(rname, outlined_func_sptr);
  else
    sptr = init_tgt_target_syms(rname);
  // AOCC end
  ili_hostptr = ad_acon(sptr, 0);
#endif
  if (targetinfo->n_symbols == 0) {
    int locargs[7];
    DTYPE locarg_types[] = {DT_INT8, DT_ADDR, DT_INT, DT_ADDR,
                            DT_ADDR, DT_ADDR, DT_ADDR};
    locargs[6] = ad_icon(device_id);
    locargs[5] = ili_hostptr;
    locargs[4] = ad_icon(targetinfo->n_symbols);
    locargs[3] = gen_null_arg();
    locargs[2] = gen_null_arg();
    locargs[1] = gen_null_arg();
    locargs[0] = gen_null_arg();
    // call the RT
    int call_ili = mk_tgt_api_call(TGT_API_TARGET, 7, locarg_types, locargs);
    return call_ili;
  } else {
    sprintf(name, "%s_base", rname);
    arg_base_sptr = make_array_sptr(name, DT_CPTR, targetinfo->n_symbols);
    sprintf(name, "%s_size", rname);
    arg_size_sptr = make_array_sptr(name, DT_INT8, targetinfo->n_symbols);
    sprintf(name, "%s_args", rname);
    args_sptr = make_array_sptr(name, DT_CPTR, targetinfo->n_symbols);
    sprintf(name, "%s_type", rname);
    args_maptypes_sptr = make_array_sptr(name, DT_INT8, targetinfo->n_symbols);

    tgt_target_fill_params(arg_base_sptr, arg_size_sptr, args_sptr,
                           args_maptypes_sptr, targetinfo);

    // prepare argument for tgt target
    int locargs[7];
    DTYPE locarg_types[] = {DT_INT8, DT_ADDR, DT_INT, DT_ADDR,
                            DT_ADDR, DT_ADDR, DT_ADDR};
    locargs[6] = ad_icon(device_id);
    locargs[5] = ili_hostptr;
    locargs[4] = ad_icon(targetinfo->n_symbols);
    locargs[3] = ad_acon(arg_base_sptr, 0);
    locargs[2] = ad_acon(args_sptr, 0);
    locargs[1] = ad_acon(arg_size_sptr, 0);
    locargs[0] = ad_acon(args_maptypes_sptr, 0);
#ifdef OMP_OFFLOAD_LLVM
    change_target_func_smbols(outlined_func_sptr, stblk_sptr);
#endif
    // call the RT
    int call_ili = mk_tgt_api_call(TGT_API_TARGET, 7, locarg_types, locargs);

    return call_ili;
  }
}

int
ll_make_tgt_target_teams(SPTR outlined_func_sptr, int64_t device_id,
                         SPTR stblk_sptr, int32_t num_teams,
                         int32_t thread_limit)
{
  SPTR sptr, arg_base_sptr, arg_size_sptr, args_sptr, args_maptypes_sptr;
  char *name, *rname;
  OMPACCEL_TINFO *targetinfo = ompaccel_tinfo_get(outlined_func_sptr);
  int ili_hostptr, nargs = targetinfo->n_symbols;
  rname = SYMNAME(outlined_func_sptr);
  NEW(name, char, strlen(rname)+16); // AOCC
#if OMP_OFFLOAD_LLVM
  // AOCC begin
  // sptr = init_tgt_target_syms(rname);
  if (flg.x86_64_omptarget)
    sptr = init_tgt_target_syms(rname, outlined_func_sptr);
  else
    sptr = init_tgt_target_syms(rname);
  // AOCC end
  ili_hostptr = ad_acon(sptr, 0);
#endif

  sprintf(name, "%s_base", rname);
  arg_base_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "%s_size", rname);
  arg_size_sptr = make_array_sptr(name, DT_INT8, nargs);
  sprintf(name, "%s_args", rname);
  args_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "%s_type", rname);
  args_maptypes_sptr = make_array_sptr(name, DT_INT8, nargs);

  tgt_target_fill_params(arg_base_sptr, arg_size_sptr, args_sptr,
                         args_maptypes_sptr, targetinfo);

  // prepare argument for tgt target
  int locargs[9];
  DTYPE locarg_types[] = {DT_INT8, DT_ADDR, DT_INT, DT_ADDR, DT_ADDR,
                          DT_ADDR, DT_ADDR, DT_INT, DT_INT};
  locargs[8] = ad_icon(device_id);
  locargs[7] = ili_hostptr;
  locargs[6] = ad_icon(nargs);
  locargs[5] = ad_acon(arg_base_sptr, 0);
  locargs[4] = ad_acon(args_sptr, 0);
  locargs[3] = ad_acon(arg_size_sptr, 0);
  locargs[2] = ad_acon(args_maptypes_sptr, 0);
  // AOCC Begin
  if (targetinfo->num_teams != SPTR_NULL) {
    int nme = addnme(NT_VAR, targetinfo->num_teams, 0, 0);
    int address = mk_address(targetinfo->num_teams);
    locargs[1] =  ad3ili(IL_LD, address, nme,
                            mem_size(DTY(DTYPEG(targetinfo->num_teams))));
  } else {
  // AOCC End
    locargs[1] = ad_icon(num_teams);
  }

  // AOCC Begin
  if (targetinfo->num_threads != SPTR_NULL) {
    int nme = addnme(NT_VAR, targetinfo->num_threads, 0, 0);
    int address = mk_address(targetinfo->num_threads);
    locargs[0] =  ad3ili(IL_LD, address, nme,
                            mem_size(DTY(DTYPEG(targetinfo->num_threads))));
  } else {

    locargs[0] = ad_icon(thread_limit);
  }
  // AOCC End
#ifdef OMP_OFFLOAD_LLVM
  change_target_func_smbols(outlined_func_sptr, stblk_sptr);
#endif
  // call the RT
  int call_ili =
      mk_tgt_api_call(TGT_API_TARGET_TEAMS, 9, locarg_types, locargs);

  return call_ili;
}

int
ll_make_tgt_target_teams_parallel(SPTR outlined_func_sptr, int64_t device_id,
                                  SPTR stblk_sptr, int32_t num_teams,
                                  int32_t thread_limit, int32_t num_threads, int32_t mode)
{
  SPTR sptr, arg_base_sptr, arg_size_sptr, args_sptr, args_maptypes_sptr;
  char *name, *rname;
  OMPACCEL_TINFO *targetinfo = ompaccel_tinfo_get(outlined_func_sptr);
  int ili_hostptr, nargs = targetinfo->n_symbols;
  rname = SYMNAME(outlined_func_sptr);
  NEW(name, char, strlen(rname)+16); // AOCC
  ili_hostptr = ad1ili(IL_ACON, get_acon(outlined_func_sptr, 0));

  sprintf(name, "%s_base", rname);
  arg_base_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "%s_size", rname);
  arg_size_sptr = make_array_sptr(name, DT_INT8, nargs);
  sprintf(name, "%s_args", rname);
  args_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "%s_type", rname);
  args_maptypes_sptr = make_array_sptr(name, DT_INT8, nargs);

  tgt_target_fill_params(arg_base_sptr, arg_size_sptr, args_sptr,
                         args_maptypes_sptr, targetinfo);

  // prepare argument for tgt target
  int locargs[11];
  DTYPE locarg_types[] = {DT_INT8, DT_ADDR, DT_INT, DT_ADDR, DT_ADDR,
                          DT_ADDR, DT_ADDR, DT_INT, DT_INT, DT_INT, DT_INT};
  locargs[10] = ad_icon(device_id);
  locargs[9] = ili_hostptr;
  locargs[8] = ad_icon(nargs);
  locargs[7] = ad_acon(arg_base_sptr, 0);
  locargs[6] = ad_acon(args_sptr, 0);
  locargs[5] = ad_acon(arg_size_sptr, 0);
  locargs[4] = ad_acon(args_maptypes_sptr, 0);
  locargs[3] = num_teams;
  locargs[2] = thread_limit;
  locargs[1] = num_threads;
  locargs[0] = ad_icon(mode);

  // call the RT
  int call_ili =
      mk_tgt_api_call(TGT_API_TARGET_TEAMS_PARALLEL, 11, locarg_types, locargs);

  return call_ili;
}

int
ll_make_tgt_target_data_begin(int device_id, OMPACCEL_TINFO *targetinfo)
{
  int call_ili, nargs;
  SPTR arg_base_sptr, args_sptr, arg_size_sptr, args_maptypes_sptr;
  char name[16];

  int locargs[6];
  DTYPE locarg_types[] = {DT_INT8, DT_INT, DT_ADDR, DT_ADDR, DT_ADDR, DT_ADDR};

  if (targetinfo == NULL) {
    interr("Map item list is not found", 0, ERR_Fatal);
  }
  nargs = targetinfo->n_symbols;

  sprintf(name, "edata%d_base", dataregion);
  arg_base_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "edata%d_size", dataregion);
  arg_size_sptr = make_array_sptr(name, DT_INT8, nargs);
  sprintf(name, "edata%d_args", dataregion);
  args_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "edata%d_type", dataregion);
  args_maptypes_sptr = make_array_sptr(name, DT_INT8, nargs);
  dataregion++;

  tgt_target_fill_params(arg_base_sptr, arg_size_sptr, args_sptr,
                         args_maptypes_sptr, targetinfo);

  locargs[5] = ad_icon(device_id);
  locargs[4] = ad_icon(nargs);
  locargs[3] = ad_acon(arg_base_sptr, 0);
  locargs[2] = ad_acon(args_sptr, 0);
  locargs[1] = ad_acon(arg_size_sptr, 0);
  locargs[0] = ad_acon(args_maptypes_sptr, 0);

  // call the RT
  call_ili =
      mk_tgt_api_call(TGT_API_TARGET_DATA_BEGIN, 6, locarg_types, locargs);

  return call_ili;
}

static int
_tgt_target_fill_targetdata(int device_id, OMPACCEL_TINFO *targetinfo, int tgt_api)
{
  int call_ili, nargs;
  SPTR arg_base_sptr, args_sptr, arg_size_sptr, args_maptypes_sptr;
  char name[16];

  int locargs[6];
  DTYPE
      locarg_types[] = {DT_INT8, DT_INT, DT_ADDR, DT_ADDR, DT_ADDR, DT_ADDR};

  if (targetinfo == NULL) {
    interr("Map item list is not found", 0, ERR_Fatal);
  }

  nargs = targetinfo->n_symbols;

  sprintf(name, "xdata%d_base", dataregion);
  arg_base_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "xdata%d_size", dataregion);
  arg_size_sptr = make_array_sptr(name, DT_INT8, nargs);
  sprintf(name, "xdata%d_args", dataregion);
  args_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "xdata%d_type", dataregion);
  args_maptypes_sptr = make_array_sptr(name, DT_INT8, nargs);
  dataregion++;

  tgt_target_fill_params(arg_base_sptr, arg_size_sptr, args_sptr,
                         args_maptypes_sptr, targetinfo);

  locargs[5] = ad_icon(device_id);
  locargs[4] = ad_icon(nargs);
  locargs[3] = ad_acon(arg_base_sptr, 0);
  locargs[2] = ad_acon(args_sptr, 0);
  locargs[1] = ad_acon(arg_size_sptr, 0);
  locargs[0] = ad_acon(args_maptypes_sptr, 0);

  // call the RT
  call_ili = mk_tgt_api_call(tgt_api, 6, locarg_types, locargs);

  return call_ili;
}

int
ll_make_tgt_targetupdate_end(int device_id, OMPACCEL_TINFO *targetinfo)
{
  return _tgt_target_fill_targetdata(device_id, targetinfo, TGT_API_TARGETUPDATE);
}
int
ll_make_tgt_target_data_end(int device_id, OMPACCEL_TINFO *targetinfo)
{
  return _tgt_target_fill_targetdata(device_id, targetinfo, TGT_API_TARGET_DATA_END);
}
#endif

#ifdef OMP_OFFLOAD_LLVM
static void
change_target_func_smbols(int outlined_func_sptr, int stblk_sptr)
{
  int dpdsc, paramct, i, j, block_sptr, target_sptr;
  const LLUplevel *uplevel;

  // perhaps it is an empty target region
  if (PARSYMSG(stblk_sptr) == 0) {
    return;
  }

  uplevel = llmp_get_uplevel(stblk_sptr);
  paramct = PARAMCTG(outlined_func_sptr);

  for (i = 0; i < uplevel->vals_count; ++i) {
    block_sptr = uplevel->vals[i];
    if (!block_sptr)
      continue;
    dpdsc = DPDSCG(outlined_func_sptr);
    for (j = 0; j < paramct; ++j, ++dpdsc) {
      target_sptr = aux.dpdsc_base[dpdsc];
      if (strncmp(&SYMNAME(target_sptr)[4], SYMNAME(block_sptr),
                  strlen(SYMNAME(block_sptr))) == 0) {
        uplevel->vals[i] = target_sptr;
        break;
      }
    }
  }
}
DTYPE
ll_make_struct(int count, char *name, TGT_ST_TYPE *meminfo, ISZ_T sz)
{
  DTYPE dtype;
  int i;
  SPTR mem, tag, prev_mem, first_mem;
  char sname[MXIDLEN];

  tag = SPTR_NULL;
  dtype = cg_get_type(count, TY_STRUCT, NOSYM); // AOCC dont return used type
  if (name) {
    sprintf(sname, "%s", name);
    tag = getsymbol(sname);
    DTYPEP(tag, dtype);
    OMPACCSTRUCTP(tag, 1);
  }

  prev_mem = first_mem = SPTR_NULL;
  for (i = 0; i < count; ++i) {
    mem = (SPTR)addnewsym(meminfo[i].name); // ???
    STYPEP(mem, ST_MEMBER);
    PAROFFSETP(mem, meminfo[i].psptr);
    DTYPEP(mem, meminfo[i].dtype);
    if (prev_mem > 0)
      SYMLKP(prev_mem, mem);
    SYMLKP(mem, NOSYM);
    PSMEMP(mem, mem);
    VARIANTP(mem, prev_mem);
    CCSYMP(mem, 1);
    ADDRESSP(mem, sz);
    SCP(mem, SC_NONE);
    if (first_mem == 0)
      first_mem = mem;
    sz += size_of(meminfo[i].dtype);
    prev_mem = mem;
  }

  DTySetAlgTy(dtype, first_mem, sz, tag, 0, 0);
  return dtype;
}

/*
 * struct __tgt_offload_entry { void*, char*, i64, i32, i32 }
 */
DTYPE
ll_make_tgt_offload_entry(char *name)
{
  TGT_ST_TYPE meminfo[] = {{"addr", DT_ADDR, 0, 0},
                           {"name", DT_ADDR, 0, 0},
                           {"size", DT_INT8, 0, 0},
                           {"flags", DT_INT, 0, 0},
                           {"reserved", DT_INT, 0, 0}};

  return ll_make_struct(5, name, meminfo, 0);
}

/*
 * struct __tgt_offload_entry { void*, void*, __tgt_offload_entry
 * *,__tgt_offload_entry * }
 */
DTYPE
ll_make_tgt_device_image(char *name, DTYPE entrytype)
{
  DTYPE dtype1, dtype2;
  dtype1 = get_type(2, TY_PTR, DT_BINT);
  dtype2 = get_type(2, TY_PTR, entrytype);
  TGT_ST_TYPE meminfo[] = {
      {"ImageStart", dtype1, 0, 0},
      {"ImageEnd", dtype1, 0, 0},
      {"EntriesBegin", dtype2, 0, 0},
      {"EntriesEnd", dtype2, 0, 0},
  };

  return ll_make_struct(4, name, meminfo, 0);
}

/*
 * struct __tgt_bin_desc { i32, __tgt_device_image*, __tgt_offload_entry
 * *,__tgt_offload_entry * }
 */
DTYPE
ll_make_tgt_bin_descriptor(char *name, DTYPE entrytype, DTYPE deviceimagetype)
{
  DTYPE dtype1, dtype2;
  dtype1 = get_type(2, TY_PTR, entrytype);
  dtype2 = get_type(2, TY_PTR, deviceimagetype);
  TGT_ST_TYPE meminfo[] = {
      {"NumDeviceImages", DT_INT8, 0, 0},
      {"DeviceImages", dtype2, 0, 0},
      {"HostEntriesBegin", dtype1, 0, 0},
      {"HostEntriesEnd", dtype1, 0, 0},
  };

  return ll_make_struct(4, name, meminfo, 0);
}

static SPTR
init_tgt_target_syms(const char *_kernelname, SPTR func_sptr)
{
  char *kernelname;
  size_t size = 100 + strlen(_kernelname);
  NEW(kernelname, char, size);
  strcpy(kernelname, _kernelname);
  SPTR eptr1, eptr2, eptr3;
  char *kernelname_, *sname_region, *sname_entry;
  if (flg.x86_64_omptarget) {
    // Assuming that this function is called for outlined functions that are
    // entry points.
    if (ompaccel_x86_is_parallel_func(func_sptr)) {
      sprintf(kernelname, "%s_x86_entry", _kernelname);
    }
  }
  // AOCC end

  /* regionId */
  NEW(sname_region, char, size);
  strcpy(sname_region, ".openmp.offload.region.");
  strcat(sname_region, kernelname);
  eptr1 = (SPTR)addnewsym(sname_region);
  DTYPEP(eptr1, DT_BINT);
  SCP(eptr1, SC_EXTERN);
  STYPEP(eptr1, ST_VAR);
  // DINITP(eptr1,1);
  SYMLKP(eptr1, gbl.consts);
  gbl.consts = eptr1;
  OMPACCSTRUCTP(eptr1, 1);

  // device functions gets "_" in the end.
  NEW(kernelname_, char, size);
  sprintf(kernelname_, "%s_\00", kernelname);
  // AOCC Modification: Changed strlen(kernelname) to strlen(kernelname_)
  //                    This is required to append null character at end
  eptr2 = getstring(kernelname_, strlen(kernelname_) + 1);
  DINITP(eptr2, 1);

  NEW(sname_entry, char, size);
  strcpy(sname_entry, ".openmp.offload.entry.");
  strcat(sname_entry, kernelname);
  eptr3 = (SPTR)addnewsym(sname_entry);
  DTYPEP(eptr3, tgt_offload_entry_type);
  SCP(eptr3, SC_EXTERN);
  STYPEP(eptr3, ST_STRUCT);
  DINITP(eptr3, 1);
  SECTP(eptr3, 1);
  WEAKP(eptr3, 1);
  OMPACCSTRUCTP(eptr3, 1);

  dinit_put(DINIT_SECT, OMP_OFFLOAD_SEC);
  dinit_put(DINIT_LOC, (ISZ_T)eptr3);
  dinit_put(DINIT_OFFSET, 0);
  dinit_put(DINIT_LABEL, eptr1);
  dinit_put(DINIT_OFFSET, 8);
  dinit_put(DINIT_LABEL, eptr2);
  gbl.saddr = 16;

  return eptr1;
}

void
init_tgt_register_syms()
{
  SPTR tptr1, tptr2, tptr3, tptr4;

  // tptr1 = (SPTR)addnewsym(".omp_offloading.entries_begin"); // AOCC
  tptr1 = (SPTR)addnewsym("__start_omp_offloading_entries"); // AOCC
  // AOCC Begin
  tgt_offload_entry_type = ll_make_tgt_offload_entry("__tgt_offload_entry_type_");
  // AOCC End
  DTYPEP(tptr1, tgt_offload_entry_type);
  /* SCP(tptr1, SC_EXTERN); */ SCP(tptr1, SC_PRIVATE); // AOCC
  DCLDP(tptr1, 1);
  STYPEP(tptr1, ST_VAR);
  SYMLKP(tptr1, gbl.consts);
  gbl.consts = tptr1;
  OMPACCRTP(tptr1, 1);

  // tptr2 = (SPTR)addnewsym(".omp_offloading.entries_end"); //AOCC
  tptr2 = (SPTR)addnewsym("__stop_omp_offloading_entries"); // AOCC
  DTYPEP(tptr2, tgt_offload_entry_type);
  /* SCP(tptr2, SC_EXTERN); */ SCP(tptr2, SC_PRIVATE); // AOCC
  DCLDP(tptr2, 1);
  STYPEP(tptr2, ST_VAR);
  SYMLKP(tptr2, gbl.consts);
  gbl.consts = tptr2;
  OMPACCRTP(tptr2, 1);

  // AOCC begin
#ifdef OMP_OFFLOAD_AMD
  if (flg.amdgcn_target)
    tptr3 = (SPTR)addnewsym(".omp_offloading.img_start.amdgcn-amd-amdhsa");
  else if (flg.x86_64_omptarget)
    tptr3 = (SPTR)addnewsym(".omp_offloading.img_start.x86_64-pc-linux-gnu");
  else
#endif
    // AOCC end
    tptr3 = (SPTR)addnewsym(".omp_offloading.img_start.nvptx64-nvidia-cuda");
  DTYPEP(tptr3, DT_BINT);
  /* SCP(tptr3, SC_EXTERN); */ SCP(tptr3, SC_PRIVATE); // AOCC
  STYPEP(tptr3, ST_VAR);
  SYMLKP(tptr3, gbl.consts);
  gbl.consts = tptr3;
  OMPACCRTP(tptr3, 1);

  // AOCC begin
#ifdef OMP_OFFLOAD_AMD
  if (flg.amdgcn_target)
    tptr4 = (SPTR)addnewsym(".omp_offloading.img_end.amdgcn-amd-amdhsa");
  else if (flg.x86_64_omptarget)
    tptr4 = (SPTR)addnewsym(".omp_offloading.img_end.x86_64-pc-linux-gnu");
  else
#endif
    // AOCC end
    tptr4 = (SPTR)addnewsym(".omp_offloading.img_end.nvptx64-nvidia-cuda");

  DTYPEP(tptr4, DT_BINT);
  /* SCP(tptr4, SC_EXTERN); */ SCP(tptr4, SC_PRIVATE); // AOCC
  DCLDP(tptr4, 1);
  STYPEP(tptr4, ST_VAR);
  SYMLKP(tptr4, gbl.consts);
  gbl.consts = tptr4;
  OMPACCRTP(tptr4, 1);
}

int
ll_make_tgt_register_lib()
{
  SPTR sptr;
  DTYPE dtype_bindesc, dtype_entry, dtype_devimage, dtype_pofbindesc;

  // AOCC Begin
  tgt_offload_entry_type = ll_make_tgt_offload_entry("__tgt_offload_entry_");
  // AOCC End
  dtype_entry = tgt_offload_entry_type;
  dtype_devimage = ll_make_tgt_device_image("__tgt_device_image", dtype_entry);
  dtype_bindesc =
      ll_make_tgt_bin_descriptor("__tgt_bin_desc", dtype_entry, dtype_devimage);

  sptr = (SPTR)addnewsym(".omp_offloading.descriptor");
  STYPEP(sptr, ST_STRUCT);
  SCP(sptr, SC_EXTERN);
  REFP(sptr, 1);
  DTYPEP(sptr, dtype_bindesc);

  dtype_pofbindesc = get_type(2, TY_PTR, dtype_bindesc);
  int args[1];
  DTYPE arg_types[1] = {dtype_pofbindesc};
  args[0] = ad_acon(sptr, 0);
  return mk_tgt_api_call(TGT_API_REGISTER_LIB, 1, arg_types, args);
}

// AOCC begin
int
ll_make_tgt_register_requires()
{
  SPTR sptr;
  DTYPE dtype_bindesc, dtype_entry, dtype_devimage, dtype_pofbindesc;

  // AOCC Begin
  tgt_offload_entry_type = ll_make_tgt_offload_entry("__tgt_offload_entry_requires_");
  // AOCC End
  dtype_entry = tgt_offload_entry_type;
  dtype_devimage = ll_make_tgt_device_image("__tgt_device_image", dtype_entry);
  dtype_bindesc =
    ll_make_tgt_bin_descriptor("__tgt_bin_desc", dtype_entry, dtype_devimage);

  sptr = (SPTR)addnewsym(".omp_offloading.descriptor");
  STYPEP(sptr, ST_STRUCT);
  SCP(sptr, SC_EXTERN);
  REFP(sptr, 1);
  DTYPEP(sptr, dtype_bindesc);

  int args[1];
  DTYPE arg_types[1] = {DT_INT8};
  if (HasRequiresUnifiedSharedMemory) {
    args[0] = ad_kconi(OMP_REQ_UNIFIED_SHARED_MEMORY);
  }
  else
    args[0] = ad_kconi(1);
  return mk_tgt_api_call(TGT_API_REGISTER_REQUIRES, 1, arg_types, args);
}
// AOCC end

int
ll_make_tgt_register_lib2()
{
  SPTR tptr1, tptr2, tptr3, tptr4, tptr;
  SPTR sptr, sptr2;
  int i, ilix, nme, offset, addr;
  DTYPE dtype_entry, dtype_devimage, dtype_bindesc, dtype_pofbindesc;

  init_tgt_register_syms();

  for (tptr = gbl.consts; tptr > NOSYM; tptr = SYMLKG(tptr)) {
    if (OMPACCRTG(tptr)) {
      tptr4 = tptr;
      tptr3 = SYMLKG(tptr4);
      tptr2 = SYMLKG(tptr3);
      tptr1 = SYMLKG(tptr2);
      break;
    }
  }
  // AOCC begin
  // assert(!tptr || !tptr2 || !tptr3 || !tptr4,
  /*
   * MODIFICATION
   * Changed assert expression from logical or to logical and
   * because if it's logcal OR, assert will even if we find one variable.
   * Assert shoudld fail only when we fail to find any of the variable
   */

  assert(tptr && tptr2 && tptr3 && tptr4,
         "OpenMP Offload structures are not found.", 0, ERR_Fatal);
  // AOCC end

  dtype_entry = ll_make_tgt_offload_entry("__tgt_offload_entry_lib2_"); //AOCC
  dtype_devimage = ll_make_tgt_device_image("__tgt_device_image", dtype_entry);
  dtype_bindesc =
      ll_make_tgt_bin_descriptor("__tgt_bin_desc", dtype_entry, dtype_devimage);

  sptr = (SPTR)addnewsym(".omp_offloading.device_images");
  STYPEP(sptr, ST_STRUCT);
  SCP(sptr, SC_LOCAL);
  REFP(sptr, 1);
  DTYPEP(sptr, dtype_devimage);
  nme = addnme(NT_VAR, sptr, 0, 0);

  offset = 0;

  i = DTyAlgTyMember(dtype_devimage);
  addr = ad_acon(sptr, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr3, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);

  i = SYMLKG(i);
  addr = ad_acon(sptr, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr4, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);

  i = SYMLKG(i);
  addr = ad_acon(sptr, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr1, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);

  i = SYMLKG(i);
  addr = ad_acon(sptr, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr2, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  chk_block(ilix);

  sptr2 = (SPTR)addnewsym(".omp_offloading.descriptor");
  STYPEP(sptr2, ST_STRUCT);
  SCP(sptr2, SC_LOCAL);
  REFP(sptr2, 1);
  DTYPEP(sptr2, dtype_bindesc);
  nme = addnme(NT_VAR, sptr2, 0, 0);

  offset = 0;
  i = DTyAlgTyMember(dtype_bindesc);
  addr = ad_acon(sptr2, offset);
  ilix =
      ad4ili(IL_ST, ad_icon(1), addr, addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0),
             mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);
  i = SYMLKG(i);
  addr = ad_acon(sptr2, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(sptr, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);
  i = SYMLKG(i);
  addr = ad_acon(sptr2, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr1, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);
  i = SYMLKG(i);
  addr = ad_acon(sptr2, offset);
  ilix =
      ad4ili(IL_ST, ad_acon(tptr2, 0), addr,
             addnme(NT_MEM, (SPTR)PSMEMG(i), nme, 0), mem_size(DTY(DTYPEG(i))));
  offset += size_of(DTYPEG(i));
  chk_block(ilix);

  dtype_pofbindesc = get_type(2, TY_PTR, dtype_bindesc);
  int args[1];
  DTYPE arg_types[1] = {dtype_pofbindesc};
  args[0] = ad_acon(sptr2, 0);
  return mk_tgt_api_call(TGT_API_REGISTER_LIB, 1, arg_types, args);
}

void
init_tgtutil()
{
  tgt_offload_entry_type = ll_make_tgt_offload_entry("__tgt_offload_entry_type_");
}

// AOCC Begin
int
ll_make_tgt_target_update(int device_id, OMPACCEL_TINFO *targetinfo)
{
  int call_ili, nargs;
  SPTR arg_base_sptr, arg_sptr, arg_size_sptr, arg_map_sptr;
  char name[16];
  int local_args[12];

  DTYPE locarg_types[] = {DT_INT8, DT_INT, DT_ADDR, DT_ADDR, DT_ADDR, DT_ADDR};

  if (targetinfo == NULL) {
    interr("Map item list is not found", 0, ERR_Fatal);
  }
  nargs = targetinfo->n_symbols;

  sprintf(name, "update%d_base", updateregion);
  arg_base_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "update%d_size", updateregion);
  arg_size_sptr = make_array_sptr(name, DT_INT8, nargs);
  sprintf(name, "update%d_args", updateregion);
  arg_sptr = make_array_sptr(name, DT_CPTR, nargs);
  sprintf(name, "update%d_type", updateregion);
  arg_map_sptr = make_array_sptr(name, DT_INT8, nargs);
  updateregion++;

  tgt_target_fill_params(arg_base_sptr, arg_size_sptr, arg_sptr,
                         arg_map_sptr, targetinfo);

  local_args[5] = ad_icon(device_id);
  local_args[4] = ad_icon(nargs);
  local_args[3] = ad_acon(arg_base_sptr, 0);
  local_args[2] = ad_acon(arg_sptr, 0);
  local_args[1] = ad_acon(arg_size_sptr, 0);
  local_args[0] = ad_acon(arg_map_sptr, 0);

  call_ili =
      mk_tgt_api_call(TGT_API_TARGETUPDATE, 6, locarg_types, local_args);

  return call_ili;
}
// AOCC End

#endif
