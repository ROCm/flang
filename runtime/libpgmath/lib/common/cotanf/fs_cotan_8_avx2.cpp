
/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */


#ifndef __COTAN_F_AVX2_H__
#define __COTAN_F_AVX2_H__

#include <immintrin.h>
#include "common_cotanf.h"
#define CONFIG 1
#include "helperavx2.h"
#include "cotan_f_vec.h"

extern "C" vfloat __attribute__ ((noinline)) __fs_cotan_8_avx2(vfloat const a);

vfloat __attribute__ ((noinline))
__fs_cotan_8_avx2(vfloat const a)
{
	return __cotan_f_vec(a);
}

#endif // __COTAN_F_AVX2_H__

