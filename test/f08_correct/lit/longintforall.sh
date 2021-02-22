#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for F2008 feature longintforall intrinsic
#

# Shared lit script for each tests. Run bash commands that run tests with make.
#===----------------------------------------------------------------------===//
#
# Date of Modification : 19th July 2019
# Added a new test for use of kind of a forall index
#
#===----------------------------------------------------------------------===//

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
