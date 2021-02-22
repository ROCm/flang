#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:11:26 IST 2020
#

########## Make rule for test bitint07  ########


bitint07: bitint07.run

bitint07.$(OBJX):  $(SRC)/bitint07.f08
	-$(RM) bitint07.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint07.f08 -o bitint07.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint07.$(OBJX) check.$(OBJX) $(LIBS) -o bitint07.$(EXESUFFIX)


bitint07.run: bitint07.$(OBJX)
	@echo ------------------------------------ executing test bitint07
	bitint07.$(EXESUFFIX)

build:	bitint07.$(OBJX)

verify:	;

run:	 bitint07.$(OBJX)
	@echo ------------------------------------ executing test bitint07
	-bitint07.$(EXESUFFIX) ||:
