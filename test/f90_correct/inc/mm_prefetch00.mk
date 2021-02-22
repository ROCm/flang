#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for ifort's mm_prefetch intrinsic
# Last modified: Jun 2020
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test mm_prefetch00  ########


mm_prefetch00: run


build:  $(SRC)/mm_prefetch00.f90
	-$(RM) mm_prefetch00.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/mm_prefetch00.f90 -o mm_prefetch00.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) mm_prefetch00.$(OBJX) check.$(OBJX) $(LIBS) -o mm_prefetch00.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test mm_prefetch00
	mm_prefetch00.$(EXESUFFIX)

verify: ;

mm_prefetch00.run: run

