#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for atan with two arguments
#

########## Make rule for test test_atan  ########


test_atan: .run

test_atan.$(OBJX):  $(SRC)/test_atan.f08
	-$(RM) test_atan.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/test_atan.f08 -o test_atan.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) test_atan.$(OBJX) check.$(OBJX) $(LIBS) -o test_atan.$(EXESUFFIX)


test_atan.run: test_atan.$(OBJX)
	@echo ------------------------------------ executing test test_atan
	test_atan.$(EXESUFFIX)

build:	test_atan.$(OBJX)

verify:	;

run:	 test_atan.$(OBJX)
	@echo ------------------------------------ executing test test_atan
	test_atan.$(EXESUFFIX)

