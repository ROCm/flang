#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for pointer initialization as per f2008 standard
#

########## Make rule for test pointer_init01  ########


pointer_init01: pointer_init01.run

pointer_init01.$(OBJX):  $(SRC)/pointer_init01.f08
	-$(RM) pointer_init01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/pointer_init01.f08 -o pointer_init01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) pointer_init01.$(OBJX) check.$(OBJX) $(LIBS) -o pointer_init01.$(EXESUFFIX)


pointer_init01.run: pointer_init01.$(OBJX)
	@echo ------------------------------------ executing test pointer_init01
	pointer_init01.$(EXESUFFIX)

build:	pointer_init01.$(OBJX)

verify:	;

run:	 pointer_init01.$(OBJX)
	@echo ------------------------------------ executing test pointer_init01
	pointer_init01.$(EXESUFFIX)
