#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint15  ########


bitint15: bitint15.run

bitint15.$(OBJX):  $(SRC)/bitint15.f08
	-$(RM) bitint15.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint15.f08 -o bitint15.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint15.$(OBJX) check.$(OBJX) $(LIBS) -o bitint15.$(EXESUFFIX)


bitint15.run: bitint15.$(OBJX)
	@echo ------------------------------------ executing test bitint15
	bitint15.$(EXESUFFIX)

build:	bitint15.$(OBJX)

verify:	;

run:	 bitint15.$(OBJX)
	@echo ------------------------------------ executing test bitint15
	-bitint15.$(EXESUFFIX) ||:
