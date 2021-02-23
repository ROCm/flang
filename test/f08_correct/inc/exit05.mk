#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit05  ########


exit05: exit05.run

exit05.$(OBJX):  $(SRC)/exit05.f08
	-$(RM) exit05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit05.f08 -o exit05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit05.$(OBJX) check.$(OBJX) $(LIBS) -o exit05.$(EXESUFFIX)


exit05.run: exit05.$(OBJX)
	@echo ------------------------------------ executing test exit05
	exit05.$(EXESUFFIX)

build:	exit05.$(OBJX)

verify:	;

run:	 exit05.$(OBJX)
	@echo ------------------------------------ executing test exit05
	-exit05.$(EXESUFFIX) ||:
