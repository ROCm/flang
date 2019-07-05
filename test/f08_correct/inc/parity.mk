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
# Support for parity intrinsic.
#

########## Make rule for test parity  ########


parity: .run

parity.$(OBJX):  $(SRC)/parity.f08
	-$(RM) parity.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/parity.f08 -o parity.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) parity.$(OBJX) check.$(OBJX) $(LIBS) -o parity.$(EXESUFFIX)


parity.run: parity.$(OBJX)
	@echo ------------------------------------ executing test parity
	parity.$(EXESUFFIX)

build:	parity.$(OBJX)

verify:	;

run:	 parity.$(OBJX)
	@echo ------------------------------------ executing test parity
	parity.$(EXESUFFIX)

