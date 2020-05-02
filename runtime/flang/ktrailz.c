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

#include <stdint.h>

int64_t
__mth_i_ktrailz(int64_t i)
{
  uint64_t ui = (uint64_t) i;

 #if (defined(PGOCL) || defined(TARGET_LLVM_ARM)) && !defined(TARGET_LLVM_ARM64)
  return (ui) ? __builtin_ctz(ui) : 64;
 #else
   if (!ui)
     return 64;

   return ((int)(ui)) ? ( __builtin_ctz(ui)) :
     (__builtin_ctz(ui >> 32)) + 32;
 #endif
}
