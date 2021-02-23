#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#
########## Make rule for test impure08  ########

impure08: impure08.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

impure08.$(OBJX):  $(SRC)/impure08.f08
	-$(RM) impure08.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure08.f08 -o impure08.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) impure08.$(OBJX) check.$(OBJX) $(LIBS) -o impure08.$(EXESUFFIX) ||:

impure08.run: passok.$(OBJX)
	@echo ------------------------------------ executing test impure08
	-passok.$(EXESUFFIX) ||:

build:	impure08.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test impure08
	-passok.$(EXESUFFIX) ||:
