#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
#
# Date of Modification: 31st Aug 2019

#
########## Make rule for test editd05  ########


editd05: editd05.run

editd05.$(OBJX):  $(SRC)/editd05.f08
	-$(RM) editd05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/editd05.f08 -o editd05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) editd05.$(OBJX) check.$(OBJX) $(LIBS) -o editd05.$(EXESUFFIX)


editd05.run: editd05.$(OBJX)
	@echo ------------------------------------ executing test editd05
	editd05.$(EXESUFFIX)

build:	editd05.$(OBJX)

verify:	;

run:	 editd05.$(OBJX)
	@echo ------------------------------------ executing test editd05
	-editd05.$(EXESUFFIX) ||:
