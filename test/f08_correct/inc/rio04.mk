#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio04  ########


rio04: rio04.run

rio04.$(OBJX):  $(SRC)/rio04.f08
	-$(RM) rio04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio04.f08 -o rio04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio04.$(OBJX) check.$(OBJX) $(LIBS) -o rio04.$(EXESUFFIX)


rio04.run: rio04.$(OBJX)
	@echo ------------------------------------ executing test rio04
	rio04.$(EXESUFFIX)

build:	rio04.$(OBJX)

verify:	;

run:	 rio04.$(OBJX)
	@echo ------------------------------------ executing test rio04
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio04.$(EXESUFFIX) ||:
