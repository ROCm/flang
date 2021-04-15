#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Nov 12, 2019
#

########## Make rule for test scode11  ########


scode11: scode11.run

scode11.$(OBJX):  $(SRC)/scode11.f08
	-$(RM) scode11.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode11.f08 -o scode11.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode11.$(OBJX) check.$(OBJX) $(LIBS) -o scode11.$(EXESUFFIX)


scode11.run: scode11.$(OBJX)
	@echo ------------------------------------ executing test scode11
	scode11.$(EXESUFFIX)

build:	scode11.$(OBJX)

verify:	;

run:	 scode11.$(OBJX)
	@echo ------------------------------------ executing test scode11
	-scode11.$(EXESUFFIX) ||:
