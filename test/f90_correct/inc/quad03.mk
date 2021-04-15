#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#

########## Make rule for test quad03  ########


quad03: run


build:  $(SRC)/quad03.f90
	-$(RM) quad03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quad03.f90 -o quad03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quad03.$(OBJX) check.$(OBJX) $(LIBS) -lquadmath -o quad03.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quad03
	quad03.$(EXESUFFIX)

verify: ;

quad03.run: run

