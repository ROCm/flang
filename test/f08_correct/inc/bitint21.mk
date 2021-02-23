#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint21  ########


bitint21: bitint21.run

bitint21.$(OBJX):  $(SRC)/bitint21.f08
	-$(RM) bitint21.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint21.f08 -o bitint21.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint21.$(OBJX) check.$(OBJX) $(LIBS) -o bitint21.$(EXESUFFIX)


bitint21.run: bitint21.$(OBJX)
	@echo ------------------------------------ executing test bitint21
	bitint21.$(EXESUFFIX)

build:	bitint21.$(OBJX)

verify:	;

run:	 bitint21.$(OBJX)
	@echo ------------------------------------ executing test bitint21
	-bitint21.$(EXESUFFIX) ||:
