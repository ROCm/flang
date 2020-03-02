#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-3039]Call To "nearest" intrinsic at declaration
#
# Date of Modification: 2 March 2020
#
# Shared lit script for each tests. Run bash commands that run tests with make.

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
