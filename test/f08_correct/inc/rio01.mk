#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio01  ########


rio01: rio01.run

rio01.$(OBJX):  $(SRC)/rio01.f08
	-$(RM) rio01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio01.f08 -o rio01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio01.$(OBJX) check.$(OBJX) $(LIBS) -o rio01.$(EXESUFFIX)


rio01.run: rio01.$(OBJX)
	@echo ------------------------------------ executing test rio01
	rio01.$(EXESUFFIX)

build:	rio01.$(OBJX)

verify:	;

run:	 rio01.$(OBJX)
	@echo ------------------------------------ executing test rio01
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio01.$(EXESUFFIX) ||:
