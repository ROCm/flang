#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test quad_epsilon  ########


quad_epsilon: run
	

build:  $(SRC)/quad_epsilon.f90
	-$(RM) quad_epsilon.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quad_epsilon.f90 -o quad_epsilon.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quad_epsilon.$(OBJX) check.$(OBJX) $(LIBS) -o quad_epsilon.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test quad_epsilon
	quad_epsilon.$(EXESUFFIX)

verify: ;

quad_epsilon.run: run

