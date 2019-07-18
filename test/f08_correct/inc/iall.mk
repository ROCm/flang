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
# Support for iall intrinsic.
#

########## Make rule for test iall  ########


iall: .run

iall.$(OBJX):  $(SRC)/iall.f08
	-$(RM) iall.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/iall.f08 -o iall.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) iall.$(OBJX) check.$(OBJX) $(LIBS) -o iall.$(EXESUFFIX)


iall.run: iall.$(OBJX)
	@echo ------------------------------------ executing test iall
	iall.$(EXESUFFIX)

build:	iall.$(OBJX)

verify:	;

run:	 iall.$(OBJX)
	@echo ------------------------------------ executing test iall
	iall.$(EXESUFFIX)

