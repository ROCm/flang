#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# CPUPC-2613-F2008: The BLOCK construct allows declarations of 
# entities within executable code.
#
# Date of Modification: Fri November 8th, 2019
# 
########## Make rule for test blk02  ########

blk02: blk02.run

blk02.$(OBJX):  $(SRC)/blk02.f08
	-$(RM) blk02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/blk02.f08 -o blk02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) blk02.$(OBJX) check.$(OBJX) $(LIBS) -o blk02.$(EXESUFFIX)


blk02.run: blk02.$(OBJX)
	@echo ------------------------------------ executing test blk02
	blk02.$(EXESUFFIX)

build:	blk02.$(OBJX)

verify:	;

run:	 blk02.$(OBJX)
	@echo ------------------------------------ executing test blk02
	-blk02.$(EXESUFFIX) ||:
