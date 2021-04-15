#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio03  ########


rio03: rio03.run

rio03.$(OBJX):  $(SRC)/rio03.f08
	-$(RM) rio03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio03.f08 -o rio03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio03.$(OBJX) check.$(OBJX) $(LIBS) -o rio03.$(EXESUFFIX)


rio03.run: rio03.$(OBJX)
	@echo ------------------------------------ executing test rio03
	rio03.$(EXESUFFIX)

build:	rio03.$(OBJX)

verify:	;

run:	 rio03.$(OBJX)
	@echo ------------------------------------ executing test rio03
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio03.$(EXESUFFIX) ||:
