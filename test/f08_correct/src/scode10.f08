!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Sep 25 2019
!
! Tests if a STOP without an explicit code returns an integer code
!
PROGRAM SCODE10
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

  STOP 'VINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLLVINODsssssLLLLL'
END PROGRAM
