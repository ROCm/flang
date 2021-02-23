#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit data
#
# Date of Modification: Thu Mar 19 10:54:19 IST 2020
#

########## Make rule for test bitint36  ########


bitint36: bitint36.run

bitint36.$(OBJX):  $(SRC)/bitint36.f08
	-$(RM) bitint36.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint36.f08 -o bitint36.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint36.$(OBJX) check.$(OBJX) $(LIBS) -o bitint36.$(EXESUFFIX)


bitint36.run: bitint36.$(OBJX)
	@echo ------------------------------------ executing test bitint36
	bitint36.$(EXESUFFIX)

build:	bitint36.$(OBJX)

verify:	;

run:	 bitint36.$(OBJX)
	@echo ------------------------------------ executing test bitint36
	-bitint36.$(EXESUFFIX) ||:
