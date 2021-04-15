#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Sep 25 2019
#

########## Make rule for test scode10  ########


scode10: scode10.run

scode10.$(OBJX):  $(SRC)/scode10.f08
	-$(RM) scode10.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode10.f08 -o scode10.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode10.$(OBJX) check.$(OBJX) $(LIBS) -o scode10.$(EXESUFFIX)


scode10.run: scode10.$(OBJX)
	@echo ------------------------------------ executing test scode10
	scode10.$(EXESUFFIX)

build:	scode10.$(OBJX)

verify:	;

run:	 scode10.$(OBJX)
	@echo ------------------------------------ executing test scode10
	-scode10.$(EXESUFFIX) ||:
