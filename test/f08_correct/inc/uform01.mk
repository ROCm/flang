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
########## Make rule for test uform01  ########

uform01: uform01.run

uform01.$(OBJX):  $(SRC)/uform01.f08
	-$(RM) uform01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform01.f08 -o uform01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform01.$(OBJX) check.$(OBJX) $(LIBS) -o uform01.$(EXESUFFIX)


uform01.run: uform01.$(OBJX)
	@echo ------------------------------------ executing test uform01
	uform01.$(EXESUFFIX)

build:	uform01.$(OBJX)

verify:	;

run:	 uform01.$(OBJX)
	@echo ------------------------------------ executing test uform01
	-uform01.$(EXESUFFIX) ||:
