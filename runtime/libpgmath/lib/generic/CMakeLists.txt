#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

add_subdirectory("math_tables")

set(FLAGS)
set(DEFINITIONS)
# Get compiler definitions
if(${LIBPGMATH_SYSTEM_PROCESSOR} MATCHES "ppc64le")
  get_property(FLAGS GLOBAL PROPERTY "FLAGS_PPC64LE_L1")
  get_property(DEFINITIONS GLOBAL PROPERTY "DEFINITIONS_PPC64LE_L1")
else()
  get_property(FLAGS GLOBAL PROPERTY "FLAGS_GENERIC_L1")
  get_property(DEFINITIONS GLOBAL PROPERTY "DEFINITIONS_GENERIC_L1")
endif()

# Generics
set(GENERIC_SRCS
  abs.c
  acos.c
  acosh.c
  aint.c
  alog10.c
  alog.c
  anint.c
  around.c
  asin.c
  asinh.c
  atan2.c
  atan.c
  atanh.c
  cos.c
  cosh.c
  dacos.c
  dacosh.c
  dasin.c
  dasinh.c
  datan2.c
  datan.c
  datanh.c
  dcos.c
  dcosh.c
  dexp.c
  dint.c
  dlog10.c
  dlog.c
  dnint.c
  dpowd.c
  dremainder.c
  dround.c
  dsin.c
  dsinh.c
  dsqrt.c
  dtan.c
  dcotan.c
  dcan.c
  dtanh.c
  exp.c
  fabs.c
  idnint.c
  knint.c
  log10.c
  log.c
  mthi64.c
  nint.c
  qnint.c
  remainder.c
  round.c
  rpowr.c
  sin.c
  sinh.c
  sqrt.c
  tan.c
  cotan.c
  tanh.c)
set(GENERIC_FLAGS "${FLAGS} -ffast-math ")
libmath_add_object_library("${GENERIC_SRCS}" "${GENERIC_FLAGS}" "${DEFINITIONS}" "")
