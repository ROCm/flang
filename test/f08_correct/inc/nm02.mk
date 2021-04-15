#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

########## Make rule for test nm02  ########


nm02: nm02.run

nm02.$(OBJX):  $(SRC)/nm02.f08
	-$(RM) nm02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nm02.f08 -o nm02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nm02.$(OBJX) check.$(OBJX) $(LIBS) -o nm02.$(EXESUFFIX)


nm02.run: nm02.$(OBJX)
	@echo ------------------------------------ executing test nm02
	nm02.$(EXESUFFIX)

build:	nm02.$(OBJX)

verify:	;

run:	 nm02.$(OBJX)
	@echo ------------------------------------ executing test nm02
	nm02.$(EXESUFFIX)
