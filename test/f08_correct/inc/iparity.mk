#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for iparity intrinsic.
#

########## Make rule for test iparity  ########


iparity: .run

iparity.$(OBJX):  $(SRC)/iparity.f08
	-$(RM) iparity.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/iparity.f08 -o iparity.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) iparity.$(OBJX) check.$(OBJX) $(LIBS) -o iparity.$(EXESUFFIX)


iparity.run: iparity.$(OBJX)
	@echo ------------------------------------ executing test iparity
	iparity.$(EXESUFFIX)

build:	iparity.$(OBJX)

verify:	;

run:	 iparity.$(OBJX)
	@echo ------------------------------------ executing test iparity
	iparity.$(EXESUFFIX)

