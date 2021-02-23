/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/******************************************************************************
 *                                                                            *
 * Background:                                                                *
 * The POWERPC ABI does not provide for tail calls. Thus, the math dispatch   *
 * table processing incurs overhead with the saving and restoration of GPR 2  *
 * that can severely affect application performance.  For POWERPC, we use an  *
 * optimized assembly dispatch set of routines that make tail calls to all of *
 * the routines defined in the math dispatch configuration files but do not   *
 * saveand /restore GPR 2.                                                    *
 *                                                                            *
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! WARNING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! *
 *                                                                            *
 * If any entry (routine <FUNC>) in any of the dispatch tables is not present *
 * in i.e. not  satisfied by, libpgmath, in order to properly preserve/restore*
 * GRP 2 when calling routine <FUNC>, the actual function must first be       *
 * encapsulated in a routine present in libpgmath.                            *
 *                                                                            *
 * No doubt there are pathological cases that will show this engineering      *
 * choice to be wrong, but current performance testing shows otherwise.       *
 *                                                                            *
 *****************************************************************************/

MTHINTRIN(cotan  , ss   , any        , __mth_i_cotan           , __mth_i_cotan           , __mth_i_cotan           ,__math_dispatch_error)
MTHINTRIN(cotan  , ds   , any        , __mth_i_dcotan          , __mth_i_dcotan          , __mth_i_dcotan          ,__math_dispatch_error)
MTHINTRIN(cotan  , sv4  , any        , __gs_cotan_4_f          , __gs_cotan_4_r          , __gs_cotan_4_p          ,__math_dispatch_error)
MTHINTRIN(cotan  , dv2  , any        , __gd_cotan_2_f          , __gd_cotan_2_r          , __gd_cotan_2_p          ,__math_dispatch_error)
MTHINTRIN(cotan  , sv4m , any        , __fs_cotan_4_mn         , __rs_cotan_4_mn         , __ps_cotan_4_mn         ,__math_dispatch_error)
MTHINTRIN(cotan  , dv2m , any        , __fd_cotan_2_mn         , __rd_cotan_2_mn         , __pd_cotan_2_mn         ,__math_dispatch_error)
