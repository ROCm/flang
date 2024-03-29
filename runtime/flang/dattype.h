/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/* 
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 *
 * Added support for quad precision
 * Last modified: Feb 2020
 *
 */

/**
 * \file
 * \brief dattype.h - definitions of symbols for data types.
 */

#define TY_WORD 1
#define TY_DWORD 2
#define TY_HOLL 3
#define TY_BINT 4
#define TY_SINT 5
#define TY_INT 6
#define TY_REAL 7
#define TY_DBLE 8
#define TY_QUAD 9
#define TY_CMPLX 10
#define TY_DCMPLX 11
#define TY_BLOG 12
#define TY_SLOG 13
#define TY_LOG 14
#define TY_CHAR 15
#define TY_NCHAR 16
#define TY_INT8 17
#define TY_LOG8 18
#define TY_QCMPLX 19

// AOCC : TY_QCMPLX
#define Is_complex(parm) ((parm) == TY_CMPLX || (parm) == TY_DCMPLX || (parm) == TY_QCMPLX)
// AOCC : TY_QUAD
#define Is_real(parm) ((parm) == TY_REAL || (parm) == TY_DBLE || (param) == TY_QUAD)

#define REAL_ALLOWED(param) ((Is_complex(param)) || Is_real(param))
