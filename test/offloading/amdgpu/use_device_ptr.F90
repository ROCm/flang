!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test case for USE_DEVICE_PTR clause.
! Date of creation: 29th April 2020
!
program main

   use omp_lib
   implicit none

   integer :: nx,x
   integer, parameter :: sp = kind(1.0_8)
   real(sp), target, allocatable :: arr1(:), crr1(:)
   real(sp), target, allocatable :: hst_arr1(:), hst_crr1(:)
   nx = 16
!!!!!!!! allocate arrays !!!!!!!!

   allocate(arr1(nx))
   allocate(crr1(nx))

   allocate(hst_arr1(nx))
   allocate(hst_crr1(nx))

!!!!!!!!! Initialise arrays !!!!!!!!

   arr1(:)=0.
   hst_arr1(:)=0.


   !$OMP TARGET DATA MAP(tofrom:arr1) MAP(from:crr1)

   !$OMP TARGET DATA USE_DEVICE_PTR(arr1)
   !$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO PRIVATE(x)
   do x=1,nx
      arr1(x)=(x-1)*2.0
    end do
   !$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
   !$OMP END TARGET DATA


   !$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO PRIVATE(x) &
   !$OMP DEPEND(IN:var) NOWAIT
         do x=1,nx
            crr1(x)=arr1(x)+1.0
         end do
   !$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO

   !$OMP TASKWAIT

   !$OMP END TARGET DATA

   do x=1,nx
      hst_arr1(x)=(x-1)*2.0
    end do
   do x=1,nx
      hst_crr1(x)=hst_arr1(x)+1.0
   end do
   call __check_double(hst_crr1, crr1, nx)
   call __check_double(hst_arr1, arr1, nx)
   deallocate(arr1)
   deallocate(crr1)
   deallocate(hst_arr1)
   deallocate(hst_crr1)
end program main
