#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

# Shared lit script for each tests. Run bash commands that run tests with make.

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
