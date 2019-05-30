/*
 * Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for Bit Sequence Comparsion intrinsics.
 *
 * Month of Modification: May 2019
 *
 *
 * Support for Bit Masking intrinsics.
 *
 * Month of Modification: May 2019
 *
 */

/* clang-format off */

/** \file
 * \brief F90  BITWISE intrinsics for INT types
 */

/* AOCC begin */
#include "FuncArgMacros.h"
#include "fioMacros.h"

#include <limits.h>

/* returns the zero-extended, unsigned long casted, value of i which has nbits.
 * Only works for nbits as 8 or 16 or 32 or 64. */
static unsigned long zext_to_ul(unsigned long i, int nbits) {
  unsigned long mask;

  if (nbits == 8) {
    mask = 0xff;
  } else if (nbits == 16) {
    mask = 0xffff;
  } else if (nbits == 32) {
    mask = 0xffffffff;
  } else if (nbits == 64) {
    return i;
  }
  return ((unsigned long)i & mask);
}

int ENTF90(BITCMP, bitcmp)(long *ptr_a, long *ptr_b, int *ptr_a_nbits, int *ptr_b_nbits)
{
  long a = *ptr_a;
  long b = *ptr_b;
  int a_nbits = *ptr_a_nbits;
  int b_nbits = *ptr_b_nbits;

  unsigned long unsigned_a = zext_to_ul((unsigned long)a, a_nbits);
  unsigned long unsigned_b = zext_to_ul((unsigned long)b, b_nbits);
  long signed_a = (long)unsigned_a;
  long signed_b = (long)unsigned_b;

  /* if only a has most-significant-bit set */
  if (signed_a < 0 && signed_b > 0)
    return 1;

  /* if only b has most-significant-bit set */
  if (signed_a > 0 && signed_b < 0)
    return -1;

  /* Slighly hacky way to get an unsigned long with MSB unset and every other
   * bit set without using literally hand-written numbers that could violate
   * portability */
  unsigned long msb_mask = ((unsigned long ) ULONG_MAX & LONG_MAX);
  /* Ignore the most-significant-bit since they are the same for a and b */
  unsigned_a = unsigned_a & msb_mask;
  unsigned_b = unsigned_b & msb_mask;

  if (unsigned_a == unsigned_b)
    return 0;

  return unsigned_a > unsigned_b ? 1 : -1;
}

unsigned long ENTF90(BITMASK, bitmask)(int *ptr_n, int *ptr_kind, int *ptr_is_left) {
  long n = *ptr_n;
  int kind = *ptr_kind;
  int is_left = *ptr_is_left;
  unsigned long ret = 0;

  if (is_left) {
    for (unsigned long i = ((kind * 8) - 1), j = 0; j < n; i--, j++) {
      ret |= ((unsigned long) 0x1 << i);
    }

  } else {
    for (unsigned long i = 0; i < n; i++) {
      ret |= ((unsigned long) 0x1 << i);
    }
  }

  return ret;
}
/* AOCC end */
