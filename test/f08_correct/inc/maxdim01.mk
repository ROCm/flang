#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for maximum dimension as per f2008 standard
#

########## Make rule for test maxdim01  ########


maxdim01: maxdim01.run

maxdim01.$(OBJX):  $(SRC)/maxdim01.f08
	-$(RM) maxdim01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/maxdim01.f08 -o maxdim01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) maxdim01.$(OBJX) check.$(OBJX) $(LIBS) -o maxdim01.$(EXESUFFIX)


maxdim01.run: maxdim01.$(OBJX)
	@echo ------------------------------------ executing test maxdim01
	maxdim01.$(EXESUFFIX)

build:	maxdim01.$(OBJX)

verify:	;

run:	 maxdim01.$(OBJX)
	@echo ------------------------------------ executing test maxdim01
	maxdim01.$(EXESUFFIX)
