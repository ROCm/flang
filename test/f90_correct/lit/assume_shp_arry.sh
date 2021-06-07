#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# Shared lit script for each tests. Run bash commands that run tests with make.

# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Date of Modification: December 2019
#

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t 
# RUN: cat %t | FileCheck %S/runmake
