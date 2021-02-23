#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for iall intrinsic.
#

########## Make rule for test iall  ########


iall: .run

iall.$(OBJX):  $(SRC)/iall.f08
	-$(RM) iall.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/iall.f08 -o iall.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) iall.$(OBJX) check.$(OBJX) $(LIBS) -o iall.$(EXESUFFIX)


iall.run: iall.$(OBJX)
	@echo ------------------------------------ executing test iall
	iall.$(EXESUFFIX)

build:	iall.$(OBJX)

verify:	;

run:	 iall.$(OBJX)
	@echo ------------------------------------ executing test iall
	iall.$(EXESUFFIX)

