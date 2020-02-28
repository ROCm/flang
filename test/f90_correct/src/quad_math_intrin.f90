!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! [CPUPC-2997]Real128 support for math intrinsics 
! Date of Modification: 24 February 2020

program quad_math_intrin
!use, intrinsic :: iso_fortran_env
  integer , parameter :: n = 8
  real(kind=16) :: result(n) , expect(n)
 expect(1) = 0.5403023058681397174009366074429765q0
 expect(2) = 0.8414709848078965066525023216302989q0
 expect(3) = 1.5574077246549022305069748074583609q0
 expect(4) = 1.4706289056333368228857985121870589q0
 expect(5) = 0.1001674211615597963455231794526939q0
 expect(6) = 0.0996686524911620273784461198780209q0
 expect(7) = 2.1894172285742145953048002950024448q0
 expect(8) = 1.9477032116771781509195005140169613q0
 expect(9) = 1.0116663431728643707904067064500111q0
 expect(10) = 0.5403079157766272821143584942322321q0
 result(1) = cos(1.0q0)
 result(2) = sin(1.0q0)
 result(3) = tan(1.0q0)
 result(4) = acos(0.1q0)
 result(5) = asin(0.1q0)
 result(6) = atan(0.1q0)
 result(7) = cosh(1.42q0)
 result(8) = sinh(1.42q0)
 result(9) = sinh(tanh(1.42q0))
 result(10) = acosh(asinh(1.42q0))
    call checkf(result,expect,n)
end program quad_math_intrin
