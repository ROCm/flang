#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for assumed size array as parameter
#

########## Make rule for test assumedsize_array  ########


assumedsize_array: .run

assumedsize_array.$(OBJX):  $(SRC)/assumedsize_array.f08
	-$(RM) assumedsize_array.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/assumedsize_array.f08 -o assumedsize_array.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) assumedsize_array.$(OBJX) check.$(OBJX) $(LIBS) -o assumedsize_array.$(EXESUFFIX)


assumedsize_array.run: assumedsize_array.$(OBJX)
	@echo ------------------------------------ executing test assumedsize_array
	assumedsize_array.$(EXESUFFIX)

build:	assumedsize_array.$(OBJX)

verify:	;

run:	 assumedsize_array.$(OBJX)
	@echo ------------------------------------ executing test assumedsize_array
	assumedsize_array.$(EXESUFFIX)

