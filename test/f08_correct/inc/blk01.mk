#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk01  ########

blk01: blk01.run

blk01.$(OBJX):  $(SRC)/blk01.f08
	-$(RM) blk01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk01.f08 -o blk01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) blk01.$(OBJX) check.$(OBJX) $(LIBS) -o blk01.$(EXESUFFIX)


blk01.run: blk01.$(OBJX)
	@echo ------------------------------------ executing test blk01
	blk01.$(EXESUFFIX)

build:	blk01.$(OBJX)

verify:	;

run:	 blk01.$(OBJX)
	@echo ------------------------------------ executing test blk01
	-blk01.$(EXESUFFIX) ||:
