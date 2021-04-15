#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for iany intrinsic.
#

########## Make rule for test iany  ########


iany: .run

iany.$(OBJX):  $(SRC)/iany.f08
	-$(RM) iany.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/iany.f08 -o iany.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) iany.$(OBJX) check.$(OBJX) $(LIBS) -o iany.$(EXESUFFIX)


iany.run: iany.$(OBJX)
	@echo ------------------------------------ executing test iany
	iany.$(EXESUFFIX)

build:	iany.$(OBJX)

verify:	;

run:	 iany.$(OBJX)
	@echo ------------------------------------ executing test iany
	iany.$(EXESUFFIX)

