program target_reduction
    use omp_lib

    implicit none

    integer     ::  counter
    integer     ::  ex_counter

    counter = 0
    ex_counter = 0

    !$OMP PARALLEL REDUCTION(+: ex_counter)
        ex_counter = ex_counter + 1
    !$OMP END PARALLEL

    !$OMP PARALLEL REDUCTION(+: counter)
        !$OMP TARGET IN_REDUCTION(+: counter) 
            counter = counter + 1
        !$OMP END TARGET
    !$OMP END PARALLEL

    call __check_int(ex_counter, counter, 1)
end program target_reduction
