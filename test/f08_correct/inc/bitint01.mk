#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint01  ########


bitint01: bitint01.run

bitint01.$(OBJX):  $(SRC)/bitint01.f08
	-$(RM) bitint01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint01.f08 -o bitint01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint01.$(OBJX) check.$(OBJX) $(LIBS) -o bitint01.$(EXESUFFIX)


bitint01.run: bitint01.$(OBJX)
	@echo ------------------------------------ executing test bitint01
	bitint01.$(EXESUFFIX)

build:	bitint01.$(OBJX)

verify:	;

run:	 bitint01.$(OBJX)
	@echo ------------------------------------ executing test bitint01
	-bitint01.$(EXESUFFIX) ||:
