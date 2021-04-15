#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:20:46 IST 2020
#

########## Make rule for test bitint30  ########


bitint30: bitint30.run

bitint30.$(OBJX):  $(SRC)/bitint30.f08
	-$(RM) bitint30.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint30.f08 -o bitint30.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint30.$(OBJX) check.$(OBJX) $(LIBS) -o bitint30.$(EXESUFFIX)


bitint30.run: bitint30.$(OBJX)
	@echo ------------------------------------ executing test bitint30
	bitint30.$(EXESUFFIX)

build:	bitint30.$(OBJX)

verify:	;

run:	 bitint30.$(OBJX)
	@echo ------------------------------------ executing test bitint30
	-bitint30.$(EXESUFFIX) ||:
