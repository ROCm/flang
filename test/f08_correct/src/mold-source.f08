!*===----------------------------------------------------------------------===//
!*====  Copyright (c) 2015 Advanced Micro Devices, Inc.  All rights reserved.
!*
!*               Developed by: Advanced Micro Devices, Inc.
!*
!* Permission is hereby granted, free of charge, to any person obtaining a copy
!* of this software and associated documentation files (the "Software"), to deal
!* with the Software without restriction, including without limitation the
!* rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
!* sell copies of the Software, and to permit persons to whom the Software is
!* furnished to do so, subject to the following conditions:
!*
!* Redistributions of source code must retain the above copyright notice, this
!* list of conditions and the following disclaimers.
!*
!* Redistributions in binary form must reproduce the above copyright notice,
!* this list of conditions and the following disclaimers in the documentation
!* and/or other materials provided with the distribution.
!*
!* Neither the names of Advanced Micro Devices, Inc., nor the names of its
!* contributors may be used to endorse or promote products derived from this
!* Software without specific prior written permission.
!*
!* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
!* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
!* CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
!* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH
!* THE SOFTWARE.
!*===----------------------------------------------------------------------===//
!*
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
