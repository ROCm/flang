#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint25  ########


bitint25: bitint25.run

bitint25.$(OBJX):  $(SRC)/bitint25.f08
	-$(RM) bitint25.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint25.f08 -o bitint25.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint25.$(OBJX) check.$(OBJX) $(LIBS) -o bitint25.$(EXESUFFIX)


bitint25.run: bitint25.$(OBJX)
	@echo ------------------------------------ executing test bitint25
	bitint25.$(EXESUFFIX)

build:	bitint25.$(OBJX)

verify:	;

run:	 bitint25.$(OBJX)
	@echo ------------------------------------ executing test bitint25
	-bitint25.$(EXESUFFIX) ||:
