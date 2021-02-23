#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test scode02  ########


scode02: scode02.run

scode02.$(OBJX):  $(SRC)/scode02.f08
	-$(RM) scode02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode02.f08 -o scode02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode02.$(OBJX) check.$(OBJX) $(LIBS) -o scode02.$(EXESUFFIX)


scode02.run: scode02.$(OBJX)
	@echo ------------------------------------ executing test scode02
	scode02.$(EXESUFFIX)

build:	scode02.$(OBJX)

verify:	;

run:	 scode02.$(OBJX)
	@echo ------------------------------------ executing test scode02
	-scode02.$(EXESUFFIX) ||:
