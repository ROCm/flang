#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint14  ########

bitint14: bitint14.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint14.$(OBJX):  $(SRC)/bitint14.f08
	-$(RM) bitint14.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint14.f08 -o bitint14.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint14.$(OBJX) check.$(OBJX) $(LIBS) -o bitint14.$(EXESUFFIX) ||:

bitint14.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint14
	-passok.$(EXESUFFIX) ||:

build:	bitint14.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint14
	-passok.$(EXESUFFIX) ||:
