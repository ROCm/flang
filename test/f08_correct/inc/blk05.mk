#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk05  ########

blk05: blk05.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

blk05.$(OBJX):  $(SRC)/blk05.f08
	-$(RM) blk05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk05.f08 -o blk05.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) blk05.$(OBJX) check.$(OBJX) $(LIBS) -o blk05.$(EXESUFFIX) ||:

blk05.run: passok.$(OBJX)
	@echo ------------------------------------ executing test blk05
	-passok.$(EXESUFFIX) ||:

build:	blk05.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test blk05
	-passok.$(EXESUFFIX) ||:
