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
!*
!* F2008 feature Parity intrinsic
!* Calculates the parity (i.e. the reduction using .xor.) of mask along
!* dimension dim.
!* AOCC test

      program test_parity

       parameter(NTEST=2)
       logical :: result(NTEST)
       logical :: expect(NTEST) = [ .true., .false. ]

       logical :: x(5) = [ .true., .true., .false.,.false., .true. ]
       logical :: y(3) = [ .true., .false.,.true. ]
       logical :: parity1, parity2
       parity1 = parity(x)
       parity2 = parity(y)

       print *,"! parity1"
       print *, parity1 ! T
       result(1) = parity1;

       print *,"! parity2"
       print *, parity2 ! F
       result(2) = parity2;

      call check(result,expect,NTEST)
      end program
