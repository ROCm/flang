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
# Support for pointer initialization as per f2008 standard
#

########## Make rule for test pointer_init01  ########


pointer_init01: pointer_init01.run

pointer_init01.$(OBJX):  $(SRC)/pointer_init01.f08
	-$(RM) pointer_init01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/pointer_init01.f08 -o pointer_init01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) pointer_init01.$(OBJX) check.$(OBJX) $(LIBS) -o pointer_init01.$(EXESUFFIX)


pointer_init01.run: pointer_init01.$(OBJX)
	@echo ------------------------------------ executing test pointer_init01
	pointer_init01.$(EXESUFFIX)

build:	pointer_init01.$(OBJX)

verify:	;

run:	 pointer_init01.$(OBJX)
	@echo ------------------------------------ executing test pointer_init01
	pointer_init01.$(EXESUFFIX)
