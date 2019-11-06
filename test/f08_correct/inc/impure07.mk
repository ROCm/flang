#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure07  ########


impure07: impure07.run

impure07.$(OBJX):  $(SRC)/impure07.f08
	-$(RM) impure07.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure07.f08 -o impure07.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure07.$(OBJX) check.$(OBJX) $(LIBS) -o impure07.$(EXESUFFIX)


impure07.run: impure07.$(OBJX)
	@echo ------------------------------------ executing test impure07
	impure07.$(EXESUFFIX)

build:	impure07.$(OBJX)

verify:	;

run:	 impure07.$(OBJX)
	@echo ------------------------------------ executing test impure07
	-impure07.$(EXESUFFIX) ||:
