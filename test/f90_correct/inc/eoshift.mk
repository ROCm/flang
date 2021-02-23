#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
#
#
# 
#
########## Make rule for test eoshift ########
eoshift: run

build:  $(SRC)/eoshift.f90
	-$(RM) eoshift.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/eoshift.f90 -o eoshift.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) eoshift.$(OBJX) check.$(OBJX) $(LIBS) -o eoshift.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test eoshift
	eoshift.$(EXESUFFIX)

verify: ;
