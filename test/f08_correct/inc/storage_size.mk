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
# Support for storage_size intrinsic.
#

########## Make rule for test storage_size  ########


storage_size: .run

storage_size.$(OBJX):  $(SRC)/storage_size.f08
	-$(RM) storage_size.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/storage_size.f08 -o storage_size.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) storage_size.$(OBJX) check.$(OBJX) $(LIBS) -o storage_size.$(EXESUFFIX)


storage_size.run: storage_size.$(OBJX)
	@echo ------------------------------------ executing test storage_size
	storage_size.$(EXESUFFIX)

build:	storage_size.$(OBJX)

verify:	;

run:	 storage_size.$(OBJX)
	@echo ------------------------------------ executing test storage_size
	storage_size.$(EXESUFFIX)

