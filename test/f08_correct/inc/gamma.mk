#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for gamma intrinsic.
#

########## Make rule for test gamma  ########


gamma: .run

gamma.$(OBJX):  $(SRC)/gamma.f08
	-$(RM) gamma.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/gamma.f08 -o gamma.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) gamma.$(OBJX) check.$(OBJX) $(LIBS) -o gamma.$(EXESUFFIX)


gamma.run: gamma.$(OBJX)
	@echo ------------------------------------ executing test gamma
	gamma.$(EXESUFFIX)

build:	gamma.$(OBJX)

verify:	;

run:	 gamma.$(OBJX)
	@echo ------------------------------------ executing test gamma
	gamma.$(EXESUFFIX)

