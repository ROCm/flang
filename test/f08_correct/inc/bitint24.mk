#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint24  ########

bitint24: bitint24.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint24.$(OBJX):  $(SRC)/bitint24.f08
	-$(RM) bitint24.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint24.f08 -o bitint24.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint24.$(OBJX) check.$(OBJX) $(LIBS) -o bitint24.$(EXESUFFIX) ||:

bitint24.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint24
	-passok.$(EXESUFFIX) ||:

build:	bitint24.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint24
	-passok.$(EXESUFFIX) ||:
