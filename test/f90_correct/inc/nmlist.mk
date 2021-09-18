# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
# Date of Modification: May 2021
#

########## Make rule to test namelist with allocatable array ########

fcheck.o check_mod.mod: $(SRC)/check_mod.f90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.f90 -o fcheck.o

nmlist.o:  $(SRC)/nmlist.f90 check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nmlist.f90 -o nmlist.o

nmlist: nmlist.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) nmlist.o fcheck.o $(LIBS) -o nmlist

nmlist.run: nmlist
	@echo ------------------------------------ executing test nmlist
	nmlist
	-$(RM) test_m.mod

### TA Expected Targets ###

build: $(TEST)

.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
