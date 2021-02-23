#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#
########## Make rule for test impure16  ########

impure16: impure16.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

impure16.$(OBJX):  $(SRC)/impure16.f08
	-$(RM) impure16.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure16.f08 -o impure16.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) impure16.$(OBJX) check.$(OBJX) $(LIBS) -o impure16.$(EXESUFFIX) ||:

impure16.run: passok.$(OBJX)
	@echo ------------------------------------ executing test impure16
	-passok.$(EXESUFFIX) ||:

build:	impure16.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test impure16
	-passok.$(EXESUFFIX) ||:
