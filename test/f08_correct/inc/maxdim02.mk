#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for maximum dimension as per f2008 standard
#

########## Make rule for test maxdim02  ########


maxdim02: maxdim02.run

maxdim02.$(OBJX):  $(SRC)/maxdim02.f08
	-$(RM) maxdim02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/maxdim02.f08 -o maxdim02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) maxdim02.$(OBJX) check.$(OBJX) $(LIBS) -o maxdim02.$(EXESUFFIX)


maxdim02.run: maxdim02.$(OBJX)
	@echo ------------------------------------ executing test maxdim02
	maxdim02.$(EXESUFFIX)

build:	maxdim02.$(OBJX)

verify:	;

run:	 maxdim02.$(OBJX)
	@echo ------------------------------------ executing test maxdim02
	maxdim02.$(EXESUFFIX)
