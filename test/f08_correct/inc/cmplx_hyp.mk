#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-2569]Complex data types support for acosh, asinh and atanh
#
# Date of Modification: 07 January 2020
#
########## Make rule for test cmplx_hyp ########


cmplx_hyp: cmplx_hyp.run

cmplx_hyp.$(OBJX):  $(SRC)/cmplx_hyp.f08
	-$(RM) cmplx_hyp.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/cmplx_hyp.f08 -o cmplx_hyp.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) cmplx_hyp.$(OBJX) check.$(OBJX) $(LIBS) -o cmplx_hyp.$(EXESUFFIX)


cmplx_hyp.run: cmplx_hyp.$(OBJX)
	@echo ------------------------------------ executing test cmplx_hyp
	cmplx_hyp.$(EXESUFFIX)

build:  cmplx_hyp.$(OBJX)

verify: ;

run:     cmplx_hyp.$(OBJX)
	@echo ------------------------------------ executing test cmplx_hyp
	-cmplx_hyp.$(EXESUFFIX) ||:
