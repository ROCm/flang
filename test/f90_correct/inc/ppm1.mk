#
# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
#
########## Make rule for test procedure pointer assignment ########
ppm1: run

build:  $(SRC)/ppm1.f90
	-$(RM) ppm1.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/ppm1.f90 -o ppm1.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) ppm1.$(OBJX) check.$(OBJX) $(LIBS) -o ppm1.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test procedure pointer assignment
	ppm1.$(EXESUFFIX)

verify: ;
