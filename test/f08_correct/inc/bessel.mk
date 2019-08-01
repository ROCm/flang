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
# Support for bessel intrinsic.
#

########## Make rule for test bessel  ########


bessel: .run

bessel.$(OBJX):  $(SRC)/bessel.f08
	-$(RM) bessel.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bessel.f08 -o bessel.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) bessel.$(OBJX) check.$(OBJX) $(LIBS) -o bessel.$(EXESUFFIX)


bessel.run: bessel.$(OBJX)
	@echo ------------------------------------ executing test bessel
	bessel.$(EXESUFFIX)

build:	bessel.$(OBJX)

verify:	;

run:	 bessel.$(OBJX)
	@echo ------------------------------------ executing test bessel
	bessel.$(EXESUFFIX)

