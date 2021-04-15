#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit02  ########


exit02: exit02.run

exit02.$(OBJX):  $(SRC)/exit02.f08
	-$(RM) exit02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit02.f08 -o exit02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit02.$(OBJX) check.$(OBJX) $(LIBS) -o exit02.$(EXESUFFIX)


exit02.run: exit02.$(OBJX)
	@echo ------------------------------------ executing test exit02
	exit02.$(EXESUFFIX)

build:	exit02.$(OBJX)

verify:	;

run:	 exit02.$(OBJX)
	@echo ------------------------------------ executing test exit02
	-exit02.$(EXESUFFIX) ||:
