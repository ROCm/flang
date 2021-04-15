!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Revert to the old value when newunit has errors.
!
Program newunit02
  Integer :: iunit = 12345
  integer :: n = 1
  integer :: result(1) , expect(1)

  expect(1) = iunit

  Open(Newunit=iunit,File='Does not exist',Err=1,Status='Old')
  STOP iunit

1 Continue
  result(1) = iunit

 call check(expect , result , n)

End Program newunit02
