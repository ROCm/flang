#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
#
# Date of Modification: 31st Aug 2019

#
########## Make rule for test editd02  ########


editd02: editd02.run

editd02.$(OBJX):  $(SRC)/editd02.f08
	-$(RM) editd02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/editd02.f08 -o editd02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) editd02.$(OBJX) check.$(OBJX) $(LIBS) -o editd02.$(EXESUFFIX)


editd02.run: editd02.$(OBJX)
	@echo ------------------------------------ executing test editd02
	editd02.$(EXESUFFIX)

build:	editd02.$(OBJX)

verify:	;

run:	 editd02.$(OBJX)
	@echo ------------------------------------ executing test editd02
	-editd02.$(EXESUFFIX) ||:
