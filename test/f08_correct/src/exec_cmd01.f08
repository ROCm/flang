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
! This test case is derived from the Flexi benchmark



program exec_command 

call WriteTimeAverageByCopy("../input_for_exec_cmdline.txt", "../output_file.txt")

contains
subroutine WriteTimeAverageByCopy(filename_in,filename_out)
implicit none
!-----------------------------------------------------------------------------------------------------------------------------------
! INPUT/OUTPUT VARIABLES
character(len=*),intent(in) :: filename_in  !< file to be copied
character(len=*),intent(in) :: filename_out !< output file
integer                     :: iStatus
  call execute_command_line("cp -f "//trim(filename_in)//" "//trim(filename_out), wait=.true., exitstat=iStatus)
  print *, "Exit status of command is ", iStatus
end subroutine WriteTimeAverageByCopy

end program exec_command 
