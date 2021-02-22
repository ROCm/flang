#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for radix in selected_real_kind intrisic intrinsics.
#

########## Make rule for test selectrealkind  ########


selectrealkind: .run

selectrealkind.$(OBJX):  $(SRC)/selectrealkind.f08
	-$(RM) selectrealkind.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/selectrealkind.f08 -o selectrealkind.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) selectrealkind.$(OBJX) check.$(OBJX) $(LIBS) -o selectrealkind.$(EXESUFFIX)


selectrealkind.run: selectedrealkind.$(OBJX)
	@echo ------------------------------------ executing test selectrealkind
	selectrealkind.$(EXESUFFIX)

build:	selectrealkind.$(OBJX)

verify:	;

run:	 selectrealkind.$(OBJX)
	@echo ------------------------------------ executing test selectrealkind
	selectrealkind.$(EXESUFFIX)

