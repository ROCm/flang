; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unkown-unkown -mattr=+avx512bw -mattr=+avx512vl -mattr=+avx512fp16 | FileCheck %s

define void @test_mscatter_v16f16(half* %base, <16 x i32> %index, <16 x half> %val)
; CHECK-LABEL: test_mscatter_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpbroadcastq %rdi, %zmm3
; CHECK-NEXT:    vextracti64x4 $1, %zmm0, %ymm2
; CHECK-NEXT:    vpmovsxdq %ymm2, %zmm2
; CHECK-NEXT:    vpaddq %zmm3, %zmm2, %zmm4
; CHECK-NEXT:    vpaddq %zmm4, %zmm2, %zmm2
; CHECK-NEXT:    vpmovsxdq %ymm0, %zmm0
; CHECK-NEXT:    vpaddq %zmm3, %zmm0, %zmm3
; CHECK-NEXT:    vpaddq %zmm3, %zmm0, %zmm0
; CHECK-NEXT:    vmovq %xmm0, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpsrld $16, %xmm1, %xmm3
; CHECK-NEXT:    vpextrq $1, %xmm0, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vmovshdup {{.*#+}} xmm3 = xmm1[1,1,3,3]
; CHECK-NEXT:    vextracti128 $1, %ymm0, %xmm4
; CHECK-NEXT:    vmovq %xmm4, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vpsrlq $48, %xmm1, %xmm3
; CHECK-NEXT:    vpextrq $1, %xmm4, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vpermilpd {{.*#+}} xmm3 = xmm1[1,0]
; CHECK-NEXT:    vextracti32x4 $2, %zmm0, %xmm4
; CHECK-NEXT:    vmovq %xmm4, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm3 = xmm1[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrq $1, %xmm4, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vpermilps {{.*#+}} xmm3 = xmm1[3,3,3,3]
; CHECK-NEXT:    vextracti32x4 $3, %zmm0, %xmm0
; CHECK-NEXT:    vmovq %xmm0, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm3 = xmm1[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrq $1, %xmm0, %rax
; CHECK-NEXT:    vmovsh %xmm3, (%rax)
; CHECK-NEXT:    vextractf128 $1, %ymm1, %xmm0
; CHECK-NEXT:    vmovq %xmm2, %rax
; CHECK-NEXT:    vmovsh %xmm0, (%rax)
; CHECK-NEXT:    vpsrld $16, %xmm0, %xmm1
; CHECK-NEXT:    vpextrq $1, %xmm2, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; CHECK-NEXT:    vextracti128 $1, %ymm2, %xmm3
; CHECK-NEXT:    vmovq %xmm3, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpsrlq $48, %xmm0, %xmm1
; CHECK-NEXT:    vpextrq $1, %xmm3, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; CHECK-NEXT:    vextracti32x4 $2, %zmm2, %xmm3
; CHECK-NEXT:    vmovq %xmm3, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm1 = xmm0[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrq $1, %xmm3, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpermilps {{.*#+}} xmm1 = xmm0[3,3,3,3]
; CHECK-NEXT:    vextracti32x4 $3, %zmm2, %xmm2
; CHECK-NEXT:    vmovq %xmm2, %rax
; CHECK-NEXT:    vmovsh %xmm1, (%rax)
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrq $1, %xmm2, %rax
; CHECK-NEXT:    vmovsh %xmm0, (%rax)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
{
  %gep = getelementptr half, half* %base, <16 x i32> %index
  call void @llvm.masked.scatter.v16f16.v16p0f16(<16 x half> %val, <16 x half*> %gep, i32 4, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
  ret void
}
declare void @llvm.masked.scatter.v16f16.v16p0f16(<16 x half> , <16 x half*> , i32 , <16 x i1>)
