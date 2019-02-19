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
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

########## Make rule for test nm02  ########


nm02: nm02.run

nm02.$(OBJX):  $(SRC)/nm02.f08
	-$(RM) nm02.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/nm02.f08 -o nm02.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) nm02.$(OBJX) check.$(OBJX) $(LIBS) -o nm02.$(EXESUFFIX)


nm02.run: nm02.$(OBJX)
	@echo ------------------------------------ executing test nm02
	nm02.$(EXESUFFIX)

build:	nm02.$(OBJX)

verify:	;

run:	 nm02.$(OBJX)
	@echo ------------------------------------ executing test nm02
	nm02.$(EXESUFFIX)
