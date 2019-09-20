#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Sep 25 2019
#

########## Make rule for test scode09  ########


scode09: scode09.run

scode09.$(OBJX):  $(SRC)/scode09.f08
	-$(RM) scode09.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode09.f08 -o scode09.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode09.$(OBJX) check.$(OBJX) $(LIBS) -o scode09.$(EXESUFFIX)


scode09.run: scode09.$(OBJX)
	@echo ------------------------------------ executing test scode09
	scode09.$(EXESUFFIX)

build:	scode09.$(OBJX)

verify:	;

run:	 scode09.$(OBJX)
	@echo ------------------------------------ executing test scode09
	-scode09.$(EXESUFFIX) ||:
