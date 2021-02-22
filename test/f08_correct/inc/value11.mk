#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
# intent of an argument need not be specified if it has the 
# value attribute
#
# Date of Modification: Wed Feb 19 14:31:03 IST 2020
#
########## Make rule for test value11  ########

value11: value11.run

value11.$(OBJX):  $(SRC)/value11.f08
	-$(RM) value11.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/value11.f08 -o value11.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) value11.$(OBJX) check.$(OBJX) $(LIBS) -o value11.$(EXESUFFIX)


value11.run: value11.$(OBJX)
	@echo ------------------------------------ executing test value11
	value11.$(EXESUFFIX)

build:	value11.$(OBJX)

verify:	;

run:	 value11.$(OBJX)
	@echo ------------------------------------ executing test value11
	-value11.$(EXESUFFIX) ||:
