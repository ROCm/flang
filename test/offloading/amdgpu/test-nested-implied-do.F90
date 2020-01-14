PROGRAM test_target
  INTEGER :: s = 4
  INTEGER :: j
  INTEGER :: c1(1:6), c2(1:6), c_exp(1:6)

  c_exp = (/ 1, 2, 3, 4, 5, 6 /)

  c1 = (/ 1, (j+1, j=1, s ), 6/)
  !$omp target map(tofrom: c2(1:s), j, s)
  c2 = (/ 1, (j+1, j=1, s ), 6/)
  !$omp end target

  call __check_int(c_exp, c1, s)
  call __check_int(c_exp, c2, s)

END PROGRAM test_target
