#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
# intent of an argument need not be specified if it has the 
# value attribute
#
# Date of Modification: Wed Feb 19 14:31:03 IST 2020
#
# Shared lit script for each tests. Run bash commands that run tests with make.
# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t
# RUN: cat %t | FileCheck %S/runmake
