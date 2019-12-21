#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for maximum dimension as per f2008 standard
#

########## Make rule for test maxdim03  ########


maxdim03: maxdim03.run

maxdim03.$(OBJX):  $(SRC)/maxdim03.f08
	-$(RM) maxdim03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/maxdim03.f08 -o maxdim03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) maxdim03.$(OBJX) check.$(OBJX) $(LIBS) -o maxdim03.$(EXESUFFIX)


maxdim03.run: maxdim03.$(OBJX)
	@echo ------------------------------------ executing test maxdim03
	maxdim03.$(EXESUFFIX)

build:	maxdim03.$(OBJX)

verify:	;

run:	 maxdim03.$(OBJX)
	@echo ------------------------------------ executing test maxdim03
	maxdim03.$(EXESUFFIX)
