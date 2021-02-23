#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that support bit processing
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint18  ########


bitint18: bitint18.run

bitint18.$(OBJX):  $(SRC)/bitint18.f08
	-$(RM) bitint18.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint18.f08 -o bitint18.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint18.$(OBJX) check.$(OBJX) $(LIBS) -o bitint18.$(EXESUFFIX)


bitint18.run: bitint18.$(OBJX)
	@echo ------------------------------------ executing test bitint18
	bitint18.$(EXESUFFIX)

build:	bitint18.$(OBJX)

verify:	;

run:	 bitint18.$(OBJX)
	@echo ------------------------------------ executing test bitint18
	-bitint18.$(EXESUFFIX) ||:
