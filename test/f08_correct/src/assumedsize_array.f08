!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* Assumed size array as a parameter
!* AOCC test

      program test_assumedsize_array
       parameter(NTEST=2)
       integer :: expect(NTEST) = (/ 3, 6 /)
       integer :: result(NTEST)
         integer, dimension(*), parameter :: x = [1, 2, 3]
         integer, dimension(*), parameter :: y = [x, -x]
         integer :: r1, r2
         r1 = size(x)
         print *, r1
         result(1) = r1
         r2 = size(y)
         print *, r2
         result(2) = r2
         call check(result,expect,NTEST)
       end program test_assumedsize_array

