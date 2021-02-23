#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint08  ########


bitint08: bitint08.run

bitint08.$(OBJX):  $(SRC)/bitint08.f08
	-$(RM) bitint08.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint08.f08 -o bitint08.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint08.$(OBJX) check.$(OBJX) $(LIBS) -o bitint08.$(EXESUFFIX)


bitint08.run: bitint08.$(OBJX)
	@echo ------------------------------------ executing test bitint08
	bitint08.$(EXESUFFIX)

build:	bitint08.$(OBJX)

verify:	;

run:	 bitint08.$(OBJX)
	@echo ------------------------------------ executing test bitint08
	-bitint08.$(EXESUFFIX) ||:
