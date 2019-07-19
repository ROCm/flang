#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Error stop code - Execution control
#
# Date of Modification: 25th July 2019
#
########## Make rule for test estop04  ########


estop04: estop04.run

estop04.$(OBJX):  $(SRC)/estop04.f08
	-$(RM) estop04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/estop04.f08 -o estop04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) estop04.$(OBJX) check.$(OBJX) $(LIBS) -o estop04.$(EXESUFFIX)


estop04.run: estop04.$(OBJX)
	@echo ------------------------------------ executing test estop04
	estop04.$(EXESUFFIX)

build:	estop04.$(OBJX)

verify:	;

run:	 estop04.$(OBJX)
	@echo ------------------------------------ executing test estop04
	-estop04.$(EXESUFFIX) ||:
