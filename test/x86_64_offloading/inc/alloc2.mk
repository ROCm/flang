#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test alloc2  ########


alloc2: alloc2.run

alloc2.$(OBJX):  $(SRC)/alloc2.f90
	-$(RM) alloc2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/alloc2.f90 -o alloc2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) alloc2.$(OBJX) check.$(OBJX) $(LIBS) -o alloc2.$(EXESUFFIX)


alloc2.run: alloc2.$(OBJX)
	@echo ------------------------------------ executing test alloc2
	alloc2.$(EXESUFFIX)

build:	alloc2.$(OBJX)

verify:	;

run:	 alloc2.$(OBJX)
	@echo ------------------------------------ executing test alloc2
	alloc2.$(EXESUFFIX)
