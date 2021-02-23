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
########## Make rule for test uform03  ########

uform03: uform03.run

uform03.$(OBJX):  $(SRC)/uform03.f08
	-$(RM) uform03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/uform03.f08 -o uform03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) uform03.$(OBJX) check.$(OBJX) $(LIBS) -o uform03.$(EXESUFFIX)


uform03.run: uform03.$(OBJX)
	@echo ------------------------------------ executing test uform03
	uform03.$(EXESUFFIX)

build:	uform03.$(OBJX)

verify:	;

run:	 uform03.$(OBJX)
	@echo ------------------------------------ executing test uform03
	-uform03.$(EXESUFFIX) ||:
