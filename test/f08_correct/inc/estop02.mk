#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Error stop code - Execution control
#
# Date of Modification: 25th July 2019
#
########## Make rule for test estop02  ########


estop02: estop02.run

estop02.$(OBJX):  $(SRC)/estop02.f08
	-$(RM) estop02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/estop02.f08 -o estop02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) estop02.$(OBJX) check.$(OBJX) $(LIBS) -o estop02.$(EXESUFFIX)


estop02.run: estop02.$(OBJX)
	@echo ------------------------------------ executing test estop02
	estop02.$(EXESUFFIX)

build:	estop02.$(OBJX)

verify:	;

run:	 estop02.$(OBJX)
	@echo ------------------------------------ executing test estop02
	-estop02.$(EXESUFFIX) ||:
