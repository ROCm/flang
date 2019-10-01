#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# Adding offload regression testcases
# Date of Creation: 1st July 2019
#
# Removing dependency on -Mx,232,0x10
# Date of modification 1st October 2019
#
#

#!/bin/bash
CC=clang
FC=flang
TARGET_FLAGS="-target x86_64-pc-linux-gnu"
DEVICE_FLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa"
MARCH="-march=gfx900"
XFLAGS="-Mx,232,0x40"
FFLAGS="$TARGET_FLAGS $DEVICE_FLAGS $MARCH $XFLAGS"
total=0
passed=0
failed=0
echo "Offloading to AMD GPU"
$CC check.c -c -o check.o
for file in *.F90
do
  let "total++"
  basename=`basename $file .F90`
  echo "Running file test $file"
  $FC $FFLAGS $file check.o >& /dev/null
  if [ $? -ne 0 ]; then
    let "failed++"
    echo "Test case failed : Compilation failure"
    continue
  fi
  ./a.out
  if [ $? -ne 0 ]; then
    let "failed++"
    echo "Test case failed : Runtime failure"
  else
    let "passed++"
    echo "Test case passed"
  fi
  rm ./a.out
done
rm check.o
rm *.mod
echo ""
echo "########################################################################"
echo ""
echo "Total test cases $total"
echo "Passes test cases $passed"
echo "Failed  test cases $failed"
echo ""
echo "########################################################################"
