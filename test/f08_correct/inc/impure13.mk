#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#
########## Make rule for test impure13  ########

impure13: impure13.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

impure13.$(OBJX):  $(SRC)/impure13.f08
	-$(RM) impure13.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure13.f08 -o impure13.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) impure13.$(OBJX) check.$(OBJX) $(LIBS) -o impure13.$(EXESUFFIX) ||:

impure13.run: passok.$(OBJX)
	@echo ------------------------------------ executing test impure13
	-passok.$(EXESUFFIX) ||:

build:	impure13.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test impure13
	-passok.$(EXESUFFIX) ||:
