#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for mold and source.
#

########## Make rule for test mold-source  ########
#===----------------------------------------------------------------------===//
#
# Date of Modification : 30th September 2019
# Added a new test for Copying the properties of an object in an allocate statement
#
#===----------------------------------------------------------------------===//


mold-source: .run

mold-source.$(OBJX):  $(SRC)/mold-source.f08
	-$(RM) mold-source.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/mold-source.f08 -o mold-source.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) mold-source.$(OBJX) check.$(OBJX) $(LIBS) -o mold-source.$(EXESUFFIX)


mold-source.run: mold-source.$(OBJX)
	@echo ------------------------------------ executing test mold-source
	mold-source.$(EXESUFFIX)

build:	mold-source.$(OBJX)

verify:	;

run:	 mold-source.$(OBJX)
	@echo ------------------------------------ executing test mold-source
	mold-source.$(EXESUFFIX)

