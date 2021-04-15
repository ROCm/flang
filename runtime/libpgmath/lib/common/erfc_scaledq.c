/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/*
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 */
/* inhibit floating point copy propagation */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"
#include <float.h>
#include <quadmath.h>

#define pi 3.1415926535897932384626434
#define sqrtpi 1.77245385090551602729
#define epsr16 2.2204460492503131e-016
#define xinfr16 FLT128_MAX
#define xminr16 FLT128_MIN
#define xsmallr16 epsr16 / 2.0
#define xmaxr16 1.0 / (sqrtpi * xminr16)

/*  mathematical constants */
#define zero 0.0e0
#define four 4.0e0
#define one 1.0e0
#define half 0.5e0
#define two 2.0e0
#define sqrpi 5.6418958354775628695e-1
#define thresh 0.46875e0
#define sixten 16.0e0

/*  machine-dependent constants: ieee __float128 precision values */
#define xneg -26.628e0
#define xbig 26.543e0
#define xhuge 6.71e7

/*  coefficients for approximation to  erf  in first interval */

static __float128 a[5] = {3.16112374387056560e00, 1.13864154151050156e02,
                      3.77485237685302021e02, 3.20937758913846947e03,
                      1.85777706184603153e-1};
static __float128 b[4] = {2.36012909523441209e01, 2.44024637934444173e02,
                      1.28261652607737228e03, 2.84423683343917062e03};

/*  coefficients for approximation to  erfc  in second interval */
static __float128 c[9] = {
    5.64188496988670089e-1, 8.88314979438837594e00, 6.61191906371416295e01,
    2.98635138197400131e02, 8.81952221241769090e02, 1.71204761263407058e03,
    2.05107837782607147e03, 1.23033935479799725e03, 2.15311535474403846e-8};
static __float128 d[8] = {1.57449261107098347e01, 1.17693950891312499e02,
                      5.37181101862009858e02, 1.62138957456669019e03,
                      3.29079923573345963e03, 4.36261909014324716e03,
                      3.43936767414372164e03, 1.23033935480374942e03};

/*  coefficients for approximation to  erfc  in third interval */
static __float128 p[6] = {3.05326634961232344e-1, 3.60344899949804439e-1,
                      1.25781726111229246e-1, 1.60837851487422766e-2,
                      6.58749161529837803e-4, 1.63153871373020978e-2};
static __float128 q[5] = {2.56852019228982242e00, 1.87295284992346047e00,
                      5.27905102951428412e-1, 6.05183413124413191e-2,
                      2.33520497626869185e-3};

__float128
__mth_i_qerfc_scaled(__float128 arg)
{
  __float128 x, y, ysq, xnum, xden, del;
  int i;
  __float128 result;

  x = arg;
  y = fabs(x);

  if (y <= thresh) {
    /* evaluate  erf  for  |x| <= 0.46875 */
    ysq = zero;
    if (y > xsmallr16)
      ysq = y * y;
    xnum = a[4] * ysq;
    xden = ysq;
    for (i = 0; i < 3; i++) {
      xnum = (xnum + a[i]) * ysq;
      xden = (xden + b[i]) * ysq;
    }
    result = x * (xnum + a[3]) / (xden + b[3]);
    result = one - result;
    result = exp(ysq) * result;
    goto ret;
  } else if (y <= four) {
    /*  evaluate  erfc  for 0.46875 <= |x| <= 4.0 */
    xnum = c[8] * y;
    xden = y;
    for (i = 0; i < 7; i++) {
      xnum = (xnum + c[i]) * y;
      xden = (xden + d[i]) * y;
    }
    result = (xnum + c[7]) / (xden + d[7]);
  } else {
    /*  evaluate  erfc  for |x| > 4.0 */
    result = zero;
    if (y >= xbig) {
      if (y > xmaxr16)
        goto negval;
      if (y >= xhuge) {
        result = sqrpi / y;
        goto negval;
      }
    }
    ysq = one / (y * y);
    xnum = p[5] * ysq;
    xden = ysq;
    for (i = 0; i < 4; i++) {
      xnum = (xnum + p[i]) * ysq;
      xden = (xden + q[i]) * ysq;
    }
    result = ysq * (xnum + p[4]) / (xden + q[4]);
    result = (sqrpi - result) / y;
  }
negval:
  /*  fix up for negative argument, erf, etc. */
  if (x < zero) {
    if (x < xneg) {
      result = xinfr16;
    } else {
#if defined(TARGET_WIN)
      __float128 tmp = x * sixten;
      long l = tmp;
      tmp = l;
      ysq = tmp / sixten;
#else
      ysq = trunc(x * sixten) / sixten;
#endif
      del = (x - ysq) * (x + ysq);
      y = exp(ysq * ysq) * exp(del);
      result = (y + y) - result;
    }
  }
ret:
  return result;
}
