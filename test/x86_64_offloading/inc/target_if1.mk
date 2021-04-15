#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test target_if1  ########


target_if1: target_if1.run

target_if1.$(OBJX):  $(SRC)/target_if1.f90
	-$(RM) target_if1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/target_if1.f90 -o target_if1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) target_if1.$(OBJX) check.$(OBJX) $(LIBS) -o target_if1.$(EXESUFFIX)


target_if1.run: target_if1.$(OBJX)
	@echo ------------------------------------ executing test target_if1
	target_if1.$(EXESUFFIX)

build:	target_if1.$(OBJX)

verify:	;

run:	 target_if1.$(OBJX)
	@echo ------------------------------------ executing test target_if1
	target_if1.$(EXESUFFIX)
