#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# complex quad support for asin, asinh, acos, acosh, atan, atanh
#
# 
#
########## Make rule for test quadsupport ########
quadsupport: run

build:  $(SRC)/quadsupport.f90
	-$(RM) quadsupport.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quadsupport.f90 -o quadsupport.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quadsupport.$(OBJX) check.$(OBJX) $(LIBS) -o quadsupport.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quadsupport
	quadsupport.$(EXESUFFIX)

verify: ;
