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
# Support for execute_command_line as per f2008 standard
#

########## Make rule for test exec_cmd01  ########


exec_cmd01: exec_cmd01.run

exec_cmd01.$(OBJX):  $(SRC)/exec_cmd01.f08
	-$(RM) exec_cmd01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/exec_cmd01.f08 -o exec_cmd01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) exec_cmd01.$(OBJX) $(LIBS) -o exec_cmd01.$(EXESUFFIX)


exec_cmd01.run: exec_cmd01.$(OBJX)
	@echo ------------------------------------ executing test exec_cmd01
	exec_cmd01.$(EXESUFFIX)

build:	exec_cmd01.$(OBJX)

verify:	;

run:	 exec_cmd01.$(OBJX)
	@echo ------------------------------------ executing test exec_cmd01
	exec_cmd01.$(EXESUFFIX)
