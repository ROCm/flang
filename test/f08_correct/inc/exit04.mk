#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit04  ########


exit04: exit04.run

exit04.$(OBJX):  $(SRC)/exit04.f08
	-$(RM) exit04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit04.f08 -o exit04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit04.$(OBJX) check.$(OBJX) $(LIBS) -o exit04.$(EXESUFFIX)


exit04.run: exit04.$(OBJX)
	@echo ------------------------------------ executing test exit04
	exit04.$(EXESUFFIX)

build:	exit04.$(OBJX)

verify:	;

run:	 exit04.$(OBJX)
	@echo ------------------------------------ executing test exit04
	-exit04.$(EXESUFFIX) ||:
