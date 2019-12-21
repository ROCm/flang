!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!*
! F2008-New Unit Specifier feature compliance test
!* Date of Modification : 30th September 2019
!* Added a new test for Copying the properties of an object in an allocate statement
!*
!*===----------------------------------------------------------------------===//
program test_mold_source
      parameter(NTEST=14)
      real :: result(NTEST)
      real :: expect(NTEST)

      integer, allocatable :: a(:), b(:), c(:)
      integer :: i

      allocate(a(11:20))
      !allocate b with bounds of a
      allocate(b, mold=a)

      !initialize a
      do i = 11, 20
       a(i) = 100*i
      end do

      !allocate c with bounds of a and
      !initialize it with values of a
      allocate(c, source=a)

      expect(1) = lbound(a,1)
      expect(2) = ubound(a,1)
      expect(3) = lbound(a,1)
      expect(4) = ubound(a,1)
      result(1) = lbound(b,1)
      result(2) = ubound(b,1)
      result(3) = lbound(c,1)
      result(4) = ubound(c,1)
      !copy the values
      do i = 11, 20
       expect(i-11+5) = a(i)
      end do
      do i = 11, 20
       result(i-11+5) = c(i)
      end do

      !deallocate the arrays allocated
      deallocate(a)
      deallocate(b)
      deallocate(c)
      
      !compare the results
      call check(result,expect,NTEST)
end program test_mold_source
