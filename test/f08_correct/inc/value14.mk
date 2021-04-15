#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
# intent of an argument need not be specified if it has the 
# value attribute
#
# Date of Modification: Wed Feb 19 14:31:03 IST 2020
#
########## Make rule for test value14  ########

value14: value14.run

value14.$(OBJX):  $(SRC)/value14.f08
	-$(RM) value14.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/value14.f08 -o value14.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) value14.$(OBJX) check.$(OBJX) $(LIBS) -o value14.$(EXESUFFIX)


value14.run: value14.$(OBJX)
	@echo ------------------------------------ executing test value14
	value14.$(EXESUFFIX)

build:	value14.$(OBJX)

verify:	;

run:	 value14.$(OBJX)
	@echo ------------------------------------ executing test value14
	-value14.$(EXESUFFIX) ||:
