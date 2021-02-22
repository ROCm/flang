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
########## Make rule for test uform02  ########

uform02: uform02.run

uform02.$(OBJX):  $(SRC)/uform02.f08
	-$(RM) uform02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform02.f08 -o uform02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform02.$(OBJX) check.$(OBJX) $(LIBS) -o uform02.$(EXESUFFIX)


uform02.run: uform02.$(OBJX)
	@echo ------------------------------------ executing test uform02
	uform02.$(EXESUFFIX)

build:	uform02.$(OBJX)

verify:	;

run:	 uform02.$(OBJX)
	@echo ------------------------------------ executing test uform02
	-uform02.$(EXESUFFIX) ||:
