/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/* inhibit floating point copy propagation */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"

ZMPLXFUNC_Z(__mth_i_cdcotan)
{
  ZMPLXARGS_Z;
  double_complex_t d;
  d = 1.0/ctan(zarg);
  ZRETURN_Z(d);
}
