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
# Support for Bit Masking intrinsics.
#

########## Make rule for test bitmask01  ########


bitmask01: bitmask01.run

bitmask01.$(OBJX):  $(SRC)/bitmask01.f08
	-$(RM) bitmask01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitmask01.f08 -o bitmask01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bitmask01.$(OBJX) check.$(OBJX) $(LIBS) -o bitmask01.$(EXESUFFIX)


bitmask01.run: bitmask01.$(OBJX)
	@echo ------------------------------------ executing test bitmask01
	bitmask01.$(EXESUFFIX)

build:	bitmask01.$(OBJX)

verify:	;

run:	 bitmask01.$(OBJX)
	@echo ------------------------------------ executing test bitmask01
	bitmask01.$(EXESUFFIX)
