#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit01  ########


exit01: exit01.run

exit01.$(OBJX):  $(SRC)/exit01.f08
	-$(RM) exit01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit01.f08 -o exit01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit01.$(OBJX) check.$(OBJX) $(LIBS) -o exit01.$(EXESUFFIX)


exit01.run: exit01.$(OBJX)
	@echo ------------------------------------ executing test exit01
	exit01.$(EXESUFFIX)

build:	exit01.$(OBJX)

verify:	;

run:	 exit01.$(OBJX)
	@echo ------------------------------------ executing test exit01
	-exit01.$(EXESUFFIX) ||:
