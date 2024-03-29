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

#include "dblint64.h"

/*
 * define a C type for long long so that the routines using this type
 * will always compile.  For those systems where long long isn't
 * supported, TM_I8 will not be defined, but at least the run-time routines
 * will compile.
 */

#define __HAVE_LONGLONG_T

#if defined(LINUX8664) || defined(OSX8664)
typedef long _LONGLONG_T;
typedef unsigned long _ULONGLONG_T;
#else
typedef long long _LONGLONG_T;
typedef unsigned long long _ULONGLONG_T;
#endif

#define I64_MSH(t) t[1]
#define I64_LSH(t) t[0]

extern int __ftn_32in64_;

#define VOID void

typedef union {
  DBLINT64 i;
  double d;
  _LONGLONG_T lv;
} INT64D;

#if defined(LINUX8664) || defined(OSX8664)
#define __I8RET_T long
#define UTL_I_I64RET(m, l)                                                     \
  {                                                                            \
    INT64D int64d;                                                             \
    I64_MSH(int64d.i) = m;                                                     \
    I64_LSH(int64d.i) = l;                                                     \
    return int64d.lv;                                                          \
  }
#elif defined(WIN64)
/* Someday, should only care if TM_I8 is defined */
#define __I8RET_T long long
#define UTL_I_I64RET(m, l)                                                     \
  {                                                                            \
    INT64D int64d;                                                             \
    I64_MSH(int64d.i) = m;                                                     \
    I64_LSH(int64d.i) = l;                                                     \
    return int64d.lv;                                                          \
  }
#else
#define __I8RET_T void
#define UTL_I_I64RET __utl_i_i64ret
extern VOID UTL_I_I64RET();
#endif
