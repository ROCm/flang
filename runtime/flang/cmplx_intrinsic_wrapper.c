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
 * Added complex quad support for asin, asinh, acos, acosh, atan, atanh
 * Last modified: 19th August 2020
 *
 */

#include <quadmath.h>
#include <complex.h>

__complex128 cqsqrt(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return csqrtq(val);
}

__complex128 cqsin(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return csinq(val);
}

__complex128 cqasin(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return casinq(val);
}

__complex128 cqasinh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return casinhq(val);
}

__complex128 cqcos(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return ccosq(val);
}

__complex128 cqacos(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return cacosq(val);
}

__complex128 cqacosh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return cacoshq(val);
}

__complex128 cqtan(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return ctanq(val);
}

__complex128 cqatan(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return catanq(val);
}

__complex128 cqatanh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return catanhq(val);
}

__complex128 cqsinh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return csinhq(val);
}

__complex128 cqcosh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return ccoshq(val);
}

__complex128 cqtanh(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return ctanhq(val);
}

__complex128 cqexp(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return cexpq(val);
}

__complex128 cqlog(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return clogq(val);
}

__complex128 cqconj(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return conjq(val);
}

__complex128 cqabs(__complex128 res, __float128 real, __float128 imag)
{
   __complex128  val;
   __real__ val = real;
   __imag__ val = imag;
   return cabsq(val);
}

