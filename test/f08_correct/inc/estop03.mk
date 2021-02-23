#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Error stop code - Execution control
#
# Date of Modification: 25th July 2019
#
########## Make rule for test estop03  ########


estop03: estop03.run

estop03.$(OBJX):  $(SRC)/estop03.f08
	-$(RM) estop03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/estop03.f08 -o estop03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) estop03.$(OBJX) check.$(OBJX) $(LIBS) -o estop03.$(EXESUFFIX)


estop03.run: estop03.$(OBJX)
	@echo ------------------------------------ executing test estop03
	estop03.$(EXESUFFIX)

build:	estop03.$(OBJX)

verify:	;

run:	 estop03.$(OBJX)
	@echo ------------------------------------ executing test estop03
	-estop03.$(EXESUFFIX) ||:
