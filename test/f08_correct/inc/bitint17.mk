#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics to support bit processing
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint17  ########


bitint17: bitint17.run

bitint17.$(OBJX):  $(SRC)/bitint17.f08
	-$(RM) bitint17.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint17.f08 -o bitint17.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint17.$(OBJX) check.$(OBJX) $(LIBS) -o bitint17.$(EXESUFFIX)


bitint17.run: bitint17.$(OBJX)
	@echo ------------------------------------ executing test bitint17
	bitint17.$(EXESUFFIX)

build:	bitint17.$(OBJX)

verify:	;

run:	 bitint17.$(OBJX)
	@echo ------------------------------------ executing test bitint17
	-bitint17.$(EXESUFFIX) ||:
