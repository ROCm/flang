#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
sched05: sched05.$(OBJX)
	@echo ------------ executing test $@
	-$(RUN4) ./a.$(EXESUFFIX) $(LOG)
sched05.$(OBJX): $(SRC)/sched05.f check.$(OBJX)
	@echo ------------ building test $@
	-$(FC) $(FFLAGS) $(SRC)/sched05.f
	@$(RM) ./a.$(EXESUFFIX)
	-$(FC) $(LDFLAGS) sched05.$(OBJX) check.$(OBJX) $(LIBS) -o a.$(EXESUFFIX)
build: sched05
run: ;
