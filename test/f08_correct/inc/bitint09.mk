#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint09  ########


bitint09: bitint09.run

bitint09.$(OBJX):  $(SRC)/bitint09.f08
	-$(RM) bitint09.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint09.f08 -o bitint09.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint09.$(OBJX) check.$(OBJX) $(LIBS) -o bitint09.$(EXESUFFIX)


bitint09.run: bitint09.$(OBJX)
	@echo ------------------------------------ executing test bitint09
	bitint09.$(EXESUFFIX)

build:	bitint09.$(OBJX)

verify:	;

run:	 bitint09.$(OBJX)
	@echo ------------------------------------ executing test bitint09
	-bitint09.$(EXESUFFIX) ||:
