#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for parity intrinsic.
#

########## Make rule for test parity  ########


parity: .run

parity.$(OBJX):  $(SRC)/parity.f08
	-$(RM) parity.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/parity.f08 -o parity.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) parity.$(OBJX) check.$(OBJX) $(LIBS) -o parity.$(EXESUFFIX)


parity.run: parity.$(OBJX)
	@echo ------------------------------------ executing test parity
	parity.$(EXESUFFIX)

build:	parity.$(OBJX)

verify:	;

run:	 parity.$(OBJX)
	@echo ------------------------------------ executing test parity
	parity.$(EXESUFFIX)

