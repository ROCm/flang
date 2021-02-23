#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# [CPUPC-2997]Real128 support for math intrinsics
#
# Date of Modification: 24 February 2020
#
# Shared lit script for each tests. Run bash commands that run tests with make.

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
