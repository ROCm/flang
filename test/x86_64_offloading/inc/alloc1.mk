#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test alloc1  ########


alloc1: alloc1.run

alloc1.$(OBJX):  $(SRC)/alloc1.f90
	-$(RM) alloc1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/alloc1.f90 -o alloc1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) alloc1.$(OBJX) check.$(OBJX) $(LIBS) -o alloc1.$(EXESUFFIX)


alloc1.run: alloc1.$(OBJX)
	@echo ------------------------------------ executing test alloc1
	alloc1.$(EXESUFFIX)

build:	alloc1.$(OBJX)

verify:	;

run:	 alloc1.$(OBJX)
	@echo ------------------------------------ executing test alloc1
	alloc1.$(EXESUFFIX)
