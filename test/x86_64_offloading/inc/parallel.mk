#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test parallel  ########


parallel: parallel.run

parallel.$(OBJX):  $(SRC)/parallel.f90
	-$(RM) parallel.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/parallel.f90 -o parallel.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) parallel.$(OBJX) check.$(OBJX) $(LIBS) -o parallel.$(EXESUFFIX)


parallel.run: parallel.$(OBJX)
	@echo ------------------------------------ executing test parallel
	parallel.$(EXESUFFIX)

build:	parallel.$(OBJX)

verify:	;

run:	 parallel.$(OBJX)
	@echo ------------------------------------ executing test parallel
	parallel.$(EXESUFFIX)
