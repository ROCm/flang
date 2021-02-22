#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Inreinsics that support bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint16  ########


bitint16: bitint16.run

bitint16.$(OBJX):  $(SRC)/bitint16.f08
	-$(RM) bitint16.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint16.f08 -o bitint16.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint16.$(OBJX) check.$(OBJX) $(LIBS) -o bitint16.$(EXESUFFIX)


bitint16.run: bitint16.$(OBJX)
	@echo ------------------------------------ executing test bitint16
	bitint16.$(EXESUFFIX)

build:	bitint16.$(OBJX)

verify:	;

run:	 bitint16.$(OBJX)
	@echo ------------------------------------ executing test bitint16
	-bitint16.$(EXESUFFIX) ||:
