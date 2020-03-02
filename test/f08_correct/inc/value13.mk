#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
# intent of an argument need not be specified if it has the 
# value attribute
#
# Date of Modification: Wed Feb 19 14:31:03 IST 2020
#
########## Make rule for test value13  ########

value13: value13.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

value13.$(OBJX):  $(SRC)/value13.f08
	-$(RM) value13.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/value13.f08 -o value13.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) value13.$(OBJX) check.$(OBJX) $(LIBS) -o value13.$(EXESUFFIX) ||:

value13.run: passok.$(OBJX)
	@echo ------------------------------------ executing test value13
	-passok.$(EXESUFFIX) ||:

build:	value13.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test value13
	-passok.$(EXESUFFIX) ||:
