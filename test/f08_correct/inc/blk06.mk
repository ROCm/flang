#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk06  ########

blk06: blk06.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

blk06.$(OBJX):  $(SRC)/blk06.f08
	-$(RM) blk06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk06.f08 -o blk06.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) blk06.$(OBJX) check.$(OBJX) $(LIBS) -o blk06.$(EXESUFFIX) ||:

blk06.run: passok.$(OBJX)
	@echo ------------------------------------ executing test blk06
	-passok.$(EXESUFFIX) ||:

build:	blk06.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test blk06
	-passok.$(EXESUFFIX) ||:
