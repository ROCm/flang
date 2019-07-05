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
# Support for MERGE_BITS intrinsic.
#

########## Make rule for test merge_bits01  ########


merge_bits01: merge_bits01.run

merge_bits01.$(OBJX):  $(SRC)/merge_bits01.f08
	-$(RM) merge_bits01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/merge_bits01.f08 -o merge_bits01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) merge_bits01.$(OBJX) check.$(OBJX) $(LIBS) -o merge_bits01.$(EXESUFFIX)


merge_bits01.run: merge_bits01.$(OBJX)
	@echo ------------------------------------ executing test merge_bits01
	merge_bits01.$(EXESUFFIX)

build:	merge_bits01.$(OBJX)

verify:	;

run:	 merge_bits01.$(OBJX)
	@echo ------------------------------------ executing test merge_bits01
	merge_bits01.$(EXESUFFIX)
