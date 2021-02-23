#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit parameters
#
# Date of Modification: Mon Feb 17 15:07:29 IST 2020
#

########## Make rule for test bitint20  ########


bitint20: bitint20.run

bitint20.$(OBJX):  $(SRC)/bitint20.f08
	-$(RM) bitint20.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint20.f08 -o bitint20.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint20.$(OBJX) check.$(OBJX) $(LIBS) -o bitint20.$(EXESUFFIX)


bitint20.run: bitint20.$(OBJX)
	@echo ------------------------------------ executing test bitint20
	bitint20.$(EXESUFFIX)

build:	bitint20.$(OBJX)

verify:	;

run:	 bitint20.$(OBJX)
	@echo ------------------------------------ executing test bitint20
	-bitint20.$(EXESUFFIX) ||:
