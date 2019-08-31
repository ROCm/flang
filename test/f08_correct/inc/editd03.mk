#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
#
# Date of Modification: 31st Aug 2019

#
########## Make rule for test editd03  ########


editd03: editd03.run

editd03.$(OBJX):  $(SRC)/editd03.f08
	-$(RM) editd03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/editd03.f08 -o editd03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) editd03.$(OBJX) check.$(OBJX) $(LIBS) -o editd03.$(EXESUFFIX)


editd03.run: editd03.$(OBJX)
	@echo ------------------------------------ executing test editd03
	editd03.$(EXESUFFIX)

build:	editd03.$(OBJX)

verify:	;

run:	 editd03.$(OBJX)
	@echo ------------------------------------ executing test editd03
	-editd03.$(EXESUFFIX) ||:
