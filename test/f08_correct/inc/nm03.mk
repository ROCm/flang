#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

########## Make rule for test nm03  ########


nm03: nm03.run

nm03.$(OBJX):  $(SRC)/nm03.f08
	-$(RM) nm03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nm03.f08 -o nm03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nm03.$(OBJX) check.$(OBJX) $(LIBS) -o nm03.$(EXESUFFIX)


nm03.run: nm03.$(OBJX)
	@echo ------------------------------------ executing test nm03
	nm03.$(EXESUFFIX)

build:	nm03.$(OBJX)

verify:	;

run:	 nm03.$(OBJX)
	@echo ------------------------------------ executing test nm03
	nm03.$(EXESUFFIX)
