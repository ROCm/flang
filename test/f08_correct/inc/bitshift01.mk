#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Bit Shifting intrinsics.
#

########## Make rule for test bitshift01  ########


bitshift01: bitshift01.run

bitshift01.$(OBJX):  $(SRC)/bitshift01.f08
	-$(RM) bitshift01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitshift01.f08 -o bitshift01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitshift01.$(OBJX) check.$(OBJX) $(LIBS) -o bitshift01.$(EXESUFFIX)


bitshift01.run: bitshift01.$(OBJX)
	@echo ------------------------------------ executing test bitshift01
	bitshift01.$(EXESUFFIX)

build:	bitshift01.$(OBJX)

verify:	;

run:	 bitshift01.$(OBJX)
	@echo ------------------------------------ executing test bitshift01
	bitshift01.$(EXESUFFIX)
