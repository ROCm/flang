!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for execute_command_line as per f2008 standard
!

program exec_command 
  integer :: ex_st = 100

  call execute_command_line("echo Hello World", .true., ex_st)
  print *, "This is synchronous"
  print *, "Exit status is ", ex_st

end program exec_command 

! CHECK: Hello World
! CHECK-NEXT : This is synchronous
! CHECK-NEXT : Exit status is 0
