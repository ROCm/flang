#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test bitint32  ########


bitint32: bitint32.run

bitint32.$(OBJX):  $(SRC)/bitint32.f08
	-$(RM) bitint32.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint32.f08 -o bitint32.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint32.$(OBJX) check.$(OBJX) $(LIBS) -o bitint32.$(EXESUFFIX)


bitint32.run: bitint32.$(OBJX)
	@echo ------------------------------------ executing test bitint32
	bitint32.$(EXESUFFIX)

build:	bitint32.$(OBJX)

verify:	;

run:	 bitint32.$(OBJX)
	@echo ------------------------------------ executing test bitint32
	-bitint32.$(EXESUFFIX) ||:
