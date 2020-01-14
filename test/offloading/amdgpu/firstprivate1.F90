program pgm
  use omp_lib
  INTEGER :: compute_array(10)
  INTEGER :: compute_array_exp(10)
  INTEGER :: p_val

  compute_array = 0
  p_val = 11
  compute_array_exp = p_val

 !$omp target map(tofrom:compute_array(:)) firstprivate(p_val)
     compute_array  = p_val
 !$omp end target

 call __check_int(compute_array_exp, compute_array, 10)
end
