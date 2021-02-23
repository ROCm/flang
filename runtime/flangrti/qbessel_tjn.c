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

/* bessel_tjn.c implements __float128 F2008 bessel_jn transformational intrinsic */

__float128 __mth_i_qbessel_j0(__float128 arg);
__float128 __mth_i_qbessel_j1(__float128 arg);
__float128 __mth_i_qbessel_jn(int n, __float128 arg);

void
f90_qbessel_jn(__float128 *rslts, int *n1, int *n2, __float128 *x)
{
  int i;
  __float128 *rslt_p;

  for (i = *n1, rslt_p = rslts; i <= *n2; i++, rslt_p++) {
    switch (i) {
    case 0:
      *rslt_p = __mth_i_qbessel_j0(*x);
      break;
    case 1:
      *rslt_p = __mth_i_qbessel_j1(*x);
      break;
    default:
      *rslt_p = __mth_i_qbessel_jn(i, *x);
      break;
    }
  }
}


