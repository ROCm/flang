#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-3039]Call To "nearest" intrinsic at declaration
#
# Date of Modification: 02 March 2020
#
########## Make rule for test nearest_intrin.f90 ########
nearest_intrin: run

build:  $(SRC)/nearest_intrin.f90
	-$(RM) nearest_intrin.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nearest_intrin.f90 -o nearest_intrin.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nearest_intrin.$(OBJX) check.$(OBJX) $(LIBS) -o nearest_intrin.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test nearest_intrin
	nearest_intrin.$(EXESUFFIX)

verify: ;

