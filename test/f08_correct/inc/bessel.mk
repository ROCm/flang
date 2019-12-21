#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for bessel intrinsic.
#

########## Make rule for test bessel  ########


bessel: .run

bessel.$(OBJX):  $(SRC)/bessel.f08
	-$(RM) bessel.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bessel.f08 -o bessel.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bessel.$(OBJX) check.$(OBJX) $(LIBS) -o bessel.$(EXESUFFIX)


bessel.run: bessel.$(OBJX)
	@echo ------------------------------------ executing test bessel
	bessel.$(EXESUFFIX)

build:	bessel.$(OBJX)

verify:	;

run:	 bessel.$(OBJX)
	@echo ------------------------------------ executing test bessel
	bessel.$(EXESUFFIX)

