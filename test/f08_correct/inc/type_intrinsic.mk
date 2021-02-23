#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-2836] f2008 feature: type statement for intrinsic types
#
# Date of Modification: 24 January 2020
#
########## Make rule for test type_intrinsic.f08 ########


type_intrinsic: .run

type_intrinsic.$(OBJX):  $(SRC)/type_intrinsic.f08
	-$(RM) type_intrinsic.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/type_intrinsic.f08 -o type_intrinsic.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) type_intrinsic.$(OBJX) check.$(OBJX) $(LIBS) -o type_intrinsic.$(EXESUFFIX)


type_intrinsic.run: type_intrinsic.$(OBJX)
	@echo ------------------------------------ executing test type_intrinsic.f08
	type_intrinsic.$(EXESUFFIX)

build:  type_intrinsic.$(OBJX)

verify: ;

run:     type_intrinsic.$(OBJX)
	@echo ------------------------------------ executing test type_intrinsic.f08
	-type_intrinsic.$(EXESUFFIX) ||:
