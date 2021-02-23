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
 * Support for TRAILZ intrinsic.
 *
 * Month of Modification: May 2019
 */

int
__mth_i_itrailzi(int i, int size)
{
  unsigned ui = (unsigned) i;

  return (ui) ? __builtin_ctz(ui) : (size * 8);
}
