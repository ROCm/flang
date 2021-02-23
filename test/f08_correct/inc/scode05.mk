#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test scode05  ########

scode05: scode05.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

scode05.$(OBJX):  $(SRC)/scode05.f08
	-$(RM) scode05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode05.f08 -o scode05.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) scode05.$(OBJX) check.$(OBJX) $(LIBS) -o scode05.$(EXESUFFIX) ||:

scode05.run: passok.$(OBJX)
	@echo ------------------------------------ executing test scode05
	-passok.$(EXESUFFIX) ||:

build:	scode05.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test scode05
	-passok.$(EXESUFFIX) ||:
