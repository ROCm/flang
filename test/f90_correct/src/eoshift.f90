!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* eoshift
!* AOCC test
program eoshift_intrin
  real(kind=16), dimension(3,3) :: expect, result, a 
  real(kind=16) :: b = -5_16
  a = RESHAPE( (/ 1.2_16, 2.2_16, 3.2_16, 4.2_16, 5.2_16, 6.2_16, 7.2_16, 8.2_16, 9.2_16 /), (/ 3, 3 /))
  a = EOSHIFT(a, SHIFT=(/1, 2, 1/), BOUNDARY=b, DIM=2)
  result(1,:) = a(1,:)
  result(2,:) = a(2,:)
  result(3,:) = a(3,:)
  expect(1,:) = (/4.2_16, 7.2_16, -5.0_16/)
  expect(2,:) = (/8.2_16, -5.0_16, -5.0_16/)
  expect(3,:) = (/6.2_16, 9.2_16, -5.0_16/)
  call check(result, expect, 9) 
end program

