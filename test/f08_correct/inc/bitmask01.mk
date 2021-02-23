#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Bit Masking intrinsics.
#

########## Make rule for test bitmask01  ########


bitmask01: bitmask01.run

bitmask01.$(OBJX):  $(SRC)/bitmask01.f08
	-$(RM) bitmask01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitmask01.f08 -o bitmask01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitmask01.$(OBJX) check.$(OBJX) $(LIBS) -o bitmask01.$(EXESUFFIX)


bitmask01.run: bitmask01.$(OBJX)
	@echo ------------------------------------ executing test bitmask01
	bitmask01.$(EXESUFFIX)

build:	bitmask01.$(OBJX)

verify:	;

run:	 bitmask01.$(OBJX)
	@echo ------------------------------------ executing test bitmask01
	bitmask01.$(EXESUFFIX)
