#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#
########## Make rule for test impure03  ########

impure03: impure03.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

impure03.$(OBJX):  $(SRC)/impure03.f08
	-$(RM) impure03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure03.f08 -o impure03.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) impure03.$(OBJX) check.$(OBJX) $(LIBS) -o impure03.$(EXESUFFIX) ||:

impure03.run: passok.$(OBJX)
	@echo ------------------------------------ executing test impure03
	-passok.$(EXESUFFIX) ||:

build:	impure03.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test impure03
	-passok.$(EXESUFFIX) ||:
