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

########## Make rule for test maxdim01  ########


maxdim01: maxdim01.run

maxdim01.$(OBJX):  $(SRC)/maxdim01.f08
	-$(RM) maxdim01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/maxdim01.f08 -o maxdim01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) maxdim01.$(OBJX) check.$(OBJX) $(LIBS) -o maxdim01.$(EXESUFFIX)


maxdim01.run: maxdim01.$(OBJX)
	@echo ------------------------------------ executing test maxdim01
	maxdim01.$(EXESUFFIX)

build:	maxdim01.$(OBJX)

verify:	;

run:	 maxdim01.$(OBJX)
	@echo ------------------------------------ executing test maxdim01
	maxdim01.$(EXESUFFIX)
