#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Error stop code - Execution control
#
# Date of Modification: 1st Sep 2019
#
# Tests the F2008 :Unlimited format item - Input/Output feature
# for an integer array
#
########## Make rule for test uform04  ########

uform04: uform04.run

uform04.$(OBJX):  $(SRC)/uform04.f08
	-$(RM) uform04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform04.f08 -o uform04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform04.$(OBJX) check.$(OBJX) $(LIBS) -o uform04.$(EXESUFFIX)


uform04.run: uform04.$(OBJX)
	@echo ------------------------------------ executing test uform04
	uform04.$(EXESUFFIX)

build:	uform04.$(OBJX)

verify:	;

run:	 uform04.$(OBJX)
	@echo ------------------------------------ executing test uform04
	-uform04.$(EXESUFFIX) ||:
