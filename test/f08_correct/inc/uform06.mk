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
########## Make rule for test uform06  ########

uform06: uform06.run

uform06.$(OBJX):  $(SRC)/uform06.f08
	-$(RM) uform06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform06.f08 -o uform06.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform06.$(OBJX) check.$(OBJX) $(LIBS) -o uform06.$(EXESUFFIX)


uform06.run: uform06.$(OBJX)
	@echo ------------------------------------ executing test uform06
	uform06.$(EXESUFFIX)

build:	uform06.$(OBJX)

verify:	;

run:	 uform06.$(OBJX)
	@echo ------------------------------------ executing test uform06
	-uform06.$(EXESUFFIX) ||:
