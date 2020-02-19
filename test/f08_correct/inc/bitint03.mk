#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint03  ########


bitint03: bitint03.run

bitint03.$(OBJX):  $(SRC)/bitint03.f08
	-$(RM) bitint03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint03.f08 -o bitint03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint03.$(OBJX) check.$(OBJX) $(LIBS) -o bitint03.$(EXESUFFIX)


bitint03.run: bitint03.$(OBJX)
	@echo ------------------------------------ executing test bitint03
	bitint03.$(EXESUFFIX)

build:	bitint03.$(OBJX)

verify:	;

run:	 bitint03.$(OBJX)
	@echo ------------------------------------ executing test bitint03
	-bitint03.$(EXESUFFIX) ||:
