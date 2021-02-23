!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control
!
! Date of Modification: 07 January 2020
!
! [CPUPC-2569]Complex data types support for acosh, asinh and atanh

program ComplexHyperbolic
implicit none
   integer a

   complex, parameter :: i = (0, 1)   ! sqrt(-1)
   complex :: x, y, z
   
   integer , parameter :: n = 9
   real(kind=4) :: result(n)
   real(kind=4) :: expect(n) = [0.000000,1.570796,3.240406,0.1457423,1.508243,1.022660,1.570350,0.1836487,1.197106]
   
   x = (7, 8.852)
   y = (5.656, -7)
   result(1) = real(asinh(i))
   result(2) = imag(asinh(i))
   
   z = x + y
   result(3) = real(acosh(z))
   result(4) = imag(acosh(z))
   
   z = x - y
   result(5) = imag(atanh(z))
   
   z = x * y
   result(6) = real(asinh(atanh(z*x+y)))
   result(7) = imag(asinh(atanh(z*x+y)))
   
   z = x / y
   result(8) = real(atanh(acosh(asinh(z))))
   result(9) = imag(atanh(acosh(asinh(z))))
   
   do a = 1 , n
      print*, result(a) , expect(a)
   end do

   call checkf(result,expect,n)
end program ComplexHyperbolic
