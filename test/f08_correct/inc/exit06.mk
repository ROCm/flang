#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2013: F2008-Exit statement-Execution control.
#
# Date of Modification: 23rd Sep 2019
#
########## Make rule for test exit06  ########


exit06: exit06.run

exit06.$(OBJX):  $(SRC)/exit06.f08
	-$(RM) exit06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exit06.f08 -o exit06.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exit06.$(OBJX) check.$(OBJX) $(LIBS) -o exit06.$(EXESUFFIX)


exit06.run: exit06.$(OBJX)
	@echo ------------------------------------ executing test exit06
	exit06.$(EXESUFFIX)

build:	exit06.$(OBJX)

verify:	;

run:	 exit06.$(OBJX)
	@echo ------------------------------------ executing test exit06
	-exit06.$(EXESUFFIX) ||:
