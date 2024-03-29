/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/* clang-format off */

#include "stdioInterf.h"
#include "fioMacros.h"
#include <time.h>
#include <sys/time.h>
#include <unistd.h>

extern double __fort_second();
extern long __fort_getoptn(char *, long);

/*
 * Hacks to return complex-valued functions.
 * mergec & mergedc for the Cray are defined in miscsup_com.c.
 */

/*
 * For these targets, the first argument is a pointer to a complex
 * temporary in which the value of the complex function is stored.
 */

typedef struct {
  float real;
  float imag;
} cmplx_t;

typedef struct {
  double real;
  double imag;
} dcmplx_t;

typedef struct {
  __float128 real;
  __float128 imag;
} qcmplx_t;

void ENTF90(MERGEC, mergec)(cmplx_t *res, cmplx_t *tsource, cmplx_t *fsource,
                            void *mask, __INT_T *size)
{
  if (I8(__fort_varying_log)(mask, size)) {
    res->real = tsource->real;
    res->imag = tsource->imag;
  } else {
    res->real = fsource->real;
    res->imag = fsource->imag;
  }
}

void ENTF90(MERGEDC, mergedc)(dcmplx_t *res, dcmplx_t *tsource,
                              dcmplx_t *fsource, void *mask, __INT_T *size)
{
  if (I8(__fort_varying_log)(mask, size)) {
    res->real = tsource->real;
    res->imag = tsource->imag;
  } else {
    res->real = fsource->real;
    res->imag = fsource->imag;
  }
}

void ENTF90(MERGEQC, mergeqc)(qcmplx_t *res, qcmplx_t *tsource,
                              qcmplx_t *fsource, void *mask, __INT_T *size)
{
  if (I8(__fort_varying_log)(mask, size)) {
    res->real = tsource->real;
    res->imag = tsource->imag;
  } else {
    res->real = fsource->real;
    res->imag = fsource->imag;
  }
}

