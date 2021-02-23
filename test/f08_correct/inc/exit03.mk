#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit03  ########


exit03: exit03.run

exit03.$(OBJX):  $(SRC)/exit03.f08
	-$(RM) exit03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit03.f08 -o exit03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit03.$(OBJX) check.$(OBJX) $(LIBS) -o exit03.$(EXESUFFIX)


exit03.run: exit03.$(OBJX)
	@echo ------------------------------------ executing test exit03
	exit03.$(EXESUFFIX)

build:	exit03.$(OBJX)

verify:	;

run:	 exit03.$(OBJX)
	@echo ------------------------------------ executing test exit03
	-exit03.$(EXESUFFIX) ||:
