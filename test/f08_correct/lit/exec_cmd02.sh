#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for execute_command_line as per f2008 standard
#

# Shared lit script for each tests. Run bash commands that run tests with make.

# REQUIRES : Linux
# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake > %t 
# RUN: cat %t | FileCheck %s

# CHECK: Hello World
# CHECK-NEXT : This is synchronous
# CHECK-NEXT : Exit status is 0
