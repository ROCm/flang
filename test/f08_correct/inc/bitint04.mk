#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint04  ########


bitint04: bitint04.run

bitint04.$(OBJX):  $(SRC)/bitint04.f08
	-$(RM) bitint04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint04.f08 -o bitint04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint04.$(OBJX) check.$(OBJX) $(LIBS) -o bitint04.$(EXESUFFIX)


bitint04.run: bitint04.$(OBJX)
	@echo ------------------------------------ executing test bitint04
	bitint04.$(EXESUFFIX)

build:	bitint04.$(OBJX)

verify:	;

run:	 bitint04.$(OBJX)
	@echo ------------------------------------ executing test bitint04
	-bitint04.$(EXESUFFIX) ||:
