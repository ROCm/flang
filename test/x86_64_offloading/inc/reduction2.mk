#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test reduction2  ########


reduction2: reduction2.run

reduction2.$(OBJX):  $(SRC)/reduction2.f90
	-$(RM) reduction2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/reduction2.f90 -o reduction2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) reduction2.$(OBJX) check.$(OBJX) $(LIBS) -o reduction2.$(EXESUFFIX)


reduction2.run: reduction2.$(OBJX)
	@echo ------------------------------------ executing test reduction2
	reduction2.$(EXESUFFIX)

build:	reduction2.$(OBJX)

verify:	;

run:	 reduction2.$(OBJX)
	@echo ------------------------------------ executing test reduction2
	reduction2.$(EXESUFFIX)
