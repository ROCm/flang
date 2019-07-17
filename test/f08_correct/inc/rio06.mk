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
# F2008-Recursive Input/Output feature compliance test
#
# Date of Modification: 17th July 2019
#

########## Make rule for test rio06  ########


rio06: rio06.run

rio06.$(OBJX):  $(SRC)/rio06.f08
	-$(RM) rio06.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/rio06.f08 -o rio06.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) rio06.$(OBJX) check.$(OBJX) $(LIBS) -o rio06.$(EXESUFFIX)


rio06.run: rio06.$(OBJX)
	@echo ------------------------------------ executing test rio06
	rio06.$(EXESUFFIX)

build:	rio06.$(OBJX)

verify:	;

run:	 rio06.$(OBJX)
	@echo ------------------------------------ executing test rio06
	-export FLANG_RECURSIVE_IO_SUPPORT=1; rio06.$(EXESUFFIX) ||:
