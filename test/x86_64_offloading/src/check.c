/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * x86_64 offloading regression test-suite
 *
 * Last modified: Aug 2019
 */

#include <stdio.h>
#include <stdlib.h>

// We don't summarize the test results in the dump functions, since lit already
// does that. Not sure why flang-devs are attempting to summarize it
// "progressively" in other test-suites.
//
// There's a FileCheck directive "CHECK:" in runmake that matches the
// string printed by dump_passed()/dump_failed(). It's case sensitive! You've been
// warned.
//
void dump_passed() {
  printf("1 tests PASSED. 0 tests failed.\n");
}

void dump_failed() {
  printf("0 tests passed. 1 tests FAILED.\n");
}

void check_int_(int *res, int *exp, int *n) {
  if (!res || !exp || !n) {
    dump_failed();
    exit(1);
  }

  for (int i = 0; i < *n; i++) {
    if (res[i] != exp[i]) { dump_failed(); exit (1); }
  }

  dump_passed();
}
