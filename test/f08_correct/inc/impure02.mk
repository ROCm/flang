#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure02  ########


impure02: impure02.run

impure02.$(OBJX):  $(SRC)/impure02.f08
	-$(RM) impure02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure02.f08 -o impure02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure02.$(OBJX) check.$(OBJX) $(LIBS) -o impure02.$(EXESUFFIX)


impure02.run: impure02.$(OBJX)
	@echo ------------------------------------ executing test impure02
	impure02.$(EXESUFFIX)

build:	impure02.$(OBJX)

verify:	;

run:	 impure02.$(OBJX)
	@echo ------------------------------------ executing test impure02
	-impure02.$(EXESUFFIX) ||:
