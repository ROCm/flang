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
 * Complex type support for acosh , asinh , atanh
 * Date of Modification: 08 January 2020
 *
 * Complex datatype support for atan2 under flag f2008
 * Modified on 13th March 2020
 *
 * Last Modified : Jun 2020
 *
 */
 

/**
 * \file
 * \brief  mthdecls.h - Fortran math support (all platforms/targets) 
 */

/* pi/180 */
#define DEG_TO_RAD 0.174532925199432957692E-1
/* 180/pi */
#define RAD_TO_DEG 0.572957795130823208769E+2
#define CNVRTDEG(degrees) ((degrees)*DEG_TO_RAD)
#define CNVRTRAD(radians) ((radians)*RAD_TO_DEG)


#if     defined(TARGET_LINUX)
#define _GNU_SOURCE 
#endif
#ifndef	MTH_NO_STD_MATH_HDRS
#ifdef __cplusplus
#include <cmath>
#else
#include <math.h>
#endif
#include <complex.h>
#endif
#include <quadmath.h>

/*
 * Windows does not recognize the "_Complex" keyword for complex types but does
 * know about the "_Fcomplex" (float) and "_Dcomplex" (double) types.
 *
 * To minimize support for both Windows and non-Windows systems, define two
 * typedefs, float_complex_t and double_complex_t, that are used throughout
 * libpgmath that define a system agnostic complex type.
 *
 * CPP function macro PGMATH_CMPLX_CONST should only be used to initialize
 * complex variables with constant values (not variables).
 *
 * Assignment to complex variables from float/double real/imaginary values
 * contained in variables should use either:
 * float_complex_t  pgmath_cmplxf(float r, float i);
 * or
 * double_complex_t  pgmath_cmplx(double r, double i);
 * 
 */

#if defined(TARGET_WIN_X8664) && defined(__clang__)
typedef _Fcomplex float_complex_t;
typedef _Dcomplex double_complex_t;
typedef _Qcomplex quad_complex_t;
#define	PGMATH_CMPLX_CONST(r,i)		{r, i}
#else
typedef float _Complex float_complex_t;
typedef double _Complex double_complex_t;
typedef __complex128 quad_complex_t;    // AOCC
#define	PGMATH_CMPLX_CONST(r,i)		r + I*i
#endif

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

#if defined(__PGIC__)
#undef	creal
#define creal(x) __builtin_creal(x)
double __builtin_creal(double _Complex);

#undef	cimag
#define cimag(x) __builtin_cimag(x)
double __builtin_cimag(double _Complex);

#undef	crealf
#define crealf(x) __builtin_crealf(x)
float __builtin_crealf(float _Complex);

#undef	cimagf
#define cimagf(x) __builtin_cimagf(x)
float __builtin_cimagf(float _Complex);

#undef	crealq
#define crealq(x) __builtin_crealq(x)
__float128 __builtin_crealq(__float128 _Complex);

#undef	cimagq
#define cimagq(x) __builtin_cimagq(x)
__float128 __builtin_cimagq(__float128 _Complex);
#endif

#define	MTHCONCAT___(l,r)	l##r
#define	MTHCONCAT__(l,r)	MTHCONCAT___(l,r)

#define	__MTH_C99_CMPLX_SUFFIX	_c99

/*
 * \brief  pgmath_cmplxf - return type float_complex_t from two float arguments.
 *
 * Common method across all platforms.  Does not use "real + I*imag".
 */

static inline __attribute__((always_inline)) float_complex_t  pgmath_cmplxf(float r, float i)
{
    struct {
        union {
            float_complex_t _c;
            float _f[2];
        };
    } _cf ;
    _cf._f[0] = r;
    _cf._f[1] = i;
    return _cf._c;
}

/*
 * \brief  pgmath_cmplx - return type double_complex_t from double arguments.
 *
 * Common method across all platforms.  Does not use "real + I*imag".
 */

static inline __attribute__((always_inline)) double_complex_t  pgmath_cmplx(double r, double i)
{
    struct {
        union {
            double_complex_t _z;
            double _d[2];
        };
    } _zd ;
    _zd._d[0] = r;
    _zd._d[1] = i;
    return _zd._z;
}

// AOCC begin
/*
 * \brief  pgmath_cmplxq - return type quad_complex_t from quad arguments.
 *
 * Common method across all platforms.  Does not use "real + I*imag".
 */

static inline __attribute__((always_inline)) quad_complex_t  pgmath_cmplxq(__float128 r, __float128 i)
{
    struct {
        union {
            quad_complex_t _z;
            __float128 _q[2];
        };
    } _cq ;
    _cq._q[0] = r;
    _cq._q[1] = i;
    return _cq._z;
}
// AOCC end
/*
 * Complex ABI conventions.
 *
 * The macros that define the function signature (example CMPLXFUNC_C)
 * and the macro that defines local arguments (example CMPLXFUNC_C)
 * work in tandem so that regardless of whether the native original
 * complex ABI or the C99 ABI is used, there are always the following
 * variables defined:
 *
 * carg: the argument defined as either float _Complex or double _Complex
 * real: creal(carg), crealf(carg) for float
 * imag: cimag(carg), cimagf(carg) for float
 *
 * When there are two or more complex arguments, the local variables are
 * suffixed with the digits (ie 1, 2, ...) representing their order as
 * specified in the argument list.
 */

/* Old complex ABI */
#define	FLTFUNC_C_(_f)    \
        float _f(float real, float imag)
#define	DBLFUNC_C_(_f)    \
        double _f(double real, double imag)

#define	CMPLXFUNC_C_(_f)    \
        void _f(cmplx_t *cmplx, float real, float imag)
#define	CMPLXFUNC_C_C_(_f)  \
        void _f(cmplx_t *cmplx, float real1, float imag1, \
                                  float real2, float imag2)
#define	CMPLXFUNC_C_F_(_f)  \
        void _f(cmplx_t *cmplx, float real, float imag, float r)
#define	CMPLXFUNC_C_I_(_f)  \
        void _f(cmplx_t *cmplx, float real, float imag, int i)
#define	CMPLXFUNC_C_K_(_f)  \
        void _f(cmplx_t *cmplx, float real, float imag, long long i)

#define	ZMPLXFUNC_Z_(_f)    \
        void _f(dcmplx_t *dcmplx, double real, double imag)
#define	ZMPLXFUNC_Z_Z_(_f)  \
        void _f(dcmplx_t *dcmplx, double real1, double imag1, \
                                    double real2, double imag2)
#define	ZMPLXFUNC_Z_D_(_f)  \
        void _f(dcmplx_t *dcmplx, double real, double imag, double d)
#define	ZMPLXFUNC_Z_I_(_f)  \
        void _f(dcmplx_t *dcmplx, double real, double imag, int i)
#define	ZMPLXFUNC_Z_K_(_f)  \
        void _f(dcmplx_t *dcmplx, double real, double imag, long long i)

// AOCC begin
#define	QMPLXFUNC_Q_(_f)    \
        void _f(qcmplx_t *qcmplx, __float128 real, __float128 imag)
#define	QMPLXFUNC_Q_Q_(_f)  \
        void _f(qcmplx_t *qcmplx, __float128 real1, __float128 imag1, \
                                    __float128 real2, __float128 imag2)
#define	QMPLXFUNC_C_Q_(_f)  \
        void _f(qcmplx_t *qcmplx, __float128 real, __float128 imag, __float128 d)
#define	QMPLXFUNC_C_I_(_f)  \
        void _f(qcmplx_t *qcmplx, __float128 real, __float128 imag, int i)
#define	QMPLXFUNC_C_K_(_f)  \
        void _f(qcmplx_t *qcmplx, __float128 real, __float128 imag, long long i)
// AOCC end
/* C99 complex ABI */
#define	FLTFUNC_C_C99_(_f)    \
        float MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg)
#define	DBLFUNC_C_C99_(_f)    \
        double MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg)
#define QUADFUNC_C_C99_(_f)    \
        __float128 MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg)

#define	CMPLXFUNC_C_C99_(_f)    \
        float_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg)
#define	CMPLXFUNC_C_C_C99_(_f)  \
        float_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg1, float_complex_t carg2)
#define	CMPLXFUNC_C_F_C99_(_f)  \
        float_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg, float r)
#define	CMPLXFUNC_C_I_C99_(_f)  \
        float_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg, int i)
#define	CMPLXFUNC_C_K_C99_(_f)  \
        float_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (float_complex_t carg, long long i)

#define	ZMPLXFUNC_Z_C99_(_f)    \
        double_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg)
#define	ZMPLXFUNC_Z_Z_C99_(_f)  \
        double_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg1, double_complex_t zarg2)
#define	ZMPLXFUNC_Z_D_C99_(_f)  \
        double_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg, double d)
#define	ZMPLXFUNC_Z_I_C99_(_f)  \
        double_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg, int i)
#define	ZMPLXFUNC_Z_K_C99_(_f)  \
        double_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (double_complex_t zarg, long long i)

// AOCC begin
#define	QMPLXFUNC_Q_C99_(_f)    \
        quad_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg)
#define	QMPLXFUNC_Q_Q_C99_(_f)  \
        quad_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg1, quad_complex_t qarg2)
#define	QMPLXFUNC_C_Q_C99_(_f)  \
        quad_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg, __float128 q)
#define	QMPLXFUNC_C_I_C99_(_f)  \
        quad_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg, int i)
#define	QMPLXFUNC_C_K_C99_(_f)  \
        quad_complex_t MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX) \
        (quad_complex_t qarg, long long i)
// AOCC end
#ifndef	MTH_CMPLX_C99_ABI

#define	FLTFUNC_C(_f)		FLTFUNC_C_(_f)
#define	DBLFUNC_C(_f)		DBLFUNC_C_(_f)

#define	CMPLXFUNC_C(_f)		CMPLXFUNC_C_(_f)
#define	CMPLXFUNC_C_C(_f)	CMPLXFUNC_C_C_(_f)
#define	CMPLXFUNC_C_F(_f)	CMPLXFUNC_C_F_(_f)
#define	CMPLXFUNC_C_I(_f)	CMPLXFUNC_C_I_(_f)
#define	CMPLXFUNC_C_K(_f)	CMPLXFUNC_C_K_(_f)

#define	ZMPLXFUNC_Z(_f)		ZMPLXFUNC_Z_(_f)
#define	ZMPLXFUNC_Z_Z(_f)	ZMPLXFUNC_Z_Z_(_f)
#define	ZMPLXFUNC_Z_D(_f)	ZMPLXFUNC_Z_D_(_f)
#define	ZMPLXFUNC_Z_I(_f)	ZMPLXFUNC_Z_I_(_f)
#define	ZMPLXFUNC_Z_K(_f)	ZMPLXFUNC_Z_K_(_f)

// AOCC begin
#define	QMPLXFUNC_Q(_f)		QMPLXFUNC_Q_(_f)
#define	QMPLXFUNC_Q_Q(_f)	QMPLXFUNC_Q_Q_(_f)
#define	QMPLXFUNC_C_Q(_f)	QMPLXFUNC_C_Q_(_f)
#define	QMPLXFUNC_C_I(_f)	QMPLXFUNC_C_I_(_f)
#define	QMPLXFUNC_C_K(_f)	QMPLXFUNC_C_K_(_f)
// AOCC end

#define CMPLXARGS_C		float_complex_t                                \
				carg = pgmath_cmplxf(real, imag)
#define ZMPLXARGS_Z		double_complex_t                               \
				zarg = pgmath_cmplx(real, imag)

#define QMPLXARGS_Q		quad_complex_t                                 \
                                qarg = pgmath_cmplxq(real, imag)

#define CMPLXARGS_C_C		float_complex_t                                \
				carg1 = pgmath_cmplxf(real1, imag1),\
				carg2 = pgmath_cmplxf(real2, imag2)
#define CMPLXARGS_C_F
#define CMPLXARGS_C_I
#define CMPLXARGS_C_K
#define ZMPLXARGS_Z_Z		double_complex_t                               \
				zarg1 = pgmath_cmplx(real1, imag1),\
				zarg2 = pgmath_cmplx(real2, imag2)
#define ZMPLXARGS_Z_D
#define ZMPLXARGS_Z_I
#define ZMPLXARGS_Z_K

// AOCC begin
#define QMPLXARGS_Q_Q		quad_complex_t                               \
				qarg1 = pgmath_cmplxq(real1, imag1),\
				qarg2 = pgmath_cmplxq(real2, imag2)
#define QMPLXARGS_C_Q
#define QMPLXARGS_C_I
#define QMPLXARGS_C_K
// AOCC end

#define	CRETURN_F_F(_r, _i) do { cmplx->real = (_r); cmplx->imag = (_i); return; } while (0)
#define	ZRETURN_D_D(_r, _i) do { dcmplx->real = (_r); dcmplx->imag = (_i); return; } while (0)
#define	QRETURN_Q_Q(_r, _i) do { qcmplx->real = (_r); qcmplx->imag = (_i); return; } while (0)
#define CRETURN_C(_c)       do { (*cmplx = *((cmplx_t *)&(_c))); return; } while (0)
#define ZRETURN_Z(_z)       do { (*dcmplx = *((dcmplx_t *)&(_z))); return; } while (0)
#define QRETURN_C(_c)       do { (*qcmplx = *((qcmplx_t *)&(_c))); return; } while (0)
#define CRETURN_F(_f)       return (_f)
#define ZRETURN_D(_d)       return (_d)
#define QRETURN_Q(_q)       return (_q)

#define CMPLX_CALL_CR_C_C(_f,_cr,_c1,_c2) \
{ _f(cmplx, crealf(_c1), cimagf(_c1), crealf(_c2), cimagf(_c2)); \
  *(cmplx_t *)&_cr = *cmplx; }
#define ZMPLX_CALL_ZR_Z_Z(_f,_zr,_z1,_z2) \
{ _f(dcmplx, creal(_z1), cimag(_z1), creal(_z2), cimag(_z2)); \
  *(dcmplx_t *)&_zr = *dcmplx; }
#define QMPLX_CALL_QR_Q_Q(_f,_qr,_q1,_q2) \
{ _f(qcmplx, crealq(_q1), cimagq(_q1), crealq(_q2), cimagq(_q2)); \
  __real__ _qr = qcmplx->real; __imag__ _qr = qcmplx->imag; }

#else		/* #ifdef MTH_CMPLX_C99_ABI */

#define	FLTFUNC_C(_f)		FLTFUNC_C_C99_(_f)
#define	DBLFUNC_C(_f)		DBLFUNC_C_C99_(_f)

#define	CMPLXFUNC_C(_f)		CMPLXFUNC_C_C99_(_f)
#define	CMPLXFUNC_C_C(_f)	CMPLXFUNC_C_C_C99_(_f)
#define	CMPLXFUNC_C_F(_f)	CMPLXFUNC_C_F_C99_(_f)
#define	CMPLXFUNC_C_I(_f)	CMPLXFUNC_C_I_C99_(_f)
#define	CMPLXFUNC_C_K(_f)	CMPLXFUNC_C_K_C99_(_f)

#define	ZMPLXFUNC_Z(_f)		ZMPLXFUNC_Z_C99_(_f)
#define	ZMPLXFUNC_Z_Z(_f)	ZMPLXFUNC_Z_Z_C99_(_f)
#define	ZMPLXFUNC_Z_D(_f)	ZMPLXFUNC_Z_D_C99_(_f)
#define	ZMPLXFUNC_Z_I(_f)	ZMPLXFUNC_Z_I_C99_(_f)
#define	ZMPLXFUNC_Z_K(_f)	ZMPLXFUNC_Z_K_C99_(_f)

#define	QMPLXFUNC_Q(_f)		QMPLXFUNC_Q_C99_(_f)
#define	QMPLXFUNC_Q_Q(_f)	QMPLXFUNC_Q_Q_C99_(_f)
#define	QMPLXFUNC_C_Q(_f)	QMPLXFUNC_C_Q_C99_(_f)
#define	QMPLXFUNC_C_I(_f)	QMPLXFUNC_C_I_C99_(_f)
#define	QMPLXFUNC_C_K(_f)	QMPLXFUNC_C_K_C99_(_f)

#define CMPLXARGS_C     float real = crealf(carg), imag = cimagf(carg)
#define CMPLXARGS_C_C   float real1 = crealf(carg1), imag1 = cimagf(carg1), \
                              real2 = crealf(carg2), imag2 = cimagf(carg2)
#define	CMPLXARGS_C_F	CMPLXARGS_C
#define	CMPLXARGS_C_I	CMPLXARGS_C
#define	CMPLXARGS_C_K	CMPLXARGS_C

#define ZMPLXARGS_Z     double real = creal(zarg), imag = cimag(zarg)
#define ZMPLXARGS_Z_Z   double real1 = creal(zarg1), imag1 = cimag(zarg1), \
                               real2 = creal(zarg2), imag2 = cimag(zarg2)
#define	ZMPLXARGS_Z_D	ZMPLXARGS_Z
#define	ZMPLXARGS_Z_I	ZMPLXARGS_Z
#define	ZMPLXARGS_Z_K	ZMPLXARGS_Z

#define QMPLXARGS_Q	__float128 real = crealq(qarg), imag = cimagq(qarg)
#define QMPLXARGS_Q_Q   __float128 real1 = crealq(qarg1), imag1 = cimagq(qarg1), \
                               real2 = crealq(qarg2), imag2 = cimagq(qarg2)
#define	QMPLXARGS_C_Q	QMPLXARGS_Q
#define	QMPLXARGS_C_I	QMPLXARGS_Q
#define	QMPLXARGS_C_K	QMPLXARGS_Q

#define        CRETURN_F_F(_r, _i) { float_complex_t __r = pgmath_cmplxf(_r, _i); return __r; }
#define        ZRETURN_D_D(_r, _i) { double_complex_t __r = pgmath_cmplx(_r, _i); return __r; }
#define        QRETURN_Q_Q(_r, _i) { quad_complex_t __r = pgmath_cmplxq(_r, _i); return __r; }
#define CRETURN_C(_c)       return (_c)
#define ZRETURN_Z(_z)       return (_z)
#define QRETURN_C(_c)       return (_c)
#define QRETURN_Q(_q)       return (_q)
#define CRETURN_F(_f)       return (_f)
#define ZRETURN_D(_d)       return (_d)

#define CMPLX_CALL_CR_C_C(_f,_cr,_c1,_c2) \
{_cr = MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX)(_c1, _c2); }
#define ZMPLX_CALL_ZR_Z_Z(_f,_zr,_z1,_z2) \
{_zr = MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX)(_z1, _z2); }
#define QMPLX_CALL_QR_Q_Q(_f,_qr,_q1,_q2) \
{_qr = MTHCONCAT__(_f,__MTH_C99_CMPLX_SUFFIX)(_q1, _q2); }

#endif		/* #ifdef MTH_CMPLX_C99_ABI */

/*
 * Define _Complex function declarations for both old and C99 ABI.
 * Declarations should only be used in mthdecls.h.
 * Function definitions should use/begin with the "...FUNC_..." macros.
 *
 * Note: semicolon ";" in statements.
 */
#define	FLTDECL_C(_f)		FLTFUNC_C_(_f)     ; FLTFUNC_C_C99_(_f);
#define	DBLDECL_C(_f)		DBLFUNC_C_(_f)     ; DBLFUNC_C_C99_(_f);

#define	CMPLXDECL_C(_f)		CMPLXFUNC_C_(_f)   ; CMPLXFUNC_C_C99_(_f);
#define	CMPLXDECL_C_C(_f)	CMPLXFUNC_C_C_(_f) ; CMPLXFUNC_C_C_C99_(_f);
#define	CMPLXDECL_C_F(_f)	CMPLXFUNC_C_F_(_f) ; CMPLXFUNC_C_F_C99_(_f);
#define	CMPLXDECL_C_I(_f)	CMPLXFUNC_C_I_(_f) ; CMPLXFUNC_C_I_C99_(_f);
#define	CMPLXDECL_C_K(_f)	CMPLXFUNC_C_K_(_f) ; CMPLXFUNC_C_K_C99_(_f);

#define	ZMPLXDECL_Z(_f)		ZMPLXFUNC_Z_(_f)   ; ZMPLXFUNC_Z_C99_(_f);
#define	ZMPLXDECL_Z_Z(_f)	ZMPLXFUNC_Z_Z_(_f) ; ZMPLXFUNC_Z_Z_C99_(_f);
#define	ZMPLXDECL_Z_D(_f)	ZMPLXFUNC_Z_D_(_f) ; ZMPLXFUNC_Z_D_C99_(_f);
#define	ZMPLXDECL_Z_I(_f)	ZMPLXFUNC_Z_I_(_f) ; ZMPLXFUNC_Z_I_C99_(_f);
#define	ZMPLXDECL_Z_K(_f)	ZMPLXFUNC_Z_K_(_f) ; ZMPLXFUNC_Z_K_C99_(_f);

#define	QMPLXDECL_Q(_f)		QMPLXFUNC_Q_(_f)   ; QMPLXFUNC_Q_C99_(_f);
#define	QMPLXDECL_Q_Q(_f)	QMPLXFUNC_Q_Q_(_f) ; QMPLXFUNC_Q_Q_C99_(_f);
#define	QMPLXDECL_C_Q(_f)	QMPLXFUNC_C_Q_(_f) ; QMPLXFUNC_C_Q_C99_(_f);
#define	QMPLXDECL_C_I(_f)	QMPLXFUNC_C_I_(_f) ; QMPLXFUNC_C_I_C99_(_f);
#define	QMPLXDECL_C_K(_f)	QMPLXFUNC_C_K_(_f) ; QMPLXFUNC_C_K_C99_(_f);

/*
 * Universal set of CPP object macros that map the Bessel functions
 * to the different entry points for the various architectures.
 */

#if defined(WIN64)
/*
 * Windows.
 */
#define BESSEL_J0F _j0
#define BESSEL_J1F _j1
#define BESSEL_JNF _jn
#define BESSEL_Y0F _y0
#define BESSEL_Y1F _y1
#define BESSEL_YNF _yn

#define BESSEL_J0 _j0
#define BESSEL_J1 _j1
#define BESSEL_JN _jn
#define BESSEL_Y0 _y0
#define BESSEL_Y1 _y1
#define BESSEL_YN _yn

#elif	defined(TARGET_OSX)
/*
 * OSX.
 */
#define BESSEL_J0F j0
#define BESSEL_J1F j1
#define BESSEL_JNF jn
#define BESSEL_Y0F y0
#define BESSEL_Y1F y1
#define BESSEL_YNF yn

#define BESSEL_J0 j0
#define BESSEL_J1 j1
#define BESSEL_JN jn
#define BESSEL_Y0 y0
#define BESSEL_Y1 y1
#define BESSEL_YN yn
#else
/*
 * All others.
 */
#define BESSEL_J0F j0f
#define BESSEL_J1F j1f
#define BESSEL_JNF jnf
#define BESSEL_Y0F y0f
#define BESSEL_Y1F y1f
#define BESSEL_YNF ynf

#define BESSEL_J0Q j0q
#define BESSEL_J1Q j1q
#define BESSEL_JNQ jnq
#define BESSEL_Y0Q y0q
#define BESSEL_Y1Q y1q
#define BESSEL_YNQ ynq

#define BESSEL_J0 j0
#define BESSEL_J1 j1
#define BESSEL_JN jn
#define BESSEL_Y0 y0
#define BESSEL_Y1 y1
#define BESSEL_YN yn
#endif		/* #if defined (WIN64) */

/*  declarations for math functions */

float __mth_i_acos(float f);
float __mth_i_acosh(float f);
float __mth_i_alog(float f);
float __mth_i_alog10(float f);
float __mth_i_asin(float f);
float __mth_i_asinh(float f);
float __mth_i_atan(float f);
float __mth_i_atanh(float f);
float __mth_i_atan2(float f, float g);
float __mth_i_exp(float f);
float __mth_i_rpowr(float f, float g);
float __mth_i_sin(float f);
float __mth_i_sinh(float f);
float __mth_i_sqrt(float f);
float __mth_i_cotan(float f);
float __mth_i_tan(float f);
float __mth_i_tanh(float f);
float __mth_i_amod(float f, float g);
float __mth_i_aint(float f);
float __mth_i_anint(float f);
float __mth_i_cosh(float f);
float __mth_i_cos(float f);
float __mth_i_rpowi(float x, int i);
float __mth_i_rpowk(float x, long long i);
float __pmth_i_rpowi(float x, int i);		/* Compute R4**I8 in R8 precision */
float __pmth_i_rpowk(float x, long long i);	/* Compute R4**I4 in R8 precision */
float __mth_i_acosd(float f);
float __mth_i_asind(float f);
float __mth_i_atand(float f);
float __mth_i_atan2d(float f, float g);
float __mth_i_sind(float f);
float __mth_i_tand(float f);
float __mth_i_cotand(float f);
float __mth_i_cosd(float f);
float __mth_i_erf(float f);
float __mth_i_erfc(float f);
float __mth_i_erfc_scaled(float f);
float __mth_i_gamma(float f);
float __mth_i_log_gamma(float f);
float __mth_i_hypotf(float x, float y);
float __mth_i_bessel_j0(float arg);
float __mth_i_bessel_j1(float arg);
float __mth_i_bessel_jn(int n, float arg);
float __f90_bessel_jn(int n1, int n2, float f);
float __mth_i_bessel_y0(float arg);
float __mth_i_bessel_y1(float arg);
float __mth_i_bessel_yn(int n, float arg);
float __f90_bessel_yn(int n1, int n2, float f);
float __mth_i_ceil(float);
float __mth_i_floor(float);

int __mth_i_idnint(double d);
int __mth_i_mod(int i, int j);
int __mth_i_nint(float d);
int __mth_i_qnint(__float128 q);
int __mth_i_ipowi(int x, int i);

double __mth_i_dacos(double d);
double __mth_i_dacosh(double d);
double __mth_i_dasin(double d);
double __mth_i_dasinh(double d);
double __mth_i_datan(double d);
double __mth_i_datanh(double d);
double __mth_i_datan2(double x, double y);
double __mth_i_dcos(double d);
double __mth_i_dcosh(double d);
double __mth_i_dexp(double d);
double __mth_i_dlog(double d);
double __mth_i_dlog10(double d);
double __mth_i_dpowd(double x, double y);
double __mth_i_dsin(double d);
double __mth_i_dsinh(double d);
double __mth_i_dsqrt(double d);
double __mth_i_dtan(double d);
double __mth_i_dcotan(double d);
double __mth_i_dtanh(double d);
double __mth_i_dmod(double f, double g);
double __mth_i_dint(double d);
double __mth_i_dnint(double d);
double __mth_i_dpowi(double x, int i);
double __mth_i_dpowk(double x, long long i);
double __pmth_i_dpowi(double x, int i);		/* Compute R8**I8 in R16 precision */
double __pmth_i_dpowk(double x, long long i);	/* Compute R8**I4 in R16 precision */
double __mth_i_dacosd(double f);
double __mth_i_dasind(double f);
double __mth_i_datand(double f);
double __mth_i_datan2d(double f, double g);
double __mth_i_dsind(double f);
double __mth_i_dtand(double f);
double __mth_i_dcotand(double f);
double __mth_i_dcosd(double f);
double __mth_i_derf(double f);
double __mth_i_derfc(double f);
double __mth_i_derfc_scaled(double f);
double __mth_i_dgamma(double f);
double __mth_i_dlog_gamma(double f);
__float128 __mth_i_qlog_gamma(__float128 f);
double __mth_i_dhypot(double, double);
double __mth_i_pow(double, double);
double __mth_i_dbessel_j0(double arg);
double __mth_i_dbessel_j1(double arg);
double __mth_i_dbessel_jn(int n, double arg);
double __f90_dbessel_jn(int n1, int n, double d);
double __mth_i_dbessel_y0(double arg);
double __mth_i_dbessel_y1(double arg);
double __mth_i_dbessel_yn(int n, double arg);
double __f90_dbessel_yn(int n1, int n, double d);
__float128 __mth_i_qbessel_j0(__float128 arg);
__float128 __mth_i_qbessel_j1(__float128 arg);
__float128 __mth_i_qbessel_jn(int n, __float128 arg);
__float128 __f90_qbessel_jn(int n1, int n, __float128 d);
__float128 __mth_i_qbessel_y0(__float128 arg);
__float128 __mth_i_qbessel_y1(__float128 arg);
__float128 __mth_i_qbessel_yn(int n, __float128 arg);
__float128 __f90_qbessel_yn(int n1, int n, __float128 d);
double __mth_i_dceil(double);
double __mth_i_dfloor(double);

#if	! defined (TARGET_X8664) && ! defined(LINUX8664)
/*
 * See explanation below for rationale behind the two flavors of __mth_sincos.
 */
static inline void __mth_sincos(float angle, float *s, float *c)
        __attribute__((always_inline));
static inline void __mth_dsincos(double angle, double *s, double *c)
        __attribute__((always_inline));
static inline void __mth_qsincos(__float128 angle, __float128 *s, __float128 *c)
        __attribute__((always_inline));
#else	/* ! defined (TARGET_X8664) && ! defined(LINUX8664) */
void __mth_sincos(float, float *, float *);
void __mth_dsincos(double, double *, double *);
void __mth_qsincos(__float128, __float128 *, __float128 *);
#endif	/* ! defined (TARGET_X8664) && ! defined(LINUX8664) */

#if defined(__CDECL)
# error __CDECL already defined
#endif
#if defined(TARGET_WIN_X8664) && defined(__clang__)
# define	__CDECL	__cdecl
#else
# define	__CDECL
#endif
FLTDECL_C(__mth_i_cabs);
CMPLXDECL_C(__mth_i_cacos);
CMPLXDECL_C(__mth_i_casin);
CMPLXDECL_C(__mth_i_catan);
CMPLXDECL_C(__mth_i_ccos);
CMPLXDECL_C(__mth_i_ccosh);
__CDECL CMPLXDECL_C_C(__mth_i_cdiv);
__CDECL CMPLXDECL_C_F(__mth_i_cdivr);
CMPLXDECL_C(__mth_i_cexp);
CMPLXDECL_C(__mth_i_clog);
__CDECL CMPLXDECL_C_C(__mth_i_cpowc);
CMPLXDECL_C_I(__mth_i_cpowi);
CMPLXDECL_C_K(__mth_i_cpowk);
CMPLXDECL_C(__mth_i_csin);
CMPLXDECL_C(__mth_i_csinh);
CMPLXDECL_C(__mth_i_csqrt);
CMPLXDECL_C(__mth_i_ctan);
CMPLXDECL_C(__mth_i_ccotan);
CMPLXDECL_C(__mth_i_ctanh);
//AOCC Begin
CMPLXDECL_C(__mth_i_cacosh);
CMPLXDECL_C(__mth_i_casinh);
CMPLXDECL_C(__mth_i_catanh);
CMPLXDECL_C_C(__mth_i_catan2);
//AOCC End

DBLDECL_C(__mth_i_cdabs);
ZMPLXDECL_Z(__mth_i_cdacos);
ZMPLXDECL_Z(__mth_i_cdasin);
ZMPLXDECL_Z(__mth_i_cdatan);
ZMPLXDECL_Z(__mth_i_cdcos);
ZMPLXDECL_Z(__mth_i_cdcosh);
__CDECL ZMPLXDECL_Z_Z(__mth_i_cddiv);
__CDECL ZMPLXDECL_Z_D(__mth_i_cddivd);
ZMPLXDECL_Z(__mth_i_cdexp);
ZMPLXDECL_Z(__mth_i_cdlog);
__CDECL ZMPLXDECL_Z_Z(__mth_i_cdpowcd);
ZMPLXDECL_Z_I(__mth_i_cdpowi);
ZMPLXDECL_Z_K(__mth_i_cdpowk);
ZMPLXDECL_Z(__mth_i_cdsin);
ZMPLXDECL_Z(__mth_i_cdsinh);
ZMPLXDECL_Z(__mth_i_cdsqrt);
ZMPLXDECL_Z(__mth_i_cdtan);
ZMPLXDECL_Z(__mth_i_cdcotan);
ZMPLXDECL_Z(__mth_i_cdtanh);
// AOCC begin
__CDECL QMPLXDECL_Q_Q(__mth_i_cqdiv);
QMPLXDECL_C_I(__mth_i_cqpowi);
QMPLXDECL_C_K(__mth_i_cqpowk);
// AOCC end



#if defined(TARGET_WIN)
#if	! defined(_C_COMPLEX_T)
/*
 * Newer versions of MS' complex.h header file define the following functions.
 */
extern float_complex_t cacosf(float_complex_t);
extern double_complex_t cacos(double_complex_t);
extern float_complex_t casinf(float_complex_t);
extern double_complex_t casin(double_complex_t);
extern float_complex_t catanf(float_complex_t);
extern double_complex_t catan(double_complex_t);
extern float_complex_t ccoshf(float_complex_t);
extern double_complex_t ccosh(double_complex_t);
extern float_complex_t csinhf(float_complex_t);
extern double_complex_t csinh(double_complex_t);
extern float_complex_t ctanhf(float_complex_t);
extern double_complex_t ctanh(double_complex_t);
extern float_complex_t ctanf(float_complex_t);
extern double_complex_t ctan(double_complex_t);
//AOCC begin
extern float_complex_t cacoshf(float_complex_t);
extern double_complex_t cacosh(double_complex_t);
extern float_complex_t casinhf(float_complex_t);
extern double_complex_t casinh(double_complex_t);
extern float_complex_t catanhf(float_complex_t);
extern double_complex_t catanh(double_complex_t);
extern double_complex_t catan2(double_complex_t, double_complex_t);
//AOCC end

#endif		/* #if	! defined(_C_COMPLEX_T) */
#endif		/* #if	defined(TARGET_WIN) */

/*
 * The following intrinsics are defined for platforms that do not have
 * architecture specific versions.
 * It is an attempt to standardize the math library source code across
 * architectures.
 *
 * For example: cexp.c was coded as:
 * #include "mthdecls.h"
 *
 * 	void
 * 	__mth_i_cexp(cmplx_t *cmplx, float real, float imag)
 *	 {
 *	   float x, y, z;
 *	    x = EXPF(real);
 *	 #ifndef LINUX8664
 *	    y = COSF(imag);
 *	    z = SINF(imag);
 *	  #else
 *	    __mth_sincos(imag, &z, &y);
 *	  #endif
 *	    y *= x;
 *	    z *= x;
 *	    r_dummy(y, z);
 *	  }
 *
 * The special casing of whether __mth_sincos() is available for
 * individual source files is not scalable.  A better alternative is to
 * have a version of __mth_sincos, even if it is not external available
 * during the build process.
 */

#if	defined(TARGET_WIN_X8664)
static inline __attribute__((always_inline)) void __mth_sincos(float angle, float *s, float *c)
{
  *s = sinf(angle);
  *c = cosf(angle);
}
static inline void __attribute__((always_inline)) __mth_dsincos(double angle, double *s, double *c)
{
  *s = sin(angle);
  *c = cos(angle);
}
// AOCC begin
static inline void __attribute__((always_inline)) __mth_qsincos(__float128 angle, __float128 *s, __float128 *c)
{
  *s = sin(angle);
  *c = cos(angle);
}
// AOCC end
#elif	defined (TARGET_OSX_X8664) /* if	defined(TARGET_WIN_X8664) */
#define		__mth_sincos(_a,_s,_c) __sincosf(_a,_s,_c)
#define		__mth_dsincos(_a,_s,_c) __sincos(_a,_s,_c)
#define		__mth_qsincos(_a,_s,_c) __sincosq(_a,_s,_c)
#else	/* if	defined(TARGET_WIN_X8664) */
#define		__mth_sincos(_a,_s,_c) sincosf(_a,_s,_c)
#define		__mth_dsincos(_a,_s,_c) sincos(_a,_s,_c)
#define		__mth_qsincos(_a,_s,_c) __sincosq(_a,_s,_c)
#endif/* if	defined(TARGET_WIN_X8664) */
