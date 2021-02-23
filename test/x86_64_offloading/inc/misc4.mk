#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test misc4  ########


misc4: misc4.run

misc4.$(OBJX):  $(SRC)/misc4.f90
	-$(RM) misc4.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/misc4.f90 -o misc4.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) misc4.$(OBJX) check.$(OBJX) $(LIBS) -o misc4.$(EXESUFFIX)


misc4.run: misc4.$(OBJX)
	@echo ------------------------------------ executing test misc4
	misc4.$(EXESUFFIX)

build:	misc4.$(OBJX)

verify:	;

run:	 misc4.$(OBJX)
	@echo ------------------------------------ executing test misc4
	misc4.$(EXESUFFIX)
