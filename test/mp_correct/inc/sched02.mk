#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
sched01: sched01.$(OBJX)
	@echo ------------ executing test $@
	-$(RUN4) ./a.$(EXESUFFIX) $(LOG)
sched01.$(OBJX): $(SRC)/sched01.f check.$(OBJX)
	@echo ------------ building test $@
	-$(FC) $(FFLAGS) $(SRC)/sched01.f
	@$(RM) ./a.$(EXESUFFIX)
	-$(FC) $(LDFLAGS) sched01.$(OBJX) check.$(OBJX) $(LIBS) -o a.$(EXESUFFIX)
build: sched01
run: ;
