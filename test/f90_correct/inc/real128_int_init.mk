#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# 
#
# 
#
########## Make rule for test real128_int_init ########
real128_int_init: run

build:  $(SRC)/real128_int_init.f90
	-$(RM) real128_int_init.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/real128_int_init.f90 -o real128_int_init.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) real128_int_init.$(OBJX) check.$(OBJX) $(LIBS) -o real128_int_init.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test real128_int_init
	real128_int_init.$(EXESUFFIX)

verify: ;
