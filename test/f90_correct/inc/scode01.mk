#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Nov 12, 2019
#

########## Make rule for test scode01  ########


scode01: scode01.run

scode01.$(OBJX):  $(SRC)/scode01.f90
	-$(RM) scode01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode01.f90 -o scode01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode01.$(OBJX) check.$(OBJX) $(LIBS) -o scode01.$(EXESUFFIX)


scode01.run: scode01.$(OBJX)
	@echo ------------------------------------ executing test scode01
	scode01.$(EXESUFFIX)

build:	scode01.$(OBJX)

verify:	;

run:	 scode01.$(OBJX)
	@echo ------------------------------------ executing test scode01
	-scode01.$(EXESUFFIX) ||:
