/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 *
 * Last Modified: June 2020
 */

#include "mthdecls.h"

QMPLXFUNC_Q_Q(__mth_i_cqdiv)
{
  QMPLXARGS_Q_Q;
  __float128 x, y;
  __float128 r, d, r_mag, i_mag;

  r_mag = real2;
  if (r_mag < 0)
    r_mag = -r_mag;
  i_mag = imag2;
  if (i_mag < 0)
    i_mag = -i_mag;
  /* avoid overflow */
  if (r_mag <= i_mag) {
    r = real2 / imag2;
    d = 1.0 / (imag2 * (1 + r * r));
    x = (real1 * r + imag1) * d;
    y = (imag1 * r - real1) * d;
  } else {
    r = imag2 / real2;
    d = 1.0 / (real2 * (1 + r * r));
    x = (real1 + imag1 * r) * d;
    y = (imag1 - real1 * r) * d;
  }
 QRETURN_Q_Q(x, y);
}
