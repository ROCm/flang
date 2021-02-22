#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Named Select feature
#
# Date of Modification: Jan 20 2020
#
# Tests the F2008 : Named Select feature
#
########## Make rule for test select01  ########

select01: select01.run

select01.$(OBJX):  $(SRC)/select01.f08
	-$(RM) select01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/select01.f08 -o select01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) select01.$(OBJX) check.$(OBJX) $(LIBS) -o select01.$(EXESUFFIX)


select01.run: select01.$(OBJX)
	@echo ------------------------------------ executing test select01
	select01.$(EXESUFFIX)

build:	select01.$(OBJX)

verify:	;

run:	 select01.$(OBJX)
	@echo ------------------------------------ executing test select01
	-select01.$(EXESUFFIX) ||:
