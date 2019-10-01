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
# Support for mold and source.
#

########## Make rule for test mold-source  ########
#===----------------------------------------------------------------------===//
#
# Date of Modification : 30th September 2019
# Added a new test for Copying the properties of an object in an allocate statement
#
#===----------------------------------------------------------------------===//


mold-source: .run

mold-source.$(OBJX):  $(SRC)/mold-source.f08
	-$(RM) mold-source.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/mold-source.f08 -o mold-source.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) mold-source.$(OBJX) check.$(OBJX) $(LIBS) -o mold-source.$(EXESUFFIX)


mold-source.run: mold-source.$(OBJX)
	@echo ------------------------------------ executing test mold-source
	mold-source.$(EXESUFFIX)

build:	mold-source.$(OBJX)

verify:	;

run:	 mold-source.$(OBJX)
	@echo ------------------------------------ executing test mold-source
	mold-source.$(EXESUFFIX)

