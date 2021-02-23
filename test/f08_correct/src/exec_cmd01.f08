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
