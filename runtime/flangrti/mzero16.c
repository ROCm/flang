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

#include "memops.h"

#if !defined(INLINE_MEMOPS)
void
__c_mzero16(__float128 *dest, long cnt)
{
  long i;

  for (i = 0; i < cnt; i++) {
    dest[i] = 0;
  }
  return;
}
#endif
