! 
! Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
! See https://llvm.org/LICENSE.txt for license information.
! SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!
!
! Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
! Notified per clause 4(b) of the license.
! Last Modified: Oct 2020
!

#include "mmul_dir.h"

subroutine F90_matmul_cplx32_contvxm(dest, src1, src2, m_extent, n_extent)

  DESC_INT n_extent
  DESC_INT m_extent
  COMPLEX*32, dimension(m_extent) :: src1
  COMPLEX*32, dimension(m_extent,n_extent) :: src2
  COMPLEX*32, dimension(n_extent) :: dest

  DESC_INT n
  DESC_INT m

  do n=1,n_extent
    dest(n) = 0
    do m=1,m_extent
      dest(n) = dest(n) + src1(m) * src2(m,n)
    end do
 end do

end subroutine
