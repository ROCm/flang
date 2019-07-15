#
# Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#

########## Make rule for test scode04  ########


scode04: scode04.run

scode04.$(OBJX):  $(SRC)/scode04.f08
	-$(RM) scode04.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode04.f08 -o scode04.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode04.$(OBJX) check.$(OBJX) $(LIBS) -o scode04.$(EXESUFFIX)


scode04.run: scode04.$(OBJX)
	@echo ------------------------------------ executing test scode04
	scode04.$(EXESUFFIX)

build:	scode04.$(OBJX)

verify:	;

run:	 scode04.$(OBJX)
	@echo ------------------------------------ executing test scode04
	-scode04.$(EXESUFFIX) ||:
