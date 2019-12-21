#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for F2008 feature mold and source
#

# Shared lit script for each tests. Run bash commands that run tests with make.
#===----------------------------------------------------------------------===//
#
# Date of Modification : 30th September 2019
# Added a new test for Copying the properties of an object in an allocate statement
#
#===----------------------------------------------------------------------===//

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
