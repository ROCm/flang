#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure14  ########


impure14: impure14.run

impure14.$(OBJX):  $(SRC)/impure14.f08
	-$(RM) impure14.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure14.f08 -o impure14.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure14.$(OBJX) check.$(OBJX) $(LIBS) -o impure14.$(EXESUFFIX)


impure14.run: impure14.$(OBJX)
	@echo ------------------------------------ executing test impure14
	impure14.$(EXESUFFIX)

build:	impure14.$(OBJX)

verify:	;

run:	 impure14.$(OBJX)
	@echo ------------------------------------ executing test impure14
	-impure14.$(EXESUFFIX) ||:
