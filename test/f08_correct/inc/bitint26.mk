#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:11:26 IST 2020
#

########## Make rule for test bitint26  ########


bitint26: bitint26.run

bitint26.$(OBJX):  $(SRC)/bitint26.f08
	-$(RM) bitint26.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint26.f08 -o bitint26.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint26.$(OBJX) check.$(OBJX) $(LIBS) -o bitint26.$(EXESUFFIX)


bitint26.run: bitint26.$(OBJX)
	@echo ------------------------------------ executing test bitint26
	bitint26.$(EXESUFFIX)

build:	bitint26.$(OBJX)

verify:	;

run:	 bitint26.$(OBJX)
	@echo ------------------------------------ executing test bitint26
	-bitint26.$(EXESUFFIX) ||:
