/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * x86_64 offloading regression test-suite
 *
 * Last modified: Aug 2019
 */

#include <stdlib.h>

void check_int_(int *res, int *exp, int *n) {
  if (!res || !exp || !n) {
    exit(1);
  }

  for (int i = 0; i < *n; i++) {
    if (res[i] != exp[i]) { exit (1); }
  }
}
