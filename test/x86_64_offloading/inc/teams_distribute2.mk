#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test teams_distribute2  ########


teams_distribute2: teams_distribute2.run

teams_distribute2.$(OBJX):  $(SRC)/teams_distribute2.f90
	-$(RM) teams_distribute2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/teams_distribute2.f90 -o teams_distribute2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) teams_distribute2.$(OBJX) check.$(OBJX) $(LIBS) -o teams_distribute2.$(EXESUFFIX)


teams_distribute2.run: teams_distribute2.$(OBJX)
	@echo ------------------------------------ executing test teams_distribute2
	teams_distribute2.$(EXESUFFIX)

build:	teams_distribute2.$(OBJX)

verify:	;

run:	 teams_distribute2.$(OBJX)
	@echo ------------------------------------ executing test teams_distribute2
	teams_distribute2.$(EXESUFFIX)
