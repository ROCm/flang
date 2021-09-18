# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
# Date of Modification: May 2021
#

########## Make rule to test Big array initialization ########

fcheck.o check_mod.mod: $(SRC)/check_mod.f90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.f90 -o fcheck.o

big_data.o:  $(SRC)/big_data.f check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/big_data.f -o big_data.o

big_data: big_data.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) big_data.o fcheck.o $(LIBS) -o big_data

big_data.run: big_data
	@echo ------------------------------------ executing test big_data
	big_data
	-$(RM) testmod.mod

### TA Expected Targets ###

build: $(TEST)

.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
