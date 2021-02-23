#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#

########## Make rule for test scode04  ########


scode04: scode04.run

scode04.$(OBJX):  $(SRC)/scode04.f08
	-$(RM) scode04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode04.f08 -o scode04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode04.$(OBJX) check.$(OBJX) $(LIBS) -o scode04.$(EXESUFFIX)


scode04.run: scode04.$(OBJX)
	@echo ------------------------------------ executing test scode04
	scode04.$(EXESUFFIX)

build:	scode04.$(OBJX)

verify:	;

run:	 scode04.$(OBJX)
	@echo ------------------------------------ executing test scode04
	-scode04.$(EXESUFFIX) ||:
