#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Bit Sequence Comparsion intrinsics.
#

########## Make rule for test bitcmp03  ########


bitcmp03: bitcmp03.run

bitcmp03.$(OBJX):  $(SRC)/bitcmp03.f08
	-$(RM) bitcmp03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitcmp03.f08 -o bitcmp03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitcmp03.$(OBJX) check.$(OBJX) $(LIBS) -o bitcmp03.$(EXESUFFIX)


bitcmp03.run: bitcmp03.$(OBJX)
	@echo ------------------------------------ executing test bitcmp03
	bitcmp03.$(EXESUFFIX)

build:	bitcmp03.$(OBJX)

verify:	;

run:	 bitcmp03.$(OBJX)
	@echo ------------------------------------ executing test bitcmp03
	bitcmp03.$(EXESUFFIX)
