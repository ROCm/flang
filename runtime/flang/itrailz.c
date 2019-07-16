/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for TRAILZ intrinsic.
 *
 * Month of Modification: May 2019
 */

int
__mth_i_itrailz(int i)
{
  unsigned ui = (unsigned) i;

  return (ui) ? __builtin_ctz(ui) : 32;
}
