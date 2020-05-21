/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/*
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 * Last Modified: June 2020
 *
 */

#include <quadmath.h>
#include <complex.h>

__complex128 cqsqrt(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = csqrtq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqsin(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = csinq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}
__complex128 cqcos(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = ccosq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqtan(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = ctanq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqsinh(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = csinhq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqcosh(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = ccoshq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqtanh(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = ctanhq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqexp(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = cexpq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqlog(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = clogq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

__complex128 cqconj(__complex128 res, __float128 real, __float128 imag)
{
  __float128 x, y;
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   res = conjq(val);
   real = __real__ res;
   imag = __imag__ res;
  return res;
}

