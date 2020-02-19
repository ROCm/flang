#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit data
#
# Date of Modification: Mon Feb 17 15:24:11 IST 2020
#

########## Make rule for test bitint34  ########


bitint34: bitint34.run

bitint34.$(OBJX):  $(SRC)/bitint34.f08
	-$(RM) bitint34.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint34.f08 -o bitint34.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint34.$(OBJX) check.$(OBJX) $(LIBS) -o bitint34.$(EXESUFFIX)


bitint34.run: bitint34.$(OBJX)
	@echo ------------------------------------ executing test bitint34
	bitint34.$(EXESUFFIX)

build:	bitint34.$(OBJX)

verify:	;

run:	 bitint34.$(OBJX)
	@echo ------------------------------------ executing test bitint34
	-bitint34.$(EXESUFFIX) ||:
