//-----------------------------------------------------------------------//
// Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved. //
//                                                                       //
// Adding offload regression testcases                                   //
//                                                                       //
// Date of Creation: 1st July 2019                                       //
//-----------------------------------------------------------------------//

#include <stdio.h>
#include <stdlib.h>
void __check_int_(int *expected, int *result, int *n) {
  for (int i = 0; i < *n; ++i) {
    if (result[i] != expected[i]) {
      fprintf(stderr, "Mismatch at %d, %d VS %d\n", i, result[i], expected[i]);
      exit(1);
    }
  }
}

void __check_double_(double *expected, double *result, int *n) {
  for (int i = 0; i < *n; ++i) {
    if (result[i] != expected[i]) {
      fprintf(stderr, "Mismatch at %d, %lf VS %lf\n",
             i, result[i], expected[i]);
      exit(1);
    }
  }
}
