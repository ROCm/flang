!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Jul 2020
!

subroutine subr1(curr_arr, next_arr, send, n, shared_0, x)
  integer, intent(in)  :: n, send(n)
  real(8), intent(in)  :: curr_arr(n), shared_0, x
  real(8), intent(out) :: next_arr(n)

  integer i_ct
  real(8) :: tmp_1, tmp_2, tmp_3
  real(8) :: shared_1, shared_2
  real(8) :: sym,asym,feq_common

  shared_1 = 0.5 + shared_0
  shared_2 = 2 * x

  !$omp target
  !$omp teams distribute parallel do simd private(tmp_1,tmp_2,tmp_3) &
  !$omp shared(shared_1,shared_2,curr_arr,next_arr,n,shared_0,send)
  do i_ct = 1, n
    tmp_1 = 13 + shared_1 + shared_2; ! 20
    tmp_2 = shared_0 + tmp_1 ! 21.5
    tmp_3 = 1.5
    next_arr(send(i_ct)) = tmp_1 + tmp_2 + tmp_3
  end do
  !$omp end target
end subroutine

program foo
  integer, parameter :: n = 11
  integer :: send(n)
  integer :: iterat, max_iterat = 1
  real(8) :: arr1(n, 0:1)
  real(8) :: res(n), exp(n)
  real(8) :: y = 1.5, x = 2.5
  integer :: i_ct, i, j, sum1

  do i = 1, n
    send(i) = i
    arr1(i, 0) = i
    arr1(i, 1) = 0
    exp(i) = 43.0
  end do

  !$omp target data map(tofrom:arr1), map(to:send)
  do iterat=1, max_iterat
    call subr1(arr1(:,0), arr1(:,1),send, n, y, x)
  end do
  !$omp end target data

  res = arr1(:, 1)

  !$omp target teams map(tofrom: sum1)
  !$omp distribute
  do i = 1, 10
    !$omp parallel do
    do j = 1, 10
      !$omp atomic update
      sum1 = sum1 + 1
    end do
  end do
  !$omp end target teams

  !$omp target teams map(tofrom: sum1)
  !$omp distribute
  do i = 1, 10
    !$omp parallel
    !$omp do
    do j = 1, 10
      !$omp atomic update
      sum1 = sum1 + 1
    end do
    !$omp end parallel
  end do
  !$omp end target teams

  !$omp target teams map(tofrom: sum1)
  !$omp distribute
  do i = 1, 10
    !$omp atomic update
    sum1 = sum1 + 1
  end do
  !$omp end target teams

  res(n) = sum1
  exp(n) = 210
  call check_double(res, exp, 10)
end program foo
