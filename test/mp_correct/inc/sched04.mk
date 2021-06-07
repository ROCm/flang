#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
sched04: sched04.$(OBJX)
	@echo ------------ executing test $@
	-$(RUN4) ./a.$(EXESUFFIX) $(LOG)
sched04.$(OBJX): $(SRC)/sched04.f check.$(OBJX)
	@echo ------------ building test $@
	-$(FC) $(FFLAGS) $(SRC)/sched04.f
	@$(RM) ./a.$(EXESUFFIX)
	-$(FC) $(LDFLAGS) sched04.$(OBJX) check.$(OBJX) $(LIBS) -o a.$(EXESUFFIX)
build: sched04
run: ;
