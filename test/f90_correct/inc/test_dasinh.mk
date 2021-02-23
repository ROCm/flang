#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# support for test_dasinh
#
# 
#
########## Make rule for test test_dasinh ########
test_dasinh: run

build:  $(SRC)/test_dasinh.f90
	-$(RM) test_dasinh.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/test_dasinh.f90 -o test_dasinh.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) test_dasinh.$(OBJX) check.$(OBJX) $(LIBS) -o test_dasinh.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test test_dasinh
	test_dasinh.$(EXESUFFIX)

verify: ;
