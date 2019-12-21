#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Bit Sequence Comparsion intrinsics.
#

########## Make rule for test bitcmp01  ########


bitcmp01: bitcmp01.run

bitcmp01.$(OBJX):  $(SRC)/bitcmp01.f08
	-$(RM) bitcmp01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitcmp01.f08 -o bitcmp01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitcmp01.$(OBJX) check.$(OBJX) $(LIBS) -o bitcmp01.$(EXESUFFIX)


bitcmp01.run: bitcmp01.$(OBJX)
	@echo ------------------------------------ executing test bitcmp01
	bitcmp01.$(EXESUFFIX)

build:	bitcmp01.$(OBJX)

verify:	;

run:	 bitcmp01.$(OBJX)
	@echo ------------------------------------ executing test bitcmp01
	bitcmp01.$(EXESUFFIX)
