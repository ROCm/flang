; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=X64

define <8 x i32> @select00(i32 %a, <8 x i32> %b) nounwind {
; X86-LABEL: select00:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $255, {{[0-9]+}}(%esp)
; X86-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X86-NEXT:    je .LBB0_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    vmovaps %ymm0, %ymm1
; X86-NEXT:  .LBB0_2:
; X86-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: select00:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $255, %edi
; X64-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X64-NEXT:    je .LBB0_2
; X64-NEXT:  # %bb.1:
; X64-NEXT:    vmovaps %ymm0, %ymm1
; X64-NEXT:  .LBB0_2:
; X64-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %cmpres = icmp eq i32 %a, 255
  %selres = select i1 %cmpres, <8 x i32> zeroinitializer, <8 x i32> %b
  %res = xor <8 x i32> %b, %selres
  ret <8 x i32> %res
}

define <4 x i64> @select01(i32 %a, <4 x i64> %b) nounwind {
; X86-LABEL: select01:
; X86:       # %bb.0:
; X86-NEXT:    cmpl $255, {{[0-9]+}}(%esp)
; X86-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X86-NEXT:    je .LBB1_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    vmovaps %ymm0, %ymm1
; X86-NEXT:  .LBB1_2:
; X86-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: select01:
; X64:       # %bb.0:
; X64-NEXT:    cmpl $255, %edi
; X64-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X64-NEXT:    je .LBB1_2
; X64-NEXT:  # %bb.1:
; X64-NEXT:    vmovaps %ymm0, %ymm1
; X64-NEXT:  .LBB1_2:
; X64-NEXT:    vxorps %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %cmpres = icmp eq i32 %a, 255
  %selres = select i1 %cmpres, <4 x i64> zeroinitializer, <4 x i64> %b
  %res = xor <4 x i64> %b, %selres
  ret <4 x i64> %res
}

; If a X86ISD::BLENDV node appears before legalization, constant fold using (mask < 0) instead of like a vselect (mask != 0).
define void @fold_blendv_mask(<4 x i32> %a0) {
; X86-LABEL: fold_blendv_mask:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vmovaps {{.*#+}} ymm0 = [4294942349,7802,29242,15858,29361,4294951202,4294964216,4294941010]
; X86-NEXT:    vmovaps %ymm0, (%eax)
; X86-NEXT:    vzeroupper
; X86-NEXT:    retl
;
; X64-LABEL: fold_blendv_mask:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vmovaps {{.*#+}} ymm0 = [4294942349,7802,29242,15858,29361,4294951202,4294964216,4294941010]
; X64-NEXT:    vmovaps %ymm0, (%rax)
; X64-NEXT:    vzeroupper
; X64-NEXT:    retq
entry:
  br label %head

head:
  %v0 = insertelement <4 x i32> %a0, i32 44158, i64 0
  %v1 = insertelement <4 x i32> %v0, i32 54560, i64 1
  %v2 = insertelement <4 x i32> %v1, i32 45291, i64 2
  %v3 = insertelement <4 x i32> %v2, i32 18686, i64 3
  %isneg = icmp slt <4 x i32> %v3, zeroinitializer
  %or0 = select <4 x i1> %isneg, <4 x i32> <i32 26146, i32 -1257, i32 -2, i32 -3052>, <4 x i32> <i32 -24947, i32 7802, i32 29242, i32 15858>
  %or1 = shufflevector <4 x i32> %or0, <4 x i32> <i32 29361, i32 -16094, i32 -3080, i32 -26286>, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  br i1 undef, label %exit, label %head

exit:
  store <8 x i32> %or1, <8 x i32> addrspace(1)* undef, align 32
  ret void
}
