#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:11:26 IST 2020
#

########## Make rule for test bitint06  ########


bitint06: bitint06.run

bitint06.$(OBJX):  $(SRC)/bitint06.f08
	-$(RM) bitint06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint06.f08 -o bitint06.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint06.$(OBJX) check.$(OBJX) $(LIBS) -o bitint06.$(EXESUFFIX)


bitint06.run: bitint06.$(OBJX)
	@echo ------------------------------------ executing test bitint06
	bitint06.$(EXESUFFIX)

build:	bitint06.$(OBJX)

verify:	;

run:	 bitint06.$(OBJX)
	@echo ------------------------------------ executing test bitint06
	-bitint06.$(EXESUFFIX) ||:
