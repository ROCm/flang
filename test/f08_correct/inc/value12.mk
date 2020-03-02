#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
# intent of an argument need not be specified if it has the 
# value attribute
#
# Date of Modification: Wed Feb 19 14:31:03 IST 2020
#
########## Make rule for test value12  ########

value12: value12.run

value12.$(OBJX):  $(SRC)/value12.f08
	-$(RM) value12.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/value12.f08 -o value12.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) value12.$(OBJX) check.$(OBJX) $(LIBS) -o value12.$(EXESUFFIX)


value12.run: value12.$(OBJX)
	@echo ------------------------------------ executing test value12
	value12.$(EXESUFFIX)

build:	value12.$(OBJX)

verify:	;

run:	 value12.$(OBJX)
	@echo ------------------------------------ executing test value12
	-value12.$(EXESUFFIX) ||:
