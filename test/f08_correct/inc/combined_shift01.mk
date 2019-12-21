#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for Combined Bit Shifting intrinsic.
#

########## Make rule for test combined_shift01  ########


combined_shift01: combined_shift01.run

combined_shift01.$(OBJX):  $(SRC)/combined_shift01.f08
	-$(RM) combined_shift01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/combined_shift01.f08 -o combined_shift01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) combined_shift01.$(OBJX) check.$(OBJX) $(LIBS) -o combined_shift01.$(EXESUFFIX)


combined_shift01.run: combined_shift01.$(OBJX)
	@echo ------------------------------------ executing test combined_shift01
	combined_shift01.$(EXESUFFIX)

build:	combined_shift01.$(OBJX)

verify:	;

run:	 combined_shift01.$(OBJX)
	@echo ------------------------------------ executing test combined_shift01
	combined_shift01.$(EXESUFFIX)
