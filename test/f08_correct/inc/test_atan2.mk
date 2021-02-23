#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 feature atan2 with complex arguments support
#

########## Make rule for test test_atan2  ########


test_atan2: .run

test_atan2.$(OBJX):  $(SRC)/test_atan2.f08
	-$(RM) test_atan2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/test_atan2.f08 -o test_atan2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) test_atan2.$(OBJX) check.$(OBJX) $(LIBS) -o test_atan2.$(EXESUFFIX)


test_atan2.run: test_atan2.$(OBJX)
	@echo ------------------------------------ executing test test_atan2
	test_atan2.$(EXESUFFIX)

build:	test_atan2.$(OBJX)

verify:	;

run:	 test_atan2.$(OBJX)
	@echo ------------------------------------ executing test test_atan2
	test_atan2.$(EXESUFFIX)

