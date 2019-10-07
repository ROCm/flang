#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test teams_distribute1  ########


teams_distribute1: teams_distribute1.run

teams_distribute1.$(OBJX):  $(SRC)/teams_distribute1.f90
	-$(RM) teams_distribute1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/teams_distribute1.f90 -o teams_distribute1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) teams_distribute1.$(OBJX) check.$(OBJX) $(LIBS) -o teams_distribute1.$(EXESUFFIX)


teams_distribute1.run: teams_distribute1.$(OBJX)
	@echo ------------------------------------ executing test teams_distribute1
	teams_distribute1.$(EXESUFFIX)

build:	teams_distribute1.$(OBJX)

verify:	;

run:	 teams_distribute1.$(OBJX)
	@echo ------------------------------------ executing test teams_distribute1
	teams_distribute1.$(EXESUFFIX)
