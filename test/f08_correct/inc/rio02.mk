#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio02  ########


rio02: rio02.run

rio02.$(OBJX):  $(SRC)/rio02.f08
	-$(RM) rio02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio02.f08 -o rio02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio02.$(OBJX) check.$(OBJX) $(LIBS) -o rio02.$(EXESUFFIX)


rio02.run: rio02.$(OBJX)
	@echo ------------------------------------ executing test rio02
	rio02.$(EXESUFFIX)

build:	rio02.$(OBJX)

verify:	;

run:	 rio02.$(OBJX)
	@echo ------------------------------------ executing test rio02
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio02.$(EXESUFFIX) ||:
