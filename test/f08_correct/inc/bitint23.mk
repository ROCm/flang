#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Intrinsics that take bit operands
#
# Date of Modification: Thu Mar 19 10:54:19 IST 2020
#

########## Make rule for test bitint23  ########


bitint23: bitint23.run

bitint23.$(OBJX):  $(SRC)/bitint23.f08
	-$(RM) bitint23.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint23.f08 -o bitint23.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitint23.$(OBJX) check.$(OBJX) $(LIBS) -o bitint23.$(EXESUFFIX)


bitint23.run: bitint23.$(OBJX)
	@echo ------------------------------------ executing test bitint23
	bitint23.$(EXESUFFIX)

build:	bitint23.$(OBJX)

verify:	;

run:	 bitint23.$(OBJX)
	@echo ------------------------------------ executing test bitint23
	-bitint23.$(EXESUFFIX) ||:
