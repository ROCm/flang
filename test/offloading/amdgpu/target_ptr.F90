!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Unit test for use of static variables inside target region
! Date of Creation: 22nd June 2020
!
program foo
  integer, allocatable:: a(:)
  integer, target:: b(100)
  integer, pointer::c(:)
  integer :: success = 1

  allocate(a(100))
  c=>b

  c = 100

  a = 4

!$omp target
  a(50) = b(50) + 2
  a(49) = c(49) + 1
  b(48) = 0
  c(47) = 99
!$omp end target

  if (a(48).eq.4 .and. a(49).eq.101 .and. a(50).eq.102 .and. b(47).eq.99 .and. &
& b(48).eq. 0 .and. c(46).eq.100 .and. c(47).eq.99) then
    success = 0
   else
     Stop -1
   endif
end
