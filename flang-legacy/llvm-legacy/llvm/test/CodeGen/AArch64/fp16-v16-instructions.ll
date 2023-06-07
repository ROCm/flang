; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-eabi | FileCheck %s


define <16 x half> @sitofp_i32(<16 x i32> %a) #0 {
; CHECK-LABEL: sitofp_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v1.4s, v1.4s
; CHECK-NEXT:    scvtf v0.4s, v0.4s
; CHECK-NEXT:    scvtf v3.4s, v3.4s
; CHECK-NEXT:    scvtf v2.4s, v2.4s
; CHECK-NEXT:    fcvtn v4.4h, v1.4s
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    fcvtn v3.4h, v3.4s
; CHECK-NEXT:    fcvtn v1.4h, v2.4s
; CHECK-NEXT:    mov v0.d[1], v4.d[0]
; CHECK-NEXT:    mov v1.d[1], v3.d[0]
; CHECK-NEXT:    ret

  %1 = sitofp <16 x i32> %a to <16 x half>
  ret <16 x half> %1
}


define <16 x half> @sitofp_i64(<16 x i64> %a) #0 {
; CHECK-LABEL: sitofp_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v2.2d, v2.2d
; CHECK-NEXT:    scvtf v0.2d, v0.2d
; CHECK-NEXT:    scvtf v6.2d, v6.2d
; CHECK-NEXT:    scvtf v4.2d, v4.2d
; CHECK-NEXT:    scvtf v3.2d, v3.2d
; CHECK-NEXT:    scvtf v1.2d, v1.2d
; CHECK-NEXT:    scvtf v7.2d, v7.2d
; CHECK-NEXT:    scvtf v5.2d, v5.2d
; CHECK-NEXT:    fcvtn v2.2s, v2.2d
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    fcvtn v6.2s, v6.2d
; CHECK-NEXT:    fcvtn v4.2s, v4.2d
; CHECK-NEXT:    fcvtn2 v2.4s, v3.2d
; CHECK-NEXT:    fcvtn2 v0.4s, v1.2d
; CHECK-NEXT:    fcvtn2 v6.4s, v7.2d
; CHECK-NEXT:    fcvtn2 v4.4s, v5.2d
; CHECK-NEXT:    fcvtn v2.4h, v2.4s
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    fcvtn v3.4h, v6.4s
; CHECK-NEXT:    fcvtn v1.4h, v4.4s
; CHECK-NEXT:    mov v0.d[1], v2.d[0]
; CHECK-NEXT:    mov v1.d[1], v3.d[0]
; CHECK-NEXT:    ret




  %1 = sitofp <16 x i64> %a to <16 x half>
  ret <16 x half> %1
}


define <16 x half> @uitofp_i32(<16 x i32> %a) #0 {
; CHECK-LABEL: uitofp_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf v1.4s, v1.4s
; CHECK-NEXT:    ucvtf v0.4s, v0.4s
; CHECK-NEXT:    ucvtf v3.4s, v3.4s
; CHECK-NEXT:    ucvtf v2.4s, v2.4s
; CHECK-NEXT:    fcvtn v4.4h, v1.4s
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    fcvtn v3.4h, v3.4s
; CHECK-NEXT:    fcvtn v1.4h, v2.4s
; CHECK-NEXT:    mov v0.d[1], v4.d[0]
; CHECK-NEXT:    mov v1.d[1], v3.d[0]
; CHECK-NEXT:    ret

  %1 = uitofp <16 x i32> %a to <16 x half>
  ret <16 x half> %1
}


define <16 x half> @uitofp_i64(<16 x i64> %a) #0 {
; CHECK-LABEL: uitofp_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf v2.2d, v2.2d
; CHECK-NEXT:    ucvtf v0.2d, v0.2d
; CHECK-NEXT:    ucvtf v6.2d, v6.2d
; CHECK-NEXT:    ucvtf v4.2d, v4.2d
; CHECK-NEXT:    ucvtf v3.2d, v3.2d
; CHECK-NEXT:    ucvtf v1.2d, v1.2d
; CHECK-NEXT:    ucvtf v7.2d, v7.2d
; CHECK-NEXT:    ucvtf v5.2d, v5.2d
; CHECK-NEXT:    fcvtn v2.2s, v2.2d
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    fcvtn v6.2s, v6.2d
; CHECK-NEXT:    fcvtn v4.2s, v4.2d
; CHECK-NEXT:    fcvtn2 v2.4s, v3.2d
; CHECK-NEXT:    fcvtn2 v0.4s, v1.2d
; CHECK-NEXT:    fcvtn2 v6.4s, v7.2d
; CHECK-NEXT:    fcvtn2 v4.4s, v5.2d
; CHECK-NEXT:    fcvtn v2.4h, v2.4s
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    fcvtn v3.4h, v6.4s
; CHECK-NEXT:    fcvtn v1.4h, v4.4s
; CHECK-NEXT:    mov v0.d[1], v2.d[0]
; CHECK-NEXT:    mov v1.d[1], v3.d[0]
; CHECK-NEXT:    ret




  %1 = uitofp <16 x i64> %a to <16 x half>
  ret <16 x half> %1
}

attributes #0 = { nounwind }
