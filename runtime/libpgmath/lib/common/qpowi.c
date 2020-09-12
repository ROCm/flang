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
#include "mthdecls.h"

__float128
__mth_i_qpowi(__float128 x, int i)
{
  int k;
  __float128 f;

  f = 1;
  k = i;
  if (k < 0)
    k = -k;
  for (;;) {
    if (k & 1)
      f *= x;
    k = (unsigned)k >> 1;
    if (k == 0)
      break;
    x *= x;
  }
  if (i < 0)
    f = 1.0 / f;
  return f;
}
