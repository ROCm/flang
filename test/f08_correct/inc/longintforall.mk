#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for longintforall intrinsic.
#

########## Make rule for test longintforall  ########
#===----------------------------------------------------------------------===//
#
# Date of Modification : 19th July 2019
# Added a new test for use of kind of a forall index
#
#===----------------------------------------------------------------------===//


longintforall: .run

longintforall.$(OBJX):  $(SRC)/longintforall.f08
	-$(RM) longintforall.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/longintforall.f08 -o longintforall.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) longintforall.$(OBJX) check.$(OBJX) $(LIBS) -o longintforall.$(EXESUFFIX)


longintforall.run: longintforall.$(OBJX)
	@echo ------------------------------------ executing test longintforall
	longintforall.$(EXESUFFIX)

build:	longintforall.$(OBJX)

verify:	;

run:	 longintforall.$(OBJX)
	@echo ------------------------------------ executing test longintforall
	longintforall.$(EXESUFFIX)

