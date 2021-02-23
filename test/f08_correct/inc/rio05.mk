#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio05  ########


rio05: rio05.run

rio05.$(OBJX):  $(SRC)/rio05.f08
	-$(RM) rio05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio05.f08 -o rio05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio05.$(OBJX) check.$(OBJX) $(LIBS) -o rio05.$(EXESUFFIX)


rio05.run: rio05.$(OBJX)
	@echo ------------------------------------ executing test rio05
	rio05.$(EXESUFFIX)

build:	rio05.$(OBJX)

verify:	;

run:	 rio05.$(OBJX)
	@echo ------------------------------------ executing test rio05
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio05.$(EXESUFFIX) ||:
