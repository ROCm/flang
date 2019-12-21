#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for execute_command_line as per f2008 standard
#

# Shared lit script for each tests. Run bash commands that run tests with make.

# REQUIRES : Linux
# RUN: cp %S/../Inputs/input_for_exec_cmdline.txt .
# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake 
# RUN: diff input_for_exec_cmdline.txt output_file.txt
