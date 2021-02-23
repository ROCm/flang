#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test quad01  ########


quad01: run
	

build:  $(SRC)/quad01.f90
	-$(RM) quad01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quad01.f90 -o quad01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quad01.$(OBJX) check.$(OBJX) $(LIBS) -o quad01.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quad01
	quad01.$(EXESUFFIX)

verify: ;

quad01.run: run

