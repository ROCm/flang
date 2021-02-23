#
# Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Named Select feature
#
# Date of Modification: Jan 20 2020
#
# Tests the F2008 : Named Select feature
# Shared lit script for each tests. Run bash commands that run tests with make.
# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
