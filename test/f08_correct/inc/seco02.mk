#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#

########## Make rule for test seco02  ########


seco02: seco02.run

seco02.$(OBJX):  $(SRC)/seco02.f08
	-$(RM) seco02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) -ffixed-form $(SRC)/seco02.f08 -o seco02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) seco02.$(OBJX) check.$(OBJX) $(LIBS) -o seco02.$(EXESUFFIX)


seco02.run: seco02.$(OBJX)
	@echo ------------------------------------ executing test seco02
	seco02.$(EXESUFFIX)

build:	seco02.$(OBJX)

verify:	;

run:	 seco02.$(OBJX)
	@echo ------------------------------------ executing test seco02
	-seco02.$(EXESUFFIX) ||:
