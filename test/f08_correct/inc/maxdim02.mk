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
# Support for maximum dimension as per f2008 standard
#

########## Make rule for test maxdim02  ########


maxdim02: maxdim02.run

maxdim02.$(OBJX):  $(SRC)/maxdim02.f08
	-$(RM) maxdim02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/maxdim02.f08 -o maxdim02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) maxdim02.$(OBJX) check.$(OBJX) $(LIBS) -o maxdim02.$(EXESUFFIX)


maxdim02.run: maxdim02.$(OBJX)
	@echo ------------------------------------ executing test maxdim02
	maxdim02.$(EXESUFFIX)

build:	maxdim02.$(OBJX)

verify:	;

run:	 maxdim02.$(OBJX)
	@echo ------------------------------------ executing test maxdim02
	maxdim02.$(EXESUFFIX)
