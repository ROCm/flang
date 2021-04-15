#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# support for cotan and cotand
#
# 
#
########## Make rule for test test_cotan ########
test_cotan: run

build:  $(SRC)/test_cotan.f90
	-$(RM) test_cotan.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/test_cotan.f90 -o test_cotan.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) test_cotan.$(OBJX) check.$(OBJX) $(LIBS) -o test_cotan.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test test_cotan
	test_cotan.$(EXESUFFIX)

verify: ;
