#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for type_intr_type intrinsic.
#

########## Make rule for test type_intr_type  ########


type_intr_type: .run

type_intr_type.$(OBJX):  $(SRC)/type_intr_type.f08
	-$(RM) type_intr_type.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/type_intr_type.f08 -o type_intr_type.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) type_intr_type.$(OBJX) check.$(OBJX) $(LIBS) -o type_intr_type.$(EXESUFFIX)


type_intr_type.run: type_intr_type.$(OBJX)
	@echo ------------------------------------ executing test type_intr_type
	type_intr_type.$(EXESUFFIX)

build:	type_intr_type.$(OBJX)

verify:	;

run:	 type_intr_type.$(OBJX)
	@echo ------------------------------------ executing test type_intr_type
	type_intr_type.$(EXESUFFIX)

