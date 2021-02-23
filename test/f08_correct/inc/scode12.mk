#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Nov 12, 2019
#
########## Make rule for test scode12  ########

scode12: scode12.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

scode12.$(OBJX):  $(SRC)/scode12.f08
	-$(RM) scode12.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode12.f08 -o scode12.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) scode12.$(OBJX) check.$(OBJX) $(LIBS) -o scode12.$(EXESUFFIX) ||:

scode12.run: passok.$(OBJX)
	@echo ------------------------------------ executing test scode12
	-passok.$(EXESUFFIX) ||:

build:	scode12.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test scode12
	-passok.$(EXESUFFIX) ||:
