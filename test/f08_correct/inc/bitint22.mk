#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint22  ########


bitint22: bitint22.run

bitint22.$(OBJX):  $(SRC)/bitint22.f08
	-$(RM) bitint22.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint22.f08 -o bitint22.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint22.$(OBJX) check.$(OBJX) $(LIBS) -o bitint22.$(EXESUFFIX)


bitint22.run: bitint22.$(OBJX)
	@echo ------------------------------------ executing test bitint22
	bitint22.$(EXESUFFIX)

build:	bitint22.$(OBJX)

verify:	;

run:	 bitint22.$(OBJX)
	@echo ------------------------------------ executing test bitint22
	-bitint22.$(EXESUFFIX) ||:
