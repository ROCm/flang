#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk11  ########

blk11: blk11.run

blk11.$(OBJX):  $(SRC)/blk11.f08
	-$(RM) blk11.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk11.f08 -o blk11.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) blk11.$(OBJX) check.$(OBJX) $(LIBS) -o blk11.$(EXESUFFIX)


blk11.run: blk11.$(OBJX)
	@echo ------------------------------------ executing test blk11
	blk11.$(EXESUFFIX)

build:	blk11.$(OBJX)

verify:	;

run:	 blk11.$(OBJX)
	@echo ------------------------------------ executing test blk11
	-blk11.$(EXESUFFIX) ||:
