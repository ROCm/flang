! Copyright (c) 2021, Advanced Micro Devices, Inc. All rights reserved.
!
! Date of Modification: May 2021

program main
USE CHECK_MOD
      implicit none

      logical results(3)
      logical expect(3)
      INTEGER :: a, b, c, s
      CHARACTER(:), ALLOCATABLE :: input_file_contents
      NAMELIST /Test_Data/ a, b, c

      a = 3
      b = 6
      c = 7

      open(9,file="input1.dat", action='write', recl=80)
      write(9,nml=Test_Data)
      close(9)

      a = 0
      b = 0
      c = 0

      INQUIRE(FILE='input1.dat', SIZE=s)
      ALLOCATE(CHARACTER(len=s) :: input_file_contents)
      open(unit=9, file='input1.dat', access='stream', action='read', status='old')
      read(9) input_file_contents
      close(9)

      READ(input_file_contents, NML = Test_Data)

      results = .false.
      expect = .true.

      results(1) = 3 .eq. a
      results(2) = 6 .eq. b
      results(3) = 7 .eq. c

      call check(results,expect,3)
end
