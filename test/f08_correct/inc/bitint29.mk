#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test bitint29  ########


bitint29: bitint29.run

bitint29.$(OBJX):  $(SRC)/bitint29.f08
	-$(RM) bitint29.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint29.f08 -o bitint29.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint29.$(OBJX) check.$(OBJX) $(LIBS) -o bitint29.$(EXESUFFIX)


bitint29.run: bitint29.$(OBJX)
	@echo ------------------------------------ executing test bitint29
	bitint29.$(EXESUFFIX)

build:	bitint29.$(OBJX)

verify:	;

run:	 bitint29.$(OBJX)
	@echo ------------------------------------ executing test bitint29
	-bitint29.$(EXESUFFIX) ||:
