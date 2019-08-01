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
# Support for gamma intrinsic.
#

########## Make rule for test gamma  ########


gamma: .run

gamma.$(OBJX):  $(SRC)/gamma.f08
	-$(RM) gamma.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/gamma.f08 -o gamma.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) gamma.$(OBJX) check.$(OBJX) $(LIBS) -o gamma.$(EXESUFFIX)


gamma.run: gamma.$(OBJX)
	@echo ------------------------------------ executing test gamma
	gamma.$(EXESUFFIX)

build:	gamma.$(OBJX)

verify:	;

run:	 gamma.$(OBJX)
	@echo ------------------------------------ executing test gamma
	gamma.$(EXESUFFIX)

