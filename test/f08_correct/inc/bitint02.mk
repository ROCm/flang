#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint02  ########


bitint02: bitint02.run

bitint02.$(OBJX):  $(SRC)/bitint02.f08
	-$(RM) bitint02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint02.f08 -o bitint02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint02.$(OBJX) check.$(OBJX) $(LIBS) -o bitint02.$(EXESUFFIX)


bitint02.run: bitint02.$(OBJX)
	@echo ------------------------------------ executing test bitint02
	bitint02.$(EXESUFFIX)

build:	bitint02.$(OBJX)

verify:	;

run:	 bitint02.$(OBJX)
	@echo ------------------------------------ executing test bitint02
	-bitint02.$(EXESUFFIX) ||:
