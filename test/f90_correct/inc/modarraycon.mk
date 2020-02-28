#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test modarraycon  ########


modarraycon: run
	

build:  $(SRC)/modarraycon.f90
	-$(RM) modarraycon.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/modarraycon.f90 -o modarraycon.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) modarraycon.$(OBJX) check.$(OBJX) $(LIBS) -o modarraycon.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test modarraycon
	modarraycon.$(EXESUFFIX)

verify: ;

modarraycon.run: run

