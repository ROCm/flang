#
# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
#
########## Make rule for test procedure pointer assignment ########
ppm: run

build:  $(SRC)/ppm.f90
	-$(RM) ppm.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/ppm.f90 -o ppm.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) ppm.$(OBJX) check.$(OBJX) $(LIBS) -o ppm.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test procedure pointer assignment
	ppm.$(EXESUFFIX)

verify: ;
