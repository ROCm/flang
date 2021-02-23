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
########## Make rule for test uform05  ########

uform05: uform05.run

uform05.$(OBJX):  $(SRC)/uform05.f08
	-$(RM) uform05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform05.f08 -o uform05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform05.$(OBJX) check.$(OBJX) $(LIBS) -o uform05.$(EXESUFFIX)


uform05.run: uform05.$(OBJX)
	@echo ------------------------------------ executing test uform05
	uform05.$(EXESUFFIX)

build:	uform05.$(OBJX)

verify:	;

run:	 uform05.$(OBJX)
	@echo ------------------------------------ executing test uform05
	-uform05.$(EXESUFFIX) ||:
