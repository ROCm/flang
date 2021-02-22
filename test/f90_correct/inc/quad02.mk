#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test quad02  ########


quad02: run


build:  $(SRC)/quad02.f90
	-$(RM) quad02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quad02.f90 -o quad02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quad02.$(OBJX) check.$(OBJX) $(LIBS) -o quad02.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quad02
	quad02.$(EXESUFFIX)

verify: ;

quad02.run: run

