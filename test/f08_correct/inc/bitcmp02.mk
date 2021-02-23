#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Bit Sequence Comparsion intrinsics.
#

########## Make rule for test bitcmp02  ########


bitcmp02: bitcmp02.run

bitcmp02.$(OBJX):  $(SRC)/bitcmp02.f08
	-$(RM) bitcmp02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitcmp02.f08 -o bitcmp02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitcmp02.$(OBJX) check.$(OBJX) $(LIBS) -o bitcmp02.$(EXESUFFIX)


bitcmp02.run: bitcmp02.$(OBJX)
	@echo ------------------------------------ executing test bitcmp02
	bitcmp02.$(EXESUFFIX)

build:	bitcmp02.$(OBJX)

verify:	;

run:	 bitcmp02.$(OBJX)
	@echo ------------------------------------ executing test bitcmp02
	bitcmp02.$(EXESUFFIX)
