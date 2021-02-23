#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test misc2  ########


misc2: misc2.run

misc2.$(OBJX):  $(SRC)/misc2.f90
	-$(RM) misc2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/misc2.f90 -o misc2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) misc2.$(OBJX) check.$(OBJX) $(LIBS) -o misc2.$(EXESUFFIX)


misc2.run: misc2.$(OBJX)
	@echo ------------------------------------ executing test misc2
	misc2.$(EXESUFFIX)

build:	misc2.$(OBJX)

verify:	;

run:	 misc2.$(OBJX)
	@echo ------------------------------------ executing test misc2
	misc2.$(EXESUFFIX)
