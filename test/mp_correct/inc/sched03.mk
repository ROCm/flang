#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
sched03: sched03.$(OBJX)
	@echo ------------ executing test $@
	-$(RUN4) ./a.$(EXESUFFIX) $(LOG)
sched03.$(OBJX): $(SRC)/sched03.f check.$(OBJX)
	@echo ------------ building test $@
	-$(FC) $(FFLAGS) $(SRC)/sched03.f
	@$(RM) ./a.$(EXESUFFIX)
	-$(FC) $(LDFLAGS) sched03.$(OBJX) check.$(OBJX) $(LIBS) -o a.$(EXESUFFIX)
build: sched03
run: ;
