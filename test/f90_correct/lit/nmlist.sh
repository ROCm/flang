# Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
#
# Date of Modification: May 2021
#

# RUN: KEEP_FILES=%keep FLAGS=%flags TEST_SRC=%s MAKE_FILE_DIR=%S/.. bash %S/runmake | tee %t 
# RUN: cat %t | FileCheck %S/runmake
