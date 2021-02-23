#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-New Unit Specifier feature compliance test
#

########## Make rule for test newunit01  ########


newunit01: newunit01.run

newunit01.$(OBJX):  $(SRC)/newunit01.f08
	-$(RM) newunit01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/newunit01.f08 -o newunit01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) newunit01.$(OBJX) check.$(OBJX) $(LIBS) -o newunit01.$(EXESUFFIX)


newunit01.run: newunit01.$(OBJX)
	@echo ------------------------------------ executing test newunit01
	newunit01.$(EXESUFFIX)

build:	newunit01.$(OBJX)

verify:	;

run:	 newunit01.$(OBJX)
	@echo ------------------------------------ executing test newunit01
	newunit01.$(EXESUFFIX)
