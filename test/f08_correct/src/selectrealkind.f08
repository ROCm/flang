!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!* Support for radix in selected_real_kind intrisic intrinsics.

!* F2008 feature Selected_real_kind intrinsic with 3rd parameter radix
!* AOCC test

      program real_kinds
      interface
        subroutine copy_str_to_result( str, result)
          integer :: result(:)
          character(len=*) :: str
        end subroutine
      end interface

       parameter(NTEST=10)
       integer :: result(NTEST)
       integer :: expect(NTEST) = (/  &
         !select_rkind1
             4,         &
         !select_rkind2
             8,         &
         !select_rkind3
             -2,        &
         !select_rkind4
             8,         &
         !select_rkind5
             8,         &
         !select_rkind6
             -3,        &
         !select_rkind7
             -2,        &
         !select_rkind8
             -5,        &
         !select_rkind7
             -3,        &
         !select_rkind7
             -1         &
         /)
       integer,parameter :: select_rkind1 = selected_real_kind(6)
       integer,parameter :: select_rkind2 = selected_real_kind(10,100)
       integer,parameter :: select_rkind3 = selected_real_kind(r=400)
       integer,parameter :: select_rkind4 = selected_real_kind(4,70,2)
       integer :: select_rkind5 = SELECTED_REAL_KIND(6, 70, 2)
       integer :: select_rkind6 = SELECTED_REAL_KIND(45, 5000, 2)
       integer :: select_rkind7 = SELECTED_REAL_KIND(8, 6000, 2)
       integer :: select_rkind8 = SELECTED_REAL_KIND(60,600, 10)
       integer :: select_rkind9 = selected_real_kind(16,400)
       integer :: select_rkind10 = selected_real_kind(34)
        print *,"! select_rkind1"
        print *,select_rkind1;
        result(1) = select_rkind1
        print *,"! select_rkind2"
        print *,select_rkind2;
        result(2) = select_rkind2
        print *,"! select_rkind3"
        print *,select_rkind3;
        result(3) = select_rkind3
        print *,"! select_rkind4"
        print *,select_rkind4;
        result(4) = select_rkind4
        print *,"! select_rkind5"
        print *,select_rkind5;
        result(5) = select_rkind5
        print *,"! select_rkind6"
        print *,select_rkind6;
        result(6) = select_rkind6
        print *,"! select_rkind7"
        print *,select_rkind7;
        result(7) = select_rkind7
        print *,"! select_rkind8"
        print *,select_rkind8;
        result(8) = select_rkind8
        print *,"! select_rkind9"
        print *,select_rkind9;
        result(9) = select_rkind9
        print *,"! select_rkind10"
        print *,select_rkind10;
        result(10) = select_rkind10
      call check(result,expect,NTEST)
      end program real_kinds

