#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
#
# Date of Modification: 31st Aug 2019

#
########## Make rule for test editd01  ########


editd01: editd01.run

editd01.$(OBJX):  $(SRC)/editd01.f08
	-$(RM) editd01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/editd01.f08 -o editd01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) editd01.$(OBJX) check.$(OBJX) $(LIBS) -o editd01.$(EXESUFFIX)


editd01.run: editd01.$(OBJX)
	@echo ------------------------------------ executing test editd01
	editd01.$(EXESUFFIX)

build:	editd01.$(OBJX)

verify:	;

run:	 editd01.$(OBJX)
	@echo ------------------------------------ executing test editd01
	-editd01.$(EXESUFFIX) ||:
