/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/* inhibit floating point copy propagation */

#include "mthdecls.h"

float_complex_t 
ccotanf(float_complex_t arg) {
  return 1.0/ctanf(arg);
}
