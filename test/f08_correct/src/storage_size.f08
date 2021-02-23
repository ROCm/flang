!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!* F2008 feature storage_size intrinsic
!* Returns the storage size of argument in bits.
!*
!* result = storage_size(a [, kind])
!* Arguments
!* a - Shall be a scalar or array of any type.
!* kind - (Optional) shall be a scalar integer constant expressioni
!* AOCC test
      program test_storage_size

       parameter(NTEST=3)
       integer :: expect(NTEST) = [ 32, 32, 32 ]
       integer :: result(NTEST)

       integer :: x = 5
       logical :: y(3) = [.true., .false., .true.]
       integer :: storage_size1 = storage_size(x)
       integer :: storage_size2 = storage_size(y)
       integer :: storage_size3 = storage_size(10.85, 8)

       print *,"! storage_size1"
       print *, storage_size1
       result(1) = storage_size1;

       print *,"! storage_size2"
       print *, storage_size2
       result(2) = storage_size2;

       print *,"! storage_size3"
       print *, storage_size3
       result(3) = storage_size3;
      call check(result,expect,NTEST)
      end program

