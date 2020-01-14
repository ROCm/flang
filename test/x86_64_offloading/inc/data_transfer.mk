#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

########## Make rule for test data_transfer  ########


data_transfer: data_transfer.run

data_transfer.$(OBJX):  $(SRC)/data_transfer.f90
	-$(RM) data_transfer.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/data_transfer.f90 -o data_transfer.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) data_transfer.$(OBJX) check.$(OBJX) $(LIBS) -o data_transfer.$(EXESUFFIX)


data_transfer.run: data_transfer.$(OBJX)
	@echo ------------------------------------ executing test data_transfer
	data_transfer.$(EXESUFFIX)

build:	data_transfer.$(OBJX)

verify:	;

run:	 data_transfer.$(OBJX)
	@echo ------------------------------------ executing test data_transfer
	data_transfer.$(EXESUFFIX)
