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
# Support for iparity intrinsic.
#

########## Make rule for test iparity  ########


iparity: .run

iparity.$(OBJX):  $(SRC)/iparity.f08
	-$(RM) iparity.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/iparity.f08 -o iparity.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) iparity.$(OBJX) check.$(OBJX) $(LIBS) -o iparity.$(EXESUFFIX)


iparity.run: iparity.$(OBJX)
	@echo ------------------------------------ executing test iparity
	iparity.$(EXESUFFIX)

build:	iparity.$(OBJX)

verify:	;

run:	 iparity.$(OBJX)
	@echo ------------------------------------ executing test iparity
	iparity.$(EXESUFFIX)

