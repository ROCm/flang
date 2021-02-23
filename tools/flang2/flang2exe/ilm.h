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
 *  Last modified: Feb 2020
 *
 *
 */

#ifndef ILM_H_
#define ILM_H_

/* ***  ILM Area  *****/

/* ILM_T is defined in gbldefs.h */

typedef struct {
  ILM_T *ilm_base; /* base pointer for ILM area */
  int ilm_size;    /* size in ILM_Ts of ILM area */
  int ilmavl;      /* relative ptr to next available word */
  int globalilmstart, globalilmcount;
} ILMB;

typedef struct {
  ILM_T *ilm_base;
  int ilm_size;
  int ilmavl;
  int ilmpos;
  int globalilmcount, globalilmstart, globalilmtotal, globalilmfirst;
} GILMB;

/* ***  ILM Attributes Declarations  *****/

typedef struct {
  char *name;
  char type;
  short oprs;
  unsigned int oprflag;
  short temps;
  short pattern;
  short ilict;
} ILMINFO;

#define BOS_SIZE 4

#define IMTY_ARTH 'a'
#define IMTY_BRANCH 'b'
#define IMTY_CONS 'c'
#define IMTY_FSTR 'f'
#define IMTY_LOAD 'l'
#define IMTY_MISC 'm'
#define IMTY_PROC 'p'
#define IMTY_REF 'r'
#define IMTY_STORE 's'
#define IMTY_TRANS 't'
#define IMTY_INTR 'i'
#define IMTY_SMP 'S'

#define ILMO_NULL 0
#define ILMO_R 1
#define ILMO_RR 2
#define ILMO_IR 3
#define ILMO_KR 4
#define ILMO_T 5
#define ILMO_V 6
#define ILMO_IV 7
#define ILMO_ISYM 8
#define ILMO_RSYM 9
#define ILMO_DSYM 10
#define ILMO_ESYM 11
#define ILMO_DR 12
#define ILMO_AR 13
#define ILMO_SP 14
#define ILMO_DP 15
#define ILMO_QP 16        // AOCC
#define ILMO_SZ 17
#define ILMO_SCZ 18
#define ILMO_SCF 19
#define ILMO_ISP 20
#define ILMO_IDP 21
#define ILMO_XRSYM 22
#define ILMO_XDSYM 23
#define ILMO__ESYM 24
#define ILMO_LSYM 25
#define ILMO_LLSYM 26
#define ILMO_DRRET 27
#define ILMO_ARRET 28
#define ILMO_SPRET 29
#define ILMO_DPRET 30
#define ILMO_QPRET 31     // AOCC
#define ILMO_KRRET 32
#define ILMO_DRPOS 33
#define ILMO_ARPOS 34
#define ILMO_SPPOS 35
#define ILMO_DPPOS 36
#define ILMO_QPPOS 37     // AOCC
#define ILMO_IQP 38

#define ILMO_P 1
#define ILMO_RP 2
#define ILMO_IP 3

#define OPR_LNK 0
#define OPR_SYM 1
#define OPR_STC 2
#define OPR_N 3

#define IM_TYPE(i) ilms[i].type
#define IM_OPRFLAG(i, opn) ((ilms[i].oprflag >> (opn - 1) * 2) & 3)
#define IM_SPEC(i) (ilms[i].oprflag & 0x80000000)
#define IM_TRM(i) (ilms[i].oprflag & 0x40000000)
#define IM_VAR(i) (ilms[i].oprflag & 0x20000000)
#define IM_VEC(i) (ilms[i].oprflag & 0x10000000)
#define IM_DCPLX(i) (ilms[i].oprflag & 0x08000000)
#define IM_I8(i) (ilms[i].oprflag & 0x04000000)
#define IM_X87CPLX(i) (ilms[i].oprflag & 0x02000000)
#define IM_NOINLC(i) (ilms[i].oprflag & 0x01000000)
#define IM_DOUBLEDOUBLECPLX(i) (ilms[i].oprflag & 0x00800000)
#define IM_FLOAT128CPLX(i) (ilms[i].oprflag & 0x00400000)
#define IM_QCPLX(i) (ilms[i].oprflag & 0x00080000)

/* ***  ILM Template Declarations  *****/

typedef struct {
  short opc;
  short result;
  short opnd[1];
} ILMMAC;

typedef struct {
  short type;
  short aux;
} ILMOPND;

/* ***  ILM External Data Declarations  *****/

extern ILMB ilmb;       /*  defined in ilmutil.c  */
extern ILMINFO ilms[];  /*  defined in ilmtpdf.h  */
extern short ilmtp[];   /*  defined in ilmtpdf.h  */
extern short ilmopnd[]; /*  defined in ilmtpdf.h  */
extern char *ilmaux[];  /*  defined in ilmtpdf.h  */

/* for non array parameters, default set by attributes of the function
 */
#define BYVALDEFAULT(func) \
  (!(PASSBYREFG(func)) && (PASSBYVALG(func) | STDCALLG(func) | CFUNCG(func)))

#ifdef N_ILM /* Use N_ILM to detect whether ILM_OP is defined */
/** Check that ilmptr is plausibly a valid ILM index, and issue internal error
    with text if it is not.  Active only in DEBUG mode. */
#define ASSERT_IS_LNK(ilmptr, text)                                   \
  DEBUG_ASSERT((unsigned)(ilmptr)-1 < (unsigned)ilmb.ilmavl - 1 &&    \
                   (unsigned)(ilmb.ilm_base[ilmptr]) - 1 < N_ILM - 1, \
               (text))

#define ASSERT_IS_LABEL(labelptr, text) \
  DEBUG_ASSERT(STYPEG(labelptr) == ST_LABEL, (text))
#endif // N_ILM

#ifndef ILMTOOLBUILD
#include "ilmutil.h"
#endif

#endif // ILM_H_
