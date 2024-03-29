/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

#include "mthdecls.h"

float
__mth_i_cotand(float f)
{
  return 1.0/tanf(CNVRTDEG(f));
}
