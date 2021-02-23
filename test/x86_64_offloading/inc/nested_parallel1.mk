#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test nested_parallel1  ########


nested_parallel1: nested_parallel1.run

nested_parallel1.$(OBJX):  $(SRC)/nested_parallel1.f90
	-$(RM) nested_parallel1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nested_parallel1.f90 -o nested_parallel1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nested_parallel1.$(OBJX) check.$(OBJX) $(LIBS) -o nested_parallel1.$(EXESUFFIX)


nested_parallel1.run: nested_parallel1.$(OBJX)
	@echo ------------------------------------ executing test nested_parallel1
	nested_parallel1.$(EXESUFFIX)

build:	nested_parallel1.$(OBJX)

verify:	;

run:	 nested_parallel1.$(OBJX)
	@echo ------------------------------------ executing test nested_parallel1
	nested_parallel1.$(EXESUFFIX)
