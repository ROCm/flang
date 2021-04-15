#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test misc3  ########


misc3: misc3.run

misc3.$(OBJX):  $(SRC)/misc3.f90
	-$(RM) misc3.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c -Mx,232,0x1 $(FFLAGS) $(LDFLAGS) $(SRC)/misc3.f90 -o misc3.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) misc3.$(OBJX) check.$(OBJX) $(LIBS) -o misc3.$(EXESUFFIX)


misc3.run: misc3.$(OBJX)
	@echo ------------------------------------ executing test misc3
	misc3.$(EXESUFFIX)

build:	misc3.$(OBJX)

verify:	;

run:	 misc3.$(OBJX)
	@echo ------------------------------------ executing test misc3
	misc3.$(EXESUFFIX)
