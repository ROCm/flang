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
# Support for Bit Shifting intrinsics.
#

########## Make rule for test bitshift01  ########


bitshift01: bitshift01.run

bitshift01.$(OBJX):  $(SRC)/bitshift01.f08
	-$(RM) bitshift01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitshift01.f08 -o bitshift01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitshift01.$(OBJX) check.$(OBJX) $(LIBS) -o bitshift01.$(EXESUFFIX)


bitshift01.run: bitshift01.$(OBJX)
	@echo ------------------------------------ executing test bitshift01
	bitshift01.$(EXESUFFIX)

build:	bitshift01.$(OBJX)

verify:	;

run:	 bitshift01.$(OBJX)
	@echo ------------------------------------ executing test bitshift01
	bitshift01.$(EXESUFFIX)
