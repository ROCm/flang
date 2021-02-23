#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control.
#
# Date of Modification: Sep 25 2019
#

########## Make rule for test scode08  ########


scode08: scode08.run

scode08.$(OBJX):  $(SRC)/scode08.f08
	-$(RM) scode08.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode08.f08 -o scode08.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode08.$(OBJX) check.$(OBJX) $(LIBS) -o scode08.$(EXESUFFIX)


scode08.run: scode08.$(OBJX)
	@echo ------------------------------------ executing test scode08
	scode08.$(EXESUFFIX)

build:	scode08.$(OBJX)

verify:	;

run:	 scode08.$(OBJX)
	@echo ------------------------------------ executing test scode08
	-scode08.$(EXESUFFIX) ||:
