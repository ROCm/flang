#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio06  ########


rio06: rio06.run

rio06.$(OBJX):  $(SRC)/rio06.f08
	-$(RM) rio06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio06.f08 -o rio06.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio06.$(OBJX) check.$(OBJX) $(LIBS) -o rio06.$(EXESUFFIX)


rio06.run: rio06.$(OBJX)
	@echo ------------------------------------ executing test rio06
	rio06.$(EXESUFFIX)

build:	rio06.$(OBJX)

verify:	;

run:	 rio06.$(OBJX)
	@echo ------------------------------------ executing test rio06
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio06.$(EXESUFFIX) ||:
