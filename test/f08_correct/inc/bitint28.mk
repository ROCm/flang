#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint28  ########


bitint28: bitint28.run

bitint28.$(OBJX):  $(SRC)/bitint28.f08
	-$(RM) bitint28.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint28.f08 -o bitint28.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint28.$(OBJX) check.$(OBJX) $(LIBS) -o bitint28.$(EXESUFFIX)


bitint28.run: bitint28.$(OBJX)
	@echo ------------------------------------ executing test bitint28
	bitint28.$(EXESUFFIX)

build:	bitint28.$(OBJX)

verify:	;

run:	 bitint28.$(OBJX)
	@echo ------------------------------------ executing test bitint28
	-bitint28.$(EXESUFFIX) ||:
