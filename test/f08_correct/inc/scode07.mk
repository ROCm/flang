#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test scode07  ########


scode07: scode07.run

scode07.$(OBJX):  $(SRC)/scode07.f08
	-$(RM) scode07.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode07.f08 -o scode07.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode07.$(OBJX) check.$(OBJX) $(LIBS) -o scode07.$(EXESUFFIX)


scode07.run: scode07.$(OBJX)
	@echo ------------------------------------ executing test scode07
	scode07.$(EXESUFFIX)

build:	scode07.$(OBJX)

verify:	;

run:	 scode07.$(OBJX)
	@echo ------------------------------------ executing test scode07
	-scode07.$(EXESUFFIX) ||:
