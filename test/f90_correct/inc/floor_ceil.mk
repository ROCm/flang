#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# quad support for floor and ceiling
#
# 
#
########## Make rule for test floor_ceil ########
floor_ceil: run

build:  $(SRC)/floor_ceil.f90
	-$(RM) floor_ceil.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/floor_ceil.f90 -o floor_ceil.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) floor_ceil.$(OBJX) check.$(OBJX) $(LIBS) -o floor_ceil.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test floor_ceil
	floor_ceil.$(EXESUFFIX)

verify: ;
