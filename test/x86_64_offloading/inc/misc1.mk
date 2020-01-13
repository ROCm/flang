#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test misc1  ########


misc1: misc1.run

misc1.$(OBJX):  $(SRC)/misc1.f90
	-$(RM) misc1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/misc1.f90 -o misc1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) misc1.$(OBJX) check.$(OBJX) $(LIBS) -o misc1.$(EXESUFFIX)


misc1.run: misc1.$(OBJX)
	@echo ------------------------------------ executing test misc1
	misc1.$(EXESUFFIX)

build:	misc1.$(OBJX)

verify:	;

run:	 misc1.$(OBJX)
	@echo ------------------------------------ executing test misc1
	misc1.$(EXESUFFIX)
