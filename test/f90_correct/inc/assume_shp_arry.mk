# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
# Date of Modification: March 2021
#

########## Make rule to test assumed shaped array ########

fcheck.o check_mod.mod: $(SRC)/check_mod.f90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.f90 -o fcheck.o

assume_shp_arry.o:  $(SRC)/assume_shp_arry.f90 check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/assume_shp_arry.f90 -o assume_shp_arry.o

assume_shp_arry: assume_shp_arry.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) assume_shp_arry.o fcheck.o $(LIBS) -o assume_shp_arry

assume_shp_arry.run: assume_shp_arry
	@echo ------------------------------------ executing test assume_shp_arry
	assume_shp_arry
	-$(RM) test_m.mod

### TA Expected Targets ###

build: $(TEST)
.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
