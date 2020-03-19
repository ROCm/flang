#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Thu Mar 19 10:54:19 IST 2020
#

########## Make rule for test bitint24  ########


bitint24: bitint24.run

bitint24.$(OBJX):  $(SRC)/bitint24.f08
	-$(RM) bitint24.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint24.f08 -o bitint24.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint24.$(OBJX) check.$(OBJX) $(LIBS) -o bitint24.$(EXESUFFIX)


bitint24.run: bitint24.$(OBJX)
	@echo ------------------------------------ executing test bitint24
	bitint24.$(EXESUFFIX)

build:	bitint24.$(OBJX)

verify:	;

run:	 bitint24.$(OBJX)
	@echo ------------------------------------ executing test bitint24
	-bitint24.$(EXESUFFIX) ||:
