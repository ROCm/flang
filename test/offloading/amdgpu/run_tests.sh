#
# Modifications Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
# Notified per clause 4(b) of the license.
#
# Script to run regression test.
# Last modified 12th May 2020
#
# Usage :
# ./run.sh  [ testcase.F90 ]
#          if testcase.F90 is specified only that test will be run.
#          else all tests are run
#
#

#!/bin/bash
CC=clang
FC=flang
TARGET_FLAGS="-target x86_64-pc-linux-gnu"
DEVICE_FLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa"
MARCH="-march=gfx900"
VERSION="-mllvm -amdhsa-code-object-version=3"
#XFLAGS="-Mx,232,0x40"
XFLAGS=""
FFLAGS="$TARGET_FLAGS $DEVICE_FLAGS $MARCH $XFLAGS $VERSION -fuse-ld=ld -nogpulib"
total=0
passed=0
failed=0
echo "Offloading to AMD GPU"
$CC check.c -c -o check.o
if [[ $# -eq 0 ]]; then
  for file in *.F90
  do
    let "total++"
    basename=`basename $file .F90`
    $FC $FFLAGS $file check.o >& /dev/null
    if [ $? -ne 0 ]; then
      let "failed++"
      echo " $file : Compilation failure"
      continue
    fi
    ./a.out
    if [ $? -ne 0 ]; then
      let "failed++"
      echo " $file : Runtime failure"
    else
      let "passed++"
      echo " $file : Test case passed"
    fi
    rm ./a.out
  done
else
  #only used for developement testing
  if [[ $# -ne 1 ]]; then
    echo "WARNING: More than one file specified. Only compiling first one"
  fi
  file=$1
  let "total++"
  basename=`basename $file .F90`
  echo "Running file test $file"
  $FC $FFLAGS $file check.o
  if [ $? -ne 0 ]; then
    let "failed++"
    echo " $file : Compilation failure"
  else
    ./a.out
    if [ $? -ne 0 ]; then
      let "failed++"
      echo " $file : Runtime failure"
    else
      let "passed++"
      echo " $file : Test case passed"
    fi
  fi
  rm ./a.out
fi
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
