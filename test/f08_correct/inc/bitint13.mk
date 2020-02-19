#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint13  ########

bitint13: bitint13.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint13.$(OBJX):  $(SRC)/bitint13.f08
	-$(RM) bitint13.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint13.f08 -o bitint13.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint13.$(OBJX) check.$(OBJX) $(LIBS) -o bitint13.$(EXESUFFIX) ||:

bitint13.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint13
	-passok.$(EXESUFFIX) ||:

build:	bitint13.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint13
	-passok.$(EXESUFFIX) ||:
