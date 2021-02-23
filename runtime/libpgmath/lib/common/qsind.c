/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

#include "mthdecls.h"
#include "quadmath.h"

__float128 __attribute__((weak)) sinq( __float128);

__float128
__mth_i_qsind(__float128 q)
{
  return (sinq(CNVRTDEG(q)));
}
