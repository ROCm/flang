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
 * Last Modified: May 2020
 */

/* clang-format off */

/*	stime3f.c - Implements LIB3F stime subprogram.  */

#ifndef WINNT

#include <time.h>
#include "io3f.h"
#include "ent3f.h"

int ENT3F(STIME, stime)(int *tp)
{
  int i;
  struct timespec ts = {};
  ts.tv_sec = *tp;
  if ((i = clock_settime(CLOCK_REALTIME, &ts)))
    i = __io_errno();

  return i;
}

#endif /* !WINNT */
