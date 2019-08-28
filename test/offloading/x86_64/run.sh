#! /bin/bash
#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#
# Last modified: Aug 2019
#

FC=flang
OMP_FLAGS="-fopenmp -fopenmp-targets=x86_64-pc-linux-gnu"
FFLAGS="$OMP_FLAGS"

CHECK_SRC="check.c"
CHECK_OBJ="check.o"

failed=0
for src in *.f90; do
  if ! $FC -c $FFLAGS $src $CHECK_SRC; then
    echo "$src failed during compilation"
    let "failed++"
    continue
  fi

  if ! $FC $FFLAGS "${src%.f90}.o" $CHECK_OBJ; then
    echo "$src failed during linking"
    let "failed++"
    continue
  fi

  if ! ./a.out &> /dev/null; then
      echo "$src failed during runtime"
      let "failed++"
  fi
  rm ./a.out
done
rm *.o *.mod &> /dev/null

if [[ $failed -ne 0 ]]; then
  echo "$failed test(s) failed"
else
  echo "All test(s) passed"
fi
