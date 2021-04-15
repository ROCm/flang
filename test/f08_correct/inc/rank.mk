#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-3849] Rank intrinsic for flang
#
# Date of Modification: 10 Aug 2020
#
########## Make rule for test rank.f08 ########


rank: .run

rank.$(OBJX):  $(SRC)/rank.f08
	-$(RM) rank.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rank.f08 -o rank.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rank.$(OBJX) check.$(OBJX) $(LIBS) -o rank.$(EXESUFFIX)


rank.run: rank.$(OBJX)
	@echo ------------------------------------ executing test rank.f08
	rank.$(EXESUFFIX)

build:  rank.$(OBJX)

verify: ;

run:     rank.$(OBJX)
	@echo ------------------------------------ executing test rank.f08
	-rank.$(EXESUFFIX) ||:
