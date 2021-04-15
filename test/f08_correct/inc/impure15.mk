#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure15  ########


impure15: impure15.run

impure15.$(OBJX):  $(SRC)/impure15.f08
	-$(RM) impure15.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure15.f08 -o impure15.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure15.$(OBJX) check.$(OBJX) $(LIBS) -o impure15.$(EXESUFFIX)


impure15.run: impure15.$(OBJX)
	@echo ------------------------------------ executing test impure15
	impure15.$(EXESUFFIX)

build:	impure15.$(OBJX)

verify:	;

run:	 impure15.$(OBJX)
	@echo ------------------------------------ executing test impure15
	-impure15.$(EXESUFFIX) ||:
