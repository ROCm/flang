#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

# Shared lit script for each tests. Run bash commands that run tests with make.

UNSUPPORTED:
# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
