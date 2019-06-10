!* Copyright (c) 1999, NVIDIA CORPORATION.  All rights reserved.
!*
!* Licensed under the Apache License, Version 2.0 (the "License");
!* you may not use this file except in compliance with the License.
!* You may obtain a copy of the License at
!*
!*     http://www.apache.org/licenses/LICENSE-2.0
!*
!* Unless required by applicable law or agreed to in writing, software
!* distributed under the License is distributed on an "AS IS" BASIS,
!* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!* See the License for the specific language governing permissions and
!* limitations under the License.
!*
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

       parameter(NTEST=8)
       integer :: result(NTEST)
       integer :: expect(NTEST) = (/  &
         !select_rkind1
             4,         &
         !select_rkind2
             8,         &
         !select_rkind3
             -4,        &
         !select_rkind4
             8,         &
         !select_rkind5
             8,         &
         !select_rkind6
             -3,        &
         !select_rkind7
             -4,        &
         !select_rkind8
             -5         &
         /)
       integer,parameter :: select_rkind1 = selected_real_kind(6)
       integer,parameter :: select_rkind2 = selected_real_kind(10,100)
       integer,parameter :: select_rkind3 = selected_real_kind(r=400)
       integer,parameter :: select_rkind4 = selected_real_kind(4,70,2)
       integer :: select_rkind5 = SELECTED_REAL_KIND(6, 70, 2)
       integer :: select_rkind6 = SELECTED_REAL_KIND(45, 5000, 2)
       integer :: select_rkind7 = SELECTED_REAL_KIND(8, 6000, 2)
       integer :: select_rkind8 = SELECTED_REAL_KIND(60,600, 10)
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

      call check(result,expect,NTEST)
      end program real_kinds

