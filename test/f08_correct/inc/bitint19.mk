#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit parameters
#
# Date of Modification: Mon Feb 17 14:37:39 IST 2020
#

########## Make rule for test bitint19  ########


bitint19: bitint19.run

bitint19.$(OBJX):  $(SRC)/bitint19.f08
	-$(RM) bitint19.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint19.f08 -o bitint19.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint19.$(OBJX) check.$(OBJX) $(LIBS) -o bitint19.$(EXESUFFIX)


bitint19.run: bitint19.$(OBJX)
	@echo ------------------------------------ executing test bitint19
	bitint19.$(EXESUFFIX)

build:	bitint19.$(OBJX)

verify:	;

run:	 bitint19.$(OBJX)
	@echo ------------------------------------ executing test bitint19
	-bitint19.$(EXESUFFIX) ||:
