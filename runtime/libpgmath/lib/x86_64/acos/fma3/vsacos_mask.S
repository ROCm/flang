/* 
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */


#include "directives.h"

        ALN_QUAD
.L_sacos_zeromask: .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF
                   .long 0xFFFFFFFF


        .text
        ALN_FUNC
        .globl ENT(__fvs_acos_fma3_mask)
ENT(__fvs_acos_fma3_mask):

        subq $8, %rsp

        vptest  .L_sacos_zeromask(%rip), %xmm1
        je      .L_fvs_acos_fma3_done

        vandps  %xmm0,%xmm1,%xmm0
        CALL(ENT(__fvs_acos_fma3))

.L_fvs_acos_fma3_done:

        addq $8, %rsp
        ret

        ELF_FUNC(__fvs_acos_fma3_mask)
        ELF_SIZE(__fvs_acos_fma3_mask)


        .text
        ALN_FUNC
        .globl ENT(__fvs_acos_fma3_256_mask)
ENT(__fvs_acos_fma3_256_mask):

        subq $8, %rsp

        vptest  .L_sacos_zeromask(%rip), %ymm1
        je      .L_fvs_acos_fma3_256_done

        vandps  %ymm0,%ymm1,%ymm0
        CALL(ENT(__fvs_acos_fma3_256))

.L_fvs_acos_fma3_256_done:

        addq $8, %rsp
        ret

        ELF_FUNC(__fvs_acos_fma3_256_mask)
        ELF_SIZE(__fvs_acos_fma3_256_mask)

