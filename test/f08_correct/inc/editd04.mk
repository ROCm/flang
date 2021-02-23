#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
#
# Date of Modification: 31st Aug 2019

#
########## Make rule for test editd04  ########


editd04: editd04.run

editd04.$(OBJX):  $(SRC)/editd04.f08
	-$(RM) editd04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/editd04.f08 -o editd04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) editd04.$(OBJX) check.$(OBJX) $(LIBS) -o editd04.$(EXESUFFIX)


editd04.run: editd04.$(OBJX)
	@echo ------------------------------------ executing test editd04
	editd04.$(EXESUFFIX)

build:	editd04.$(OBJX)

verify:	;

run:	 editd04.$(OBJX)
	@echo ------------------------------------ executing test editd04
	-editd04.$(EXESUFFIX) ||:
