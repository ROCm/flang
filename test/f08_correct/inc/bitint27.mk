#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint27  ########


bitint27: bitint27.run

bitint27.$(OBJX):  $(SRC)/bitint27.f08
	-$(RM) bitint27.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint27.f08 -o bitint27.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint27.$(OBJX) check.$(OBJX) $(LIBS) -o bitint27.$(EXESUFFIX)


bitint27.run: bitint27.$(OBJX)
	@echo ------------------------------------ executing test bitint27
	bitint27.$(EXESUFFIX)

build:	bitint27.$(OBJX)

verify:	;

run:	 bitint27.$(OBJX)
	@echo ------------------------------------ executing test bitint27
	-bitint27.$(EXESUFFIX) ||:
