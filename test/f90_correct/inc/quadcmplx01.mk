#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test quadcmplx01  ########


quadcmplx01: run


build:  $(SRC)/quadcmplx01.f90
	-$(RM) quadcmplx01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quadcmplx01.f90 -o quadcmplx01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quadcmplx01.$(OBJX) check.$(OBJX) $(LIBS) -o quadcmplx01.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quadcmplx01
	quadcmplx01.$(EXESUFFIX)

verify: ;

quadcmplx01.run: run

