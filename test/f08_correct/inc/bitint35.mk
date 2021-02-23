#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit data
#
# Date of Modification: Thu Mar 19 10:54:19 IST 2020
#

########## Make rule for test bitint35  ########


bitint35: bitint35.run

bitint35.$(OBJX):  $(SRC)/bitint35.f08
	-$(RM) bitint35.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint35.f08 -o bitint35.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint35.$(OBJX) check.$(OBJX) $(LIBS) -o bitint35.$(EXESUFFIX)


bitint35.run: bitint35.$(OBJX)
	@echo ------------------------------------ executing test bitint35
	bitint35.$(EXESUFFIX)

build:	bitint35.$(OBJX)

verify:	;

run:	 bitint35.$(OBJX)
	@echo ------------------------------------ executing test bitint35
	-bitint35.$(EXESUFFIX) ||:
