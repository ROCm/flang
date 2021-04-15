/*
 * Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for DNORM intrinsic
 * Date of Modification: 21st February 2019
 *
 * Complex data types support for acosh, asinh and atanh
 * Date of Modification: 08 January 2020
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

extern int __hpf_lcpu;

void
check_(int* res, int* exp, int* np)
{
    int i;
    int n = *np;
    int tests_passed = 0;
    int tests_failed = 0;

    for (i = 0; i < n; i++) {
        if (exp[i] == res[i]) {
	    tests_passed ++;
        } else {
            tests_failed ++;
	    if( tests_failed < 100 )
            printf(
	    "test number %d FAILED. res %d(%08x)  exp %d(%08x)\n",
	     i+1,res[i], res[i], exp[i], exp[i] );
        }
    }
    if (tests_failed == 0) {
	    printf(
	"%3d tests completed. %d tests PASSED. %d tests failed.\n",
                      n, tests_passed, tests_failed);
    } else {
	printf("%3d tests completed. %d tests passed. %d tests FAILED.\n",
                      n, tests_passed, tests_failed);
    }
}

void
check(int* res, int* exp, int* np)
{
    check_(res, exp, np);
}

  void
checkll_(long long *res, long long *exp, int *np)
{
  int i;
  int n = *np;
  int tests_passed = 0;
  int tests_failed = 0;

  for (i = 0; i < n; i++) {
    if (exp[i] == res[i]) {
      tests_passed ++;
    } else {
      tests_failed ++;
      if( tests_failed < 100 )
        printf( "test number %d FAILED. res %lld(%0llx)  exp %lld(%0llx)\n",
            i+1,res[i], res[i], exp[i], exp[i] );
    }
  }
  if (tests_failed == 0) {
    printf(
        "%3d tests completed. %d tests PASSED. %d tests failed.\n",
        n, tests_passed, tests_failed);
  } else {
    printf("%3d tests completed. %d tests passed. %d tests FAILED.\n",
        n, tests_passed, tests_failed);
  }
}

  void
checkll(long long *res, long long *exp, int *np)
{
  checkll_(res, exp, np);
}

/* maximum allowed difference in units in the last place */
#ifndef MAX_DIFF_ULPS
#define MAX_DIFF_ULPS 3
#endif

void
checkf_(float* res, float* exp, int* np)
{
    int i;
    int n = *np;
    int tests_passed = 0;
    int tests_failed = 0;
    int ires, iexp, diff;

    assert(sizeof(int) == 4);
    assert(sizeof(float) == 4);
    for (i = 0; i < n; i++) {
        ires = *(int *)(res + i);
        iexp = *(int *)(exp + i);
        if (ires < 0)
            ires = 0x80000000 - ires;
        if (iexp < 0)
            iexp = 0x80000000 - iexp;
        diff = abs(ires - iexp);
        if (diff <= MAX_DIFF_ULPS)
            tests_passed++;
        else {
            tests_failed++;
	    printf("ires = %d iexp = %d diff = %d\n" , ires , iexp , diff);
            if (tests_failed < 100)
                printf("test number %d FAILED. diff in last place units: %d\n",
                        i+1, diff);
        }
    }
    if (tests_failed == 0) {
        printf("%3d tests completed. %d tests PASSED. %d tests failed.\n",
                      n, tests_passed, tests_failed);
    }
    else {
        printf("%3d tests completed. %d tests passed. %d tests FAILED.\n",
                      n, tests_passed, tests_failed);
    }
}

void
checkf(float* res, float* exp, int* np)
{
    checkf_(res, exp, np);
}


#if defined(WINNT) || defined(WIN32)
void
__stdcall CHECK(int* res, int* exp, int* np)
{
    check_(res, exp, np);
}

void
__stdcall CHECKLL(long long *res, long long *exp, int *np)
{
  checkll_(res, exp, np);
}

void
__stdcall CHECKF(float* res, float* exp, int* np)
{
    checkf_(res, exp, np);
}

#endif
