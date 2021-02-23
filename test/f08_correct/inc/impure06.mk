#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#
########## Make rule for test impure06  ########

impure06: impure06.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

impure06.$(OBJX):  $(SRC)/impure06.f08
	-$(RM) impure06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure06.f08 -o impure06.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) impure06.$(OBJX) check.$(OBJX) $(LIBS) -o impure06.$(EXESUFFIX) ||:

impure06.run: passok.$(OBJX)
	@echo ------------------------------------ executing test impure06
	-passok.$(EXESUFFIX) ||:

build:	impure06.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test impure06
	-passok.$(EXESUFFIX) ||:
