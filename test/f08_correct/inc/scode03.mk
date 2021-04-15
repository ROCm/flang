#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test scode03  ########


scode03: scode03.run

scode03.$(OBJX):  $(SRC)/scode03.f08
	-$(RM) scode03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode03.f08 -o scode03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode03.$(OBJX) check.$(OBJX) $(LIBS) -o scode03.$(EXESUFFIX)


scode03.run: scode03.$(OBJX)
	@echo ------------------------------------ executing test scode03
	scode03.$(EXESUFFIX)

build:	scode03.$(OBJX)

verify:	;

run:	 scode03.$(OBJX)
	@echo ------------------------------------ executing test scode03
	-scode03.$(EXESUFFIX) ||:
