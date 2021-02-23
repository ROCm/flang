#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure05  ########


impure05: impure05.run

impure05.$(OBJX):  $(SRC)/impure05.f08
	-$(RM) impure05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure05.f08 -o impure05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure05.$(OBJX) check.$(OBJX) $(LIBS) -o impure05.$(EXESUFFIX)


impure05.run: impure05.$(OBJX)
	@echo ------------------------------------ executing test impure05
	impure05.$(EXESUFFIX)

build:	impure05.$(OBJX)

verify:	;

run:	 impure05.$(OBJX)
	@echo ------------------------------------ executing test impure05
	-impure05.$(EXESUFFIX) ||:
