#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Error stop code - Execution control
#
# Date of Modification: 25th July 2019
#
########## Make rule for test estop01  ########


estop01: estop01.run

estop01.$(OBJX):  $(SRC)/estop01.f08
	-$(RM) estop01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/estop01.f08 -o estop01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) estop01.$(OBJX) check.$(OBJX) $(LIBS) -o estop01.$(EXESUFFIX)


estop01.run: estop01.$(OBJX)
	@echo ------------------------------------ executing test estop01
	estop01.$(EXESUFFIX)

build:	estop01.$(OBJX)

verify:	;

run:	 estop01.$(OBJX)
	@echo ------------------------------------ executing test estop01
	-estop01.$(EXESUFFIX) ||:
