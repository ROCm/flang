#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint33  ########

bitint33: bitint33.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint33.$(OBJX):  $(SRC)/bitint33.f08
	-$(RM) bitint33.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint33.f08 -o bitint33.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint33.$(OBJX) check.$(OBJX) $(LIBS) -o bitint33.$(EXESUFFIX) ||:

bitint33.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint33
	-passok.$(EXESUFFIX) ||:

build:	bitint33.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint33
	-passok.$(EXESUFFIX) ||:
