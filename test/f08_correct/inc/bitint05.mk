#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint05  ########


bitint05: bitint05.run

bitint05.$(OBJX):  $(SRC)/bitint05.f08
	-$(RM) bitint05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint05.f08 -o bitint05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint05.$(OBJX) check.$(OBJX) $(LIBS) -o bitint05.$(EXESUFFIX)


bitint05.run: bitint05.$(OBJX)
	@echo ------------------------------------ executing test bitint05
	bitint05.$(EXESUFFIX)

build:	bitint05.$(OBJX)

verify:	;

run:	 bitint05.$(OBJX)
	@echo ------------------------------------ executing test bitint05
	-bitint05.$(EXESUFFIX) ||:
