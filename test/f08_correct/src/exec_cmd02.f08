!
! Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!

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
