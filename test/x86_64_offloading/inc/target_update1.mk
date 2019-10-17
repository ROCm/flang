#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test target_update1  ########


target_update1: target_update1.run

target_update1.$(OBJX):  $(SRC)/target_update1.f90
	-$(RM) target_update1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/target_update1.f90 -o target_update1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) target_update1.$(OBJX) check.$(OBJX) $(LIBS) -o target_update1.$(EXESUFFIX)


target_update1.run: target_update1.$(OBJX)
	@echo ------------------------------------ executing test target_update1
	target_update1.$(EXESUFFIX)

build:	target_update1.$(OBJX)

verify:	;

run:	 target_update1.$(OBJX)
	@echo ------------------------------------ executing test target_update1
	target_update1.$(EXESUFFIX)
