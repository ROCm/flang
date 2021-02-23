#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

########## Make rule for test nm01  ########


nm01: nm01.run

nm01.$(OBJX):  $(SRC)/nm01.f08
	-$(RM) nm01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nm01.f08 -o nm01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nm01.$(OBJX) check.$(OBJX) $(LIBS) -o nm01.$(EXESUFFIX)


nm01.run: nm01.$(OBJX)
	@echo ------------------------------------ executing test nm01
	nm01.$(EXESUFFIX)

build:	nm01.$(OBJX)

verify:	;

run:	 nm01.$(OBJX)
	@echo ------------------------------------ executing test nm01
	nm01.$(EXESUFFIX)
