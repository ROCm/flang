#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
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

########## Make rule for test seco01  ########


seco01: seco01.run

seco01.$(OBJX):  $(SRC)/seco01.f08
	-$(RM) seco01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/seco01.f08 -o seco01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) seco01.$(OBJX) check.$(OBJX) $(LIBS) -o seco01.$(EXESUFFIX)


seco01.run: seco01.$(OBJX)
	@echo ------------------------------------ executing test seco01
	seco01.$(EXESUFFIX)

build:	seco01.$(OBJX)

verify:	;

run:	 seco01.$(OBJX)
	@echo ------------------------------------ executing test seco01
	-seco01.$(EXESUFFIX) ||:
