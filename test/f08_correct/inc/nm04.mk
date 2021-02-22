#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for array expressions in norm2
# Date of modification 28th October 2019
#
#

########## Make rule for test nm04  ########


nm04: nm04.run

nm04.$(OBJX):  $(SRC)/nm04.f08
	-$(RM) nm04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nm04.f08 -o nm04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nm04.$(OBJX) check.$(OBJX) $(LIBS) -o nm04.$(EXESUFFIX)


nm04.run: nm04.$(OBJX)
	@echo ------------------------------------ executing test nm04
	nm04.$(EXESUFFIX)

build:	nm04.$(OBJX)

verify:	;

run:	 nm04.$(OBJX)
	@echo ------------------------------------ executing test nm04
	nm04.$(EXESUFFIX)
