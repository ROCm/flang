/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

/* 
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 *
 * Support for qnint
 * Date of modification: 16th September 2020
 *
 */

#include "mthdecls.h"

/*
 * libm's round() could also be used if compiled with:
 *      _ISOC99_SOURCE || _POSIX_C_SOURCE >= 200112L
 */

#if     defined(TARGET_LINUX_POWER)
__float128
__mth_i_qnint(__float128 f)
{
  __float128 x;
  asm("frin %0, %1"
     : "=ld"(x)
     : "ld"(f)
     :
     );
  return x;
}

#elif   defined(__aarch64__)
__float128
__mth_i_qnint(__float128 f)
{
  __float128 r;
  asm("frinta   %ld0, %ld1"
    : "=w"(r)
    : "w"(f)
    :);
  return r;
}

#else   /* #if     defined(TARGET_LINUX_POWER) */
#include <math.h>
#include <ieee754.h>

__float128
__mth_i_qnint(__float128 f)
{
  __float128 x = f;     /* Cases where f == 0.0, or f == NaN */
  union ieee854_long_double *u = (union ieee854_long_double *)&x;

  /*
   * Depending on the default rounding mode of the processor, the logic
   * below with modf(f + 0.5) can result in a bogus rounding when 0.5
   * is normalized such that it falls within the guard or round bits.
   *
   * Fast return if the exponent guarantees that the floating point number
   * is a whole integer.
   *
   * This quick exit also catches infinities and NaNs.
   */

  if (u->ieee.exponent >= IEEE854_LONG_DOUBLE_BIAS+112) return x;

  if (f > 0.0)
    (void)modf(f + 0.5, &x);
  else if (f < 0.0)
    (void)modf(f - 0.5, &x);
  return x;
}
#endif  /* #if     defined(TARGET_LINUX_POWER) */
