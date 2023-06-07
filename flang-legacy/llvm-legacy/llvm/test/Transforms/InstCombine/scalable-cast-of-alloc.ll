; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

define void @fixed_array16i32_to_scalable4i32(<vscale x 4 x i32>* %out) {
; CHECK-LABEL: @fixed_array16i32_to_scalable4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[CAST:%.*]] = bitcast [16 x i32]* [[TMP]] to <vscale x 4 x i32>*
; CHECK-NEXT:    store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* [[CAST]], align 16
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* [[CAST]], align 16
; CHECK-NEXT:    store <vscale x 4 x i32> [[RELOAD]], <vscale x 4 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca [16 x i32], align 16
  %cast = bitcast [16 x i32]* %tmp to <vscale x 4 x i32>*
  store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* %cast, align 16
  %reload = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %cast, align 16
  store <vscale x 4 x i32> %reload, <vscale x 4 x i32>* %out, align 16
  ret void
}

define void @scalable4i32_to_fixed16i32(<16 x i32>* %out) {
; CHECK-LABEL: @scalable4i32_to_fixed16i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <vscale x 4 x i32>, align 64
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <vscale x 4 x i32>* [[TMP]] to <16 x i32>*
; CHECK-NEXT:    store <16 x i32> zeroinitializer, <16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <16 x i32>, <16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    store <16 x i32> [[RELOAD]], <16 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <vscale x 4 x i32>, align 16
  %cast = bitcast <vscale x 4 x i32>* %tmp to <16 x i32>*
  store <16 x i32> zeroinitializer, <16 x i32>* %cast, align 16
  %reload = load volatile <16 x i32>, <16 x i32>* %cast, align 16
  store <16 x i32> %reload, <16 x i32>* %out, align 16
  ret void
}

define void @fixed16i32_to_scalable4i32(<vscale x 4 x i32>* %out) {
; CHECK-LABEL: @fixed16i32_to_scalable4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <16 x i32>, align 16
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <16 x i32>* [[TMP]] to <vscale x 4 x i32>*
; CHECK-NEXT:    store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* [[CAST]], align 16
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* [[CAST]], align 16
; CHECK-NEXT:    store <vscale x 4 x i32> [[RELOAD]], <vscale x 4 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <16 x i32>, align 16
  %cast = bitcast <16 x i32>* %tmp to <vscale x 4 x i32>*
  store volatile <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32>* %cast, align 16
  %reload = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %cast, align 16
  store <vscale x 4 x i32> %reload, <vscale x 4 x i32>* %out, align 16
  ret void
}

define void @scalable16i32_to_fixed16i32(<16 x i32>* %out) {
; CHECK-LABEL: @scalable16i32_to_fixed16i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <vscale x 16 x i32>, align 64
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <vscale x 16 x i32>* [[TMP]] to <16 x i32>*
; CHECK-NEXT:    store volatile <16 x i32> zeroinitializer, <16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <16 x i32>, <16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    store <16 x i32> [[RELOAD]], <16 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <vscale x 16 x i32>, align 16
  %cast = bitcast <vscale x 16 x i32>* %tmp to <16 x i32>*
  store volatile <16 x i32> zeroinitializer, <16 x i32>* %cast, align 16
  %reload = load volatile <16 x i32>, <16 x i32>* %cast, align 16
  store <16 x i32> %reload, <16 x i32>* %out, align 16
  ret void
}

define void @scalable32i32_to_scalable16i32(<vscale x 16 x i32>* %out) {
; CHECK-LABEL: @scalable32i32_to_scalable16i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <vscale x 32 x i32>, align 64
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <vscale x 32 x i32>* [[TMP]] to <vscale x 16 x i32>*
; CHECK-NEXT:    store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    store <vscale x 16 x i32> [[RELOAD]], <vscale x 16 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <vscale x 32 x i32>, align 16
  %cast = bitcast <vscale x 32 x i32>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  ret void
}

define void @scalable32i16_to_scalable16i32(<vscale x 16 x i32>* %out) {
; CHECK-LABEL: @scalable32i16_to_scalable16i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <vscale x 16 x i32>, align 64
; CHECK-NEXT:    store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* [[TMP]], align 64
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* [[TMP]], align 64
; CHECK-NEXT:    store <vscale x 16 x i32> [[RELOAD]], <vscale x 16 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <vscale x 32 x i16>, align 16
  %cast = bitcast <vscale x 32 x i16>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  ret void
}

define void @scalable32i16_to_scalable16i32_multiuse(<vscale x 16 x i32>* %out, <vscale x 32 x i16>* %out2) {
; CHECK-LABEL: @scalable32i16_to_scalable16i32_multiuse(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = alloca <vscale x 32 x i16>, align 64
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <vscale x 32 x i16>* [[TMP]] to <vscale x 16 x i32>*
; CHECK-NEXT:    store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    [[RELOAD:%.*]] = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* [[CAST]], align 64
; CHECK-NEXT:    store <vscale x 16 x i32> [[RELOAD]], <vscale x 16 x i32>* [[OUT:%.*]], align 16
; CHECK-NEXT:    [[RELOAD2:%.*]] = load volatile <vscale x 32 x i16>, <vscale x 32 x i16>* [[TMP]], align 64
; CHECK-NEXT:    store <vscale x 32 x i16> [[RELOAD2]], <vscale x 32 x i16>* [[OUT2:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %tmp = alloca <vscale x 32 x i16>, align 16
  %cast = bitcast <vscale x 32 x i16>* %tmp to <vscale x 16 x i32>*
  store volatile <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32>* %cast, align 16
  %reload = load volatile <vscale x 16 x i32>, <vscale x 16 x i32>* %cast, align 16
  store <vscale x 16 x i32> %reload, <vscale x 16 x i32>* %out, align 16
  %reload2 = load volatile <vscale x 32 x i16>, <vscale x 32 x i16>* %tmp, align 16
  store <vscale x 32 x i16> %reload2, <vscale x 32 x i16>* %out2, align 16
  ret void
}
