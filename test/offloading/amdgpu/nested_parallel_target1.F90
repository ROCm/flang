program pgm
  use omp_lib
  INTEGER :: compute_array(10, 10)
  INTEGER :: compute_array_exp(10, 10)
  INTEGER :: p_val, fp_val

  compute_array = 0
  compute_array_exp = 101
  p_val = 1
  fp_val = 2
  call omp_set_num_threads(10)

  !$omp parallel private(p_val, fp_val) shared(actualThreadCnt)
    fp_val = omp_get_thread_num() + 2
    p_val = omp_get_thread_num() + 1
    !$omp target map(tofrom:compute_array) map(to:fp_val) private(p_val)
      p_val = fp_val - 1
      compute_array(p_val,:) = 100 + compute_array(p_val,:)
      p_val = p_val + 99
    !$omp end target
    ! FIXME: With barrier!
    !$omp barrier 
    IF (p_val == omp_get_thread_num() + 1) THEN
     compute_array(p_val,:) = compute_array(p_val,:) + 1
    END IF
  !$omp end parallel

 call __check_int(compute_array_exp, compute_array, 100)

end  
