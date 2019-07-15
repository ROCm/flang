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

########## Make rule for test scode03  ########


scode03: scode03.run

scode03.$(OBJX):  $(SRC)/scode03.f08
	-$(RM) scode03.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/scode03.f08 -o scode03.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) scode03.$(OBJX) check.$(OBJX) $(LIBS) -o scode03.$(EXESUFFIX)


scode03.run: scode03.$(OBJX)
	@echo ------------------------------------ executing test scode03
	scode03.$(EXESUFFIX)

build:	scode03.$(OBJX)

verify:	;

run:	 scode03.$(OBJX)
	@echo ------------------------------------ executing test scode03
	-scode03.$(EXESUFFIX) ||:
