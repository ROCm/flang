#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for transpose intrinsic during initialization
#
# Date of Modification: 1st March 2019
#


# Shared lit script for each tests. Run bash commands that run tests with make.
# This test is expected to fail till PGI switches the allocatable default to 03

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t 
# RUN: cat %t | FileCheck %S/runmake
