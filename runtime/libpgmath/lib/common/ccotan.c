/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/* inhibit floating point copy propagation */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"

CMPLXFUNC_C(__mth_i_ccotan)
{
  CMPLXARGS_C;
  float_complex_t f;
  f = 1.0/ctanf(carg);
  CRETURN_C(f);
}
