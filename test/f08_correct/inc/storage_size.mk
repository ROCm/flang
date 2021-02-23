#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for storage_size intrinsic.
#

########## Make rule for test storage_size  ########


storage_size: .run

storage_size.$(OBJX):  $(SRC)/storage_size.f08
	-$(RM) storage_size.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/storage_size.f08 -o storage_size.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) storage_size.$(OBJX) check.$(OBJX) $(LIBS) -o storage_size.$(EXESUFFIX)


storage_size.run: storage_size.$(OBJX)
	@echo ------------------------------------ executing test storage_size
	storage_size.$(EXESUFFIX)

build:	storage_size.$(OBJX)

verify:	;

run:	 storage_size.$(OBJX)
	@echo ------------------------------------ executing test storage_size
	storage_size.$(EXESUFFIX)

