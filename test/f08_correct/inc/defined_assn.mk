#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-2293]Take copy of rhs in defined assignment statement.
#
# Date of Modification: 26 June 2020
#
########## Make rule for test defined_assn.f08 ########


defined_assn: .run

defined_assn.$(OBJX):  $(SRC)/defined_assn.f08
	-$(RM) defined_assn.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/defined_assn.f08 -o defined_assn.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) defined_assn.$(OBJX) check.$(OBJX) $(LIBS) -o defined_assn.$(EXESUFFIX)


defined_assn.run: defined_assn.$(OBJX)
	@echo ------------------------------------ executing test defined_assn.f08
	defined_assn.$(EXESUFFIX)

build:  defined_assn.$(OBJX)

verify: ;

run:     defined_assn.$(OBJX)
	@echo ------------------------------------ executing test defined_assn.f08
	-defined_assn.$(EXESUFFIX) ||:
