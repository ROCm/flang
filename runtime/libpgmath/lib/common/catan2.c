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
 *
 * Complex datatype support for atan2 under flag f2008
 * Modified on 13th March 2020
 *
 */

/* inhibit floating point copy propagation */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"

CMPLXFUNC_C_C(__mth_i_catan2)
{
  CMPLXARGS_C_C;

  float_complex_t ir;
  float_complex_t r;
  static double pi = 3.1415926535897932e+00, piby2 = 1.5707963267948966e+00;
  double _Complex cpi = PGMATH_CMPLX_CONST(pi, 0);
  double _Complex cpiby2 = PGMATH_CMPLX_CONST(piby2, 0);
  double _Complex comp = PGMATH_CMPLX_CONST(0, 0);

  double x = __builtin_creal(carg1);
  double y = __builtin_creal(carg2);

  CMPLX_CALL_CR_C_C(__mth_i_cdiv, ir, carg1, carg2);
  r = catan(ir);

  if (x > 0) {
    CRETURN_C(r);
  }
  else if((x < 0) && (y >= 0)) {
    float_complex_t res = r + cpi;
    CRETURN_C(res);	
  }
  else if((x < 0) && (y < 0)) {
    float_complex_t res = r - cpi;
    CRETURN_C(res);
  }
  else if((x == 0) && (y > 0)) {
    CRETURN_C(cpiby2);
  }
  else if((x == 0) && (y < 0)) {
    float_complex_t res = -cpiby2;
    CRETURN_C(res);
  } 
}
