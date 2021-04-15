#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Revert to the old value when newunit has errors.
#

########## Make rule for test newunit02 ########


newunit02: newunit02.run

newunit02.$(OBJX):  $(SRC)/newunit02.f08
	-$(RM) newunit02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/newunit02.f08 -o newunit02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) newunit02.$(OBJX) check.$(OBJX) $(LIBS) -o newunit02.$(EXESUFFIX)


newunit02.run: newunit02.$(OBJX)
	@echo ------------------------------------ executing test newunit02
	newunit02.$(EXESUFFIX)

build:	newunit02.$(OBJX)

verify:	;

run:	 newunit02.$(OBJX)
	@echo ------------------------------------ executing test newunit02
	newunit02.$(EXESUFFIX)
