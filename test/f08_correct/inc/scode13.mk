#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Nov 12, 2019
#

########## Make rule for test scode13  ########


scode13: scode13.run

scode13.$(OBJX):  $(SRC)/scode13.f08
	-$(RM) scode13.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode13.f08 -o scode13.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode13.$(OBJX) check.$(OBJX) $(LIBS) -o scode13.$(EXESUFFIX)


scode13.run: scode13.$(OBJX)
	@echo ------------------------------------ executing test scode13
	scode13.$(EXESUFFIX)

build:	scode13.$(OBJX)

verify:	;

run:	 scode13.$(OBJX)
	@echo ------------------------------------ executing test scode13
	-scode13.$(EXESUFFIX) ||:
