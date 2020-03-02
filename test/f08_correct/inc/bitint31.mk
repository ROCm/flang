#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint31  ########

bitint31: bitint31.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint31.$(OBJX):  $(SRC)/bitint31.f08
	-$(RM) bitint31.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint31.f08 -o bitint31.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint31.$(OBJX) check.$(OBJX) $(LIBS) -o bitint31.$(EXESUFFIX) ||:

bitint31.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint31
	-passok.$(EXESUFFIX) ||:

build:	bitint31.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint31
	-passok.$(EXESUFFIX) ||:
