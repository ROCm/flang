!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
! Notified per clause 4(b) of the license.
!
!
! Unit test for parallel do reduction
! Date of Creation: 20 July 2020
!


FUNCTION almost_equal(x, gold, tol) RESULT(b)
  implicit none
  REAL,     intent(in) :: x
  INTEGER,  intent(in) :: gold
  REAL,     intent(in) :: tol
  LOGICAL              :: b
  b = ( gold * (1 - tol)  <= x ).AND.( x <= gold * (1+tol) )
END FUNCTION almost_equal
PROGRAM target__teams_distribute__parallel_do
  implicit none
  INTEGER :: N0 = 512
  INTEGER :: i0
  INTEGER :: N1 = 512
  INTEGER :: i1
  LOGICAL :: almost_equal
  REAL :: counter_N0
  INTEGER :: expected_value
  expected_value = N0*N1
  counter_N0 = 0
  !$OMP target map(tofrom: counter_N0)
  !$XOMP teams distribute reduction(+: counter_N0)
  DO i0 = 1, N0
    !$OMP parallel do reduction(+: counter_N0)
    DO i1 = 1, N1
      counter_N0 = counter_N0 + 1.
    END DO
  END DO
  !$OMP END target
  IF ( .NOT.almost_equal(counter_N0,expected_value, 0.1) ) THEN
    WRITE(*,*)  'Expected', expected_value,  'Got', counter_N0
    STOP 112
  ENDIF

END PROGRAM target__teams_distribute__parallel_do
