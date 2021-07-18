program main
complex(kind=8) :: D,D2
real(kind=8) :: expr,expi
D=0
D2=(1,2)
expr = 10.0
expi = 20.0
  !$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO MAP(TOFROM: D,D2)
      do i=1, 10
       !$omp critical
         D=D+D2
       !$omp end critical
      end do
      !$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
      call __check_double(DBLE(D),EXPR, 1)
      call __check_double(DIMAG(D),EXPI, 1)
end program
