!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! openmp_example test-suite
!
! Date of Modification: 11/11/2019
!
! @@name:	critical_atomic.1f
! @@type:	F-fixed
! @@compilable:	yes
! @@linkable:	no
! @@expect:	success

      SUBROUTINE CRITICAL_ATOMIC_EXAMPLE()
         integer,parameter::max_n_size=20
         integer(kind=8),save::plan_array(max_n_size)=0
         integer(kind=8):: N, fftw_plan
!$OMP ATOMIC READ
             fftw_plan=plan_array(N)
!$OMP CRITICAL
           if (plan_array(N)<=0) then
!$OMP ATOMIC WRITE
             plan_array(N)=fftw_plan
           else
!$OMP ATOMIC READ
             fftw_plan=plan_array(N)
          endif
!$OMP END CRITICAL
          fftw_plan=plan_array(N)

      END SUBROUTINE CRITICAL_ATOMIC_EXAMPLE
