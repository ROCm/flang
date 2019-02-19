/*
 * Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

/*
 * Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for DNORM intrinsic
 *
 * Date of Modification: 21st February 2019
 *
 */

/* clang-format off */

/** \file
 * \brief F90  NORM2 intrinsics for real*4 type and real*8
 */

// AOCC Begin
#include "stdioInterf.h"
#include "fioMacros.h"
#include "matmul.h"
#include <math.h>

void ENTF90(NORM2_REAL4, norm2_real4)(char *dest_addr, char *s1_addr,
                                        F90_Desc *dest_desc,
                                        F90_Desc *s1_desc)
{

  __INT_T d_rank = F90_RANK_G(dest_desc);
  __INT_T s1_rank = F90_RANK_G(s1_desc);

  __REAL4_T *s1_base;
  __REAL4_T *dest_base;

  __INT_T s1_d1_lstride;
  __INT_T s1_d1_sstride;
  __INT_T s1_d1_lb;
  __INT_T s1_d1_ub;
  __INT_T s1_d1_soffset = 0;

  __INT_T s1_d2_lstride = 1;
  __INT_T s1_d2_sstride = 1;
  __INT_T s1_d2_lb = 0;
  __INT_T s1_d2_soffset = 0;

  __INT_T d_d1_lstride;
  __INT_T d_d1_sstride;
  __INT_T d_d1_lb;
  __INT_T d_d1_soffset = 0;

  __INT_T d_d2_lstride = 1;
  __INT_T d_d2_sstride = 1;
  __INT_T d_d2_lb = 0;
  __INT_T d_d2_soffset = 0;

  __INT_T i;

  // Step 1: Calculate the base, requires sizes of each dimension
  // Step 2: Get all the elements, calculate the value and store
  s1_d1_lstride = F90_DIM_LSTRIDE_G(s1_desc, 0);
  s1_d1_sstride = F90_DIM_SSTRIDE_G(s1_desc, 0);

  s1_d1_lb = F90_DIM_LBOUND_G(s1_desc, 0);
  s1_d1_ub = F90_DIM_UBOUND_G(s1_desc, 0);

  if (s1_d1_sstride != 1 || F90_DIM_SOFFSET_G(s1_desc, 0))
    s1_d1_soffset = F90_DIM_SOFFSET_G(s1_desc, 0) + s1_d1_sstride - s1_d1_lb;

  if (s1_rank == 2) {
    s1_d2_lstride = F90_DIM_LSTRIDE_G(s1_desc, 1);
    s1_d2_lb = F90_DIM_LBOUND_G(s1_desc, 1);
    s1_d2_sstride = F90_DIM_SSTRIDE_G(s1_desc, 1);
    if (s1_d2_sstride != 1 || F90_DIM_SOFFSET_G(s1_desc, 1))
      s1_d2_soffset = F90_DIM_SOFFSET_G(s1_desc, 1) + s1_d2_sstride - s1_d2_lb;
  }

  d_d1_lstride = F90_DIM_LSTRIDE_G(dest_desc, 0);
  d_d1_lb = F90_DIM_LBOUND_G(dest_desc, 0);
  d_d1_sstride = F90_DIM_SSTRIDE_G(dest_desc, 0);
  if (d_d1_sstride != 1 || F90_DIM_SOFFSET_G(dest_desc, 0))
    d_d1_soffset = F90_DIM_SOFFSET_G(dest_desc, 0) + d_d1_sstride - d_d1_lb;

  s1_base = (__REAL4_T *)s1_addr + F90_LBASE_G(s1_desc)  - 1;

  __INT_T d_lb;
  __INT_T d_lstride;
  for (i = 0; i < s1_rank; i++) {
    d_lb = F90_DIM_LBOUND_G(s1_desc, i);
    d_lstride = F90_DIM_LSTRIDE_G(s1_desc, i);
    s1_base += d_lb * d_lstride;
  }

  dest_base = (__REAL4_T *)dest_addr;
  __REAL4_T dnorm = 0;

  if (s1_rank == 1) {
    for(i = 0; i < s1_d1_ub; ++i) {
      dnorm += s1_base[i] * s1_base[i];
    }
    dnorm = sqrt(dnorm);
    *dest_base = dnorm;
    return;
  }

  __INT_T u_bound;
  __INT_T num_elements = 1;
  for (i = 0; i < s1_rank; ++i) {
    u_bound = F90_DIM_UBOUND_G(s1_desc, i);
    num_elements *= u_bound;
  }
  for(i = 0; i < num_elements; ++i) {
    dnorm += s1_base[i] * s1_base[i];
  }
  dnorm = sqrt(dnorm);
  *dest_base = dnorm;

}

/*
 * norm2 for real*8 type
 */
void ENTF90(NORM2_REAL8, norm2_real8)(char *dest_addr, char *s1_addr,
                                        F90_Desc *dest_desc,
                                        F90_Desc *s1_desc)
{

  __INT_T d_rank = F90_RANK_G(dest_desc);
  __INT_T s1_rank = F90_RANK_G(s1_desc);

  __REAL8_T *s1_base;
  __REAL8_T *dest_base;

  __INT_T s1_d1_lstride;
  __INT_T s1_d1_sstride;
  __INT_T s1_d1_lb;
  __INT_T s1_d1_ub;
  __INT_T s1_d1_soffset = 0;

  __INT_T s1_d2_lstride = 1;
  __INT_T s1_d2_sstride = 1;
  __INT_T s1_d2_lb = 0;
  __INT_T s1_d2_soffset = 0;

  __INT_T d_d1_lstride;
  __INT_T d_d1_sstride;
  __INT_T d_d1_lb;
  __INT_T d_d1_soffset = 0;

  __INT_T d_d2_lstride = 1;
  __INT_T d_d2_sstride = 1;
  __INT_T d_d2_lb = 0;
  __INT_T d_d2_soffset = 0;

  __INT_T i;

  s1_d1_lstride = F90_DIM_LSTRIDE_G(s1_desc, 0);
  s1_d1_sstride = F90_DIM_SSTRIDE_G(s1_desc, 0);

  s1_d1_lb = F90_DIM_LBOUND_G(s1_desc, 0);
  s1_d1_ub = F90_DIM_UBOUND_G(s1_desc, 0);

  if (s1_d1_sstride != 1 || F90_DIM_SOFFSET_G(s1_desc, 0))
    s1_d1_soffset = F90_DIM_SOFFSET_G(s1_desc, 0) + s1_d1_sstride - s1_d1_lb;

  if (s1_rank == 2) {
    s1_d2_lstride = F90_DIM_LSTRIDE_G(s1_desc, 1);
    s1_d2_lb = F90_DIM_LBOUND_G(s1_desc, 1);
    s1_d2_sstride = F90_DIM_SSTRIDE_G(s1_desc, 1);
    if (s1_d2_sstride != 1 || F90_DIM_SOFFSET_G(s1_desc, 1))
      s1_d2_soffset = F90_DIM_SOFFSET_G(s1_desc, 1) + s1_d2_sstride - s1_d2_lb;
  }

  d_d1_lstride = F90_DIM_LSTRIDE_G(dest_desc, 0);
  d_d1_lb = F90_DIM_LBOUND_G(dest_desc, 0);
  d_d1_sstride = F90_DIM_SSTRIDE_G(dest_desc, 0);
  if (d_d1_sstride != 1 || F90_DIM_SOFFSET_G(dest_desc, 0))
    d_d1_soffset = F90_DIM_SOFFSET_G(dest_desc, 0) + d_d1_sstride - d_d1_lb;

  s1_base = (__REAL8_T *)s1_addr + F90_LBASE_G(s1_desc)  - 1;

  __INT_T d_lb;
  __INT_T d_lstride;
  for (i = 0; i < s1_rank; i++) {
    d_lb = F90_DIM_LBOUND_G(s1_desc, i);
    d_lstride = F90_DIM_LSTRIDE_G(s1_desc, i);
    s1_base += d_lb * d_lstride;
  }

  dest_base = (__REAL8_T *)dest_addr;
  __REAL4_T dnorm = 0;

  if (s1_rank == 1) {
    for(i = 0; i < s1_d1_ub; ++i) {
      dnorm += s1_base[i] * s1_base[i];
    }
    dnorm = sqrt(dnorm);
    *dest_base = dnorm;
    return;
  }

  __INT_T u_bound;
  __INT_T num_elements = 1;
  for (i = 0; i < s1_rank; ++i) {
    u_bound = F90_DIM_UBOUND_G(s1_desc, i);
    num_elements *= u_bound;
  }
  for(i = 0; i < num_elements; ++i) {
    dnorm += s1_base[i] * s1_base[i];
  }
  dnorm = sqrt(dnorm);
  *dest_base = dnorm;
}

// AOCC End
