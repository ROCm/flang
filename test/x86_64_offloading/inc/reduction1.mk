#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test reduction1  ########


reduction1: reduction1.run

reduction1.$(OBJX):  $(SRC)/reduction1.f90
	-$(RM) reduction1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/reduction1.f90 -o reduction1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) reduction1.$(OBJX) check.$(OBJX) $(LIBS) -o reduction1.$(EXESUFFIX)


reduction1.run: reduction1.$(OBJX)
	@echo ------------------------------------ executing test reduction1
	reduction1.$(EXESUFFIX)

build:	reduction1.$(OBJX)

verify:	;

run:	 reduction1.$(OBJX)
	@echo ------------------------------------ executing test reduction1
	reduction1.$(EXESUFFIX)
