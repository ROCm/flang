#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Fri Apr 10 17:30:08 IST 2020
#

########## Make rule for test bitint33  ########


bitint33: bitint33.run

bitint33.$(OBJX):  $(SRC)/bitint33.f08
	-$(RM) bitint33.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint33.f08 -o bitint33.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint33.$(OBJX) check.$(OBJX) $(LIBS) -o bitint33.$(EXESUFFIX)


bitint33.run: bitint33.$(OBJX)
	@echo ------------------------------------ executing test bitint33
	bitint33.$(EXESUFFIX)

build:	bitint33.$(OBJX)

verify:	;

run:	 bitint33.$(OBJX)
	@echo ------------------------------------ executing test bitint33
	-bitint33.$(EXESUFFIX) ||:
