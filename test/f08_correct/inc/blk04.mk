#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk04  ########

blk04: blk04.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

blk04.$(OBJX):  $(SRC)/blk04.f08
	-$(RM) blk04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk04.f08 -o blk04.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) blk04.$(OBJX) check.$(OBJX) $(LIBS) -o blk04.$(EXESUFFIX) ||:

blk04.run: passok.$(OBJX)
	@echo ------------------------------------ executing test blk04
	-passok.$(EXESUFFIX) ||:

build:	blk04.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test blk04
	-passok.$(EXESUFFIX) ||:
