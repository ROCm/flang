#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-2997]Real128 support for math intrinsics
#
# Date of Modification: 24 February 2020
#
########## Make rule for test quad_math_intrin.f90 ########
quad_math_intrin: .run
quad_math_intrin.$(OBJX):  $(SRC)/quad_math_intrin.f90
	-$(RM) quad_math_intrin.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/quad_math_intrin.f90 -lquadmath -o quad_math_intrin.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) quad_math_intrin.$(OBJX) -lquadmath check.$(OBJX) $(LIBS) -o quad_math_intrin.$(EXESUFFIX)
quad_math_intrin.run: quad_math_intrin.$(OBJX)
	@echo ------------------------------------ executing test quad_math_intrin.f90
	quad_math_intrin.$(EXESUFFIX)
build:  quad_math_intrin.$(OBJX)
verify: ;
run:     quad_math_intrin.$(OBJX)
	@echo ------------------------------------ executing test quad_math_intrin.f90
	-quad_math_intrin.$(EXESUFFIX) ||:
