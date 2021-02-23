PROGRAM ompdir_40
    USE OMP_LIB
    IMPLICIT NONE
    INTEGER I
    REAL :: A(10)=1.1, B(10)=2.2, C(10)=3.3

  !$omp do simd
    DO I=1,10
        C(I) = C(I) - A(I) + B(I)
        !PRINT *, "I = ", I, "By thread ", OMP_GET_THREAD_NUM()
    END DO
  !$omp end do simd

  PRINT *,"PASS"
  STOP "0"
END PROGRAM
