#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for MERGE_BITS intrinsic.
#

########## Make rule for test merge_bits01  ########


merge_bits01: merge_bits01.run

merge_bits01.$(OBJX):  $(SRC)/merge_bits01.f08
	-$(RM) merge_bits01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/merge_bits01.f08 -o merge_bits01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) merge_bits01.$(OBJX) check.$(OBJX) $(LIBS) -o merge_bits01.$(EXESUFFIX)


merge_bits01.run: merge_bits01.$(OBJX)
	@echo ------------------------------------ executing test merge_bits01
	merge_bits01.$(EXESUFFIX)

build:	merge_bits01.$(OBJX)

verify:	;

run:	 merge_bits01.$(OBJX)
	@echo ------------------------------------ executing test merge_bits01
	merge_bits01.$(EXESUFFIX)
