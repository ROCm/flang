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
 *
 * AOCC ChangeLog:
 *  2020/03/09 : initial version
 */

/*
 * Record the delinearized index expressions in a dummy functional call.
 * LIMITATIONS;
 *  - No attempt is made to store sufficient information to reverse the
 *    linearization.
 *  - No implementation is provided for these functions in a pure fortran
 *    build flow. This is meant as an input to the LLVM flow. Using this
 *    in a pure flang->exe flow will mostly fail at link-time.
 */
#include "gbldefs.h"
#include "global.h"
#include "error.h"
#include "symtab.h"
#include "symutl.h"
#include "dtypeutl.h"
#include "soc.h"
#include "semant.h"
#include "ast.h"
#include "gramtk.h"
#include "extern.h"
#include "commopt.h"
#include "dpm_out.h"
#include "nme.h"
#include "optimize.h"
#include "pd.h"
#include "ccffinfo.h"
#define RTE_C
#include "rte.h"
#undef RTE_C
#include "comm.h"
#include "direct.h"
#include "rtlRtns.h"

static void _fcprop(int ast, int *dummy);
static void _fcprop_sub(int ast);
static void _fcprop_all(int ast);

static int fcprop_marker = 0;

static int
_insert_access(int ast, int sptr, const char *tag)
{
  ADSC *ad = 0;
  int asd, ndim, dtype, i;
  asd = A_ASDG(ast);
  ndim = ASD_NDIM(asd);
  dtype = DTYPEG(sptr);
  if (STYPEG(sptr) != ST_MEMBER)
    ad = AD_DPTR(dtype);
  if (ad) {
    int f = sym_mkfunc("flang.access", DT_NONE);
    int fnid = mk_id(f);
    int nargs = 1 + 1 + 1 + ndim;
    // access, elem-size, ndim, index, ...
    int argt = mk_argt(nargs);
    int ni = 0;
    int esize = elem_size_of_ast(ast);
    ARGT_ARG(argt, ni) = ast; ++ni;
    ARGT_ARG(argt, ni) = esize; ++ni;
    ARGT_ARG(argt, ni) = mk_cval((INT)ndim, DT_INT); ++ni;
    for (i = 0; i < ndim; ++i) {
      ARGT_ARG(argt, ni) = ASD_SUBS(asd, i); ++ni;
    }
    PUREG(f) = 1;
    int b = mk_func_node(A_CALL, fnid, nargs, argt);
#if DEBUG
  if (DBGBIT(56,2)) {
    fprintf(gbl.dbgfil, "\ninsert access (%s) (%d):\n--START--\n", tag, ast);
    dbg_print_ast(b, gbl.dbgfil);
    dump_ast_tree(b);
    fprintf(gbl.dbgfil, "--END--\n");
  }
#endif
    add_stmt_before(b, fcprop_marker);
  }
}

void
collect_fcprop()
{
  int std;
  int dummy = 0;

  for (std = STD_NEXT(0); std; std = STD_NEXT(std)) {
    int ast;
    fcprop_marker = std;
    ast = STD_AST(std);
    ast_visit(1, 1);
    switch (A_TYPEG(ast)) {
    case A_ALLOC:
      /* for ALLOCATEs, don't modify the allocate target directly */
      if (A_LOPG(ast) != 0) {
        _fcprop_all(A_LOPG(ast));
      }
      if (A_DESTG(ast) != 0) {
        _fcprop_all(A_DESTG(ast));
      }
      if (A_M3G(ast) != 0) {
        _fcprop_all(A_M3G(ast));
      }
      if (A_STARTG(ast) != 0) {
        _fcprop_all(A_STARTG(ast));
      }
      _fcprop_sub(A_SRCG(ast));
      break;
    case A_REDIM: /* skip REDIM statements */
      break;
    default:
      _fcprop_all(ast);
      break;
    }
    ast_unvisit();
  }
}

static void
_fcprop(int ast, int *dummy)
{
  /* At an A_SUBSCR? */
  if (A_TYPEG(ast) == A_SUBSCR && A_SHAPEG(ast) == 0) {
    int lop, sptr;
    
    lop = A_LOPG(ast);
    if (A_TYPEG(lop) == A_ID) {
      sptr = A_SPTRG(lop);
    } else if (A_TYPEG(lop) == A_MEM) {
      sptr = A_SPTRG(A_MEMG(lop));
    } else {
      return;
    }
    _insert_access(ast, sptr, "aref");
  }
}

static void
_fcprop_sub(int ast)
{
  int lop, asd, i;
  switch (A_TYPEG(ast)) {
  case A_ID:
    break;
  case A_SUBSCR:
    /* look at subscripts, look at parent */
    asd = A_ASDG(ast);
    for (i = 0; i < ASD_NDIM(asd); ++i) {
      _fcprop_all(ASD_SUBS(asd, i));
    }
    lop = A_LOPG(ast);
    if (A_TYPEG(lop) == A_MEM) {
      _fcprop_all(A_PARENTG(lop));
    }
    break;
  case A_MEM:
    _fcprop_all(A_PARENTG(ast));
    break;
  default:
    _fcprop_all(ast);
    break;
  }
} /* _fcprop_sub */

static void
_fcprop_all(int ast)
{
  int dummy = 0;
  ast_traverse(ast, NULL, _fcprop, &dummy);
}


