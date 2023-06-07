; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu < %s -o -| FileCheck %s

define void @matrix_mul_unsigned(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_unsigned:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    and w8, w3, #0xffff
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    dup v0.4h, w8
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:  .LBB0_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x9, x2, w0, uxtw #1
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    ldp d1, d2, [x9]
; CHECK-NEXT:    add x9, x1, w0, uxtw #2
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    umull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    umull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q2, [x9]
; CHECK-NEXT:    b.ne .LBB0_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = zext i16 %val to i32
  %wide.trip.count = zext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = zext i32 %4 to i64
  %6 = getelementptr inbounds i16, i16* %A, i64 %5
  %7 = bitcast i16* %6 to <4 x i16>*
  %wide.load = load <4 x i16>, <4 x i16>* %7, align 2
  %8 = getelementptr inbounds i16, i16* %6, i64 4
  %9 = bitcast i16* %8 to <4 x i16>*
  %wide.load30 = load <4 x i16>, <4 x i16>* %9, align 2
  %10 = zext <4 x i16> %wide.load to <4 x i32>
  %11 = zext <4 x i16> %wide.load30 to <4 x i32>
  %12 = mul nuw nsw <4 x i32> %broadcast.splat, %10
  %13 = mul nuw nsw <4 x i32> %broadcast.splat32, %11
  %14 = getelementptr inbounds i32, i32* %C, i64 %5
  %15 = bitcast i32* %14 to <4 x i32>*
  store <4 x i32> %12, <4 x i32>* %15, align 4
  %16 = getelementptr inbounds i32, i32* %14, i64 4
  %17 = bitcast i32* %16 to <4 x i32>*
  store <4 x i32> %13, <4 x i32>* %17, align 4
  %index.next = add i64 %index, 8
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}

define void @matrix_mul_signed(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_signed:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    sxth w8, w3
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    dup v0.4h, w8
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:  .LBB1_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x9, x2, w0, sxtw #1
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    ldp d1, d2, [x9]
; CHECK-NEXT:    add x9, x1, w0, sxtw #2
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    smull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    smull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q2, [x9]
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = sext i16 %val to i32
  %wide.trip.count = sext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i16, i16* %A, i64 %5
  %7 = bitcast i16* %6 to <4 x i16>*
  %wide.load = load <4 x i16>, <4 x i16>* %7, align 2
  %8 = getelementptr inbounds i16, i16* %6, i64 4
  %9 = bitcast i16* %8 to <4 x i16>*
  %wide.load30 = load <4 x i16>, <4 x i16>* %9, align 2
  %10 = sext <4 x i16> %wide.load to <4 x i32>
  %11 = sext <4 x i16> %wide.load30 to <4 x i32>
  %12 = mul nsw <4 x i32> %broadcast.splat, %10
  %13 = mul nsw <4 x i32> %broadcast.splat32, %11
  %14 = getelementptr inbounds i32, i32* %C, i64 %5
  %15 = bitcast i32* %14 to <4 x i32>*
  store <4 x i32> %12, <4 x i32>* %15, align 4
  %16 = getelementptr inbounds i32, i32* %14, i64 4
  %17 = bitcast i32* %16 to <4 x i32>*
  store <4 x i32> %13, <4 x i32>* %17, align 4
  %index.next = add i64 %index, 8
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}


define void @matrix_mul_double_shuffle(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_double_shuffle:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    and w8, w3, #0xffff
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    dup v0.4h, w8
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0 def $x0
; CHECK-NEXT:  .LBB2_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh w9, [x2], #16
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    dup v1.4h, w9
; CHECK-NEXT:    ubfiz x9, x0, #2, #32
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    umull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    str q1, [x1, x9]
; CHECK-NEXT:    b.ne .LBB2_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = zext i16 %val to i32
  %wide.trip.count = zext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %g = getelementptr inbounds i16, i16* %A, i64 %index
  %val1 = load i16, i16* %g
  %splat.input.ext = zext i16 %val1 to i32
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %splat.input.ext, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> %broadcast.splat, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = zext i32 %4 to i64
  %6 = mul nuw nsw <4 x i32> %broadcast.splat, %broadcast.splat32
  %7 = getelementptr inbounds i32, i32* %C, i64 %5
  %8 = bitcast i32* %7 to <4 x i32>*
  store <4 x i32> %6, <4 x i32>* %8, align 4
  %index.next = add i64 %index, 8
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}


define void @larger_smull(i16* nocapture noundef readonly %x, i16 noundef %y, i32* noalias nocapture noundef writeonly %s, i32 noundef %n) {
; CHECK-LABEL: larger_smull:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w3, #1
; CHECK-NEXT:    b.lt .LBB3_8
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    sxth w8, w1
; CHECK-NEXT:    mov w9, w3
; CHECK-NEXT:    cmp w3, #15
; CHECK-NEXT:    b.hi .LBB3_3
; CHECK-NEXT:  // %bb.2:
; CHECK-NEXT:    mov x10, xzr
; CHECK-NEXT:    b .LBB3_6
; CHECK-NEXT:  .LBB3_3: // %vector.ph
; CHECK-NEXT:    and x10, x9, #0xfffffff0
; CHECK-NEXT:    add x11, x2, #32
; CHECK-NEXT:    add x12, x0, #16
; CHECK-NEXT:    mov x13, x10
; CHECK-NEXT:    dup v0.8h, w8
; CHECK-NEXT:  .LBB3_4: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp q1, q2, [x12, #-16]
; CHECK-NEXT:    subs x13, x13, #16
; CHECK-NEXT:    add x12, x12, #32
; CHECK-NEXT:    smull2 v3.4s, v0.8h, v1.8h
; CHECK-NEXT:    smull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    smull2 v4.4s, v0.8h, v2.8h
; CHECK-NEXT:    smull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q3, [x11, #-32]
; CHECK-NEXT:    stp q2, q4, [x11], #64
; CHECK-NEXT:    b.ne .LBB3_4
; CHECK-NEXT:  // %bb.5: // %middle.block
; CHECK-NEXT:    cmp x10, x9
; CHECK-NEXT:    b.eq .LBB3_8
; CHECK-NEXT:  .LBB3_6: // %for.body.preheader1
; CHECK-NEXT:    sub x9, x9, x10
; CHECK-NEXT:    add x11, x2, x10, lsl #2
; CHECK-NEXT:    add x10, x0, x10, lsl #1
; CHECK-NEXT:  .LBB3_7: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrsh w12, [x10], #2
; CHECK-NEXT:    subs x9, x9, #1
; CHECK-NEXT:    mul w12, w12, w8
; CHECK-NEXT:    str w12, [x11], #4
; CHECK-NEXT:    b.ne .LBB3_7
; CHECK-NEXT:  .LBB3_8: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %conv1 = sext i16 %y to i32
  %cmp8 = icmp sgt i32 %n, 0
  br i1 %cmp8, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %min.iters.check = icmp ult i32 %n, 16
  br i1 %min.iters.check, label %for.body.preheader14, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %wide.trip.count, 4294967280
  %broadcast.splatinsert = insertelement <8 x i32> poison, i32 %conv1, i64 0
  %broadcast.splat = shufflevector <8 x i32> %broadcast.splatinsert, <8 x i32> poison, <8 x i32> zeroinitializer
  %broadcast.splatinsert12 = insertelement <8 x i32> poison, i32 %conv1, i64 0
  %broadcast.splat13 = shufflevector <8 x i32> %broadcast.splatinsert12, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i16, i16* %x, i64 %index
  %1 = bitcast i16* %0 to <8 x i16>*
  %wide.load = load <8 x i16>, <8 x i16>* %1, align 2
  %2 = getelementptr inbounds i16, i16* %0, i64 8
  %3 = bitcast i16* %2 to <8 x i16>*
  %wide.load11 = load <8 x i16>, <8 x i16>* %3, align 2
  %4 = sext <8 x i16> %wide.load to <8 x i32>
  %5 = sext <8 x i16> %wide.load11 to <8 x i32>
  %6 = mul nsw <8 x i32> %broadcast.splat, %4
  %7 = mul nsw <8 x i32> %broadcast.splat13, %5
  %8 = getelementptr inbounds i32, i32* %s, i64 %index
  %9 = bitcast i32* %8 to <8 x i32>*
  store <8 x i32> %6, <8 x i32>* %9, align 4
  %10 = getelementptr inbounds i32, i32* %8, i64 8
  %11 = bitcast i32* %10 to <8 x i32>*
  store <8 x i32> %7, <8 x i32>* %11, align 4
  %index.next = add nuw i64 %index, 16
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader14

for.body.preheader14:                             ; preds = %for.body.preheader, %middle.block
  %indvars.iv.ph = phi i64 [ 0, %for.body.preheader ], [ %n.vec, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader14, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %indvars.iv.ph, %for.body.preheader14 ]
  %arrayidx = getelementptr inbounds i16, i16* %x, i64 %indvars.iv
  %13 = load i16, i16* %arrayidx, align 2
  %conv = sext i16 %13 to i32
  %mul = mul nsw i32 %conv, %conv1
  %arrayidx3 = getelementptr inbounds i32, i32* %s, i64 %indvars.iv
  store i32 %mul, i32* %arrayidx3, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}


define void @larger_umull(i16* nocapture noundef readonly %x, i16 noundef %y, i32* noalias nocapture noundef writeonly %s, i32 noundef %n) {
; CHECK-LABEL: larger_umull:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w3, #1
; CHECK-NEXT:    b.lt .LBB4_8
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    and w8, w1, #0xffff
; CHECK-NEXT:    mov w9, w3
; CHECK-NEXT:    cmp w3, #15
; CHECK-NEXT:    b.hi .LBB4_3
; CHECK-NEXT:  // %bb.2:
; CHECK-NEXT:    mov x10, xzr
; CHECK-NEXT:    b .LBB4_6
; CHECK-NEXT:  .LBB4_3: // %vector.ph
; CHECK-NEXT:    and x10, x9, #0xfffffff0
; CHECK-NEXT:    add x11, x2, #32
; CHECK-NEXT:    add x12, x0, #16
; CHECK-NEXT:    mov x13, x10
; CHECK-NEXT:    dup v0.8h, w8
; CHECK-NEXT:  .LBB4_4: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp q1, q2, [x12, #-16]
; CHECK-NEXT:    subs x13, x13, #16
; CHECK-NEXT:    add x12, x12, #32
; CHECK-NEXT:    umull2 v3.4s, v0.8h, v1.8h
; CHECK-NEXT:    umull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    umull2 v4.4s, v0.8h, v2.8h
; CHECK-NEXT:    umull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q3, [x11, #-32]
; CHECK-NEXT:    stp q2, q4, [x11], #64
; CHECK-NEXT:    b.ne .LBB4_4
; CHECK-NEXT:  // %bb.5: // %middle.block
; CHECK-NEXT:    cmp x10, x9
; CHECK-NEXT:    b.eq .LBB4_8
; CHECK-NEXT:  .LBB4_6: // %for.body.preheader1
; CHECK-NEXT:    sub x9, x9, x10
; CHECK-NEXT:    add x11, x2, x10, lsl #2
; CHECK-NEXT:    add x10, x0, x10, lsl #1
; CHECK-NEXT:  .LBB4_7: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh w12, [x10], #2
; CHECK-NEXT:    subs x9, x9, #1
; CHECK-NEXT:    mul w12, w12, w8
; CHECK-NEXT:    str w12, [x11], #4
; CHECK-NEXT:    b.ne .LBB4_7
; CHECK-NEXT:  .LBB4_8: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %conv1 = zext i16 %y to i32
  %cmp8 = icmp sgt i32 %n, 0
  br i1 %cmp8, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %min.iters.check = icmp ult i32 %n, 16
  br i1 %min.iters.check, label %for.body.preheader14, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %wide.trip.count, 4294967280
  %broadcast.splatinsert = insertelement <8 x i32> poison, i32 %conv1, i64 0
  %broadcast.splat = shufflevector <8 x i32> %broadcast.splatinsert, <8 x i32> poison, <8 x i32> zeroinitializer
  %broadcast.splatinsert12 = insertelement <8 x i32> poison, i32 %conv1, i64 0
  %broadcast.splat13 = shufflevector <8 x i32> %broadcast.splatinsert12, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i16, i16* %x, i64 %index
  %1 = bitcast i16* %0 to <8 x i16>*
  %wide.load = load <8 x i16>, <8 x i16>* %1, align 2
  %2 = getelementptr inbounds i16, i16* %0, i64 8
  %3 = bitcast i16* %2 to <8 x i16>*
  %wide.load11 = load <8 x i16>, <8 x i16>* %3, align 2
  %4 = zext <8 x i16> %wide.load to <8 x i32>
  %5 = zext <8 x i16> %wide.load11 to <8 x i32>
  %6 = mul nuw <8 x i32> %broadcast.splat, %4
  %7 = mul nuw <8 x i32> %broadcast.splat13, %5
  %8 = getelementptr inbounds i32, i32* %s, i64 %index
  %9 = bitcast i32* %8 to <8 x i32>*
  store <8 x i32> %6, <8 x i32>* %9, align 4
  %10 = getelementptr inbounds i32, i32* %8, i64 8
  %11 = bitcast i32* %10 to <8 x i32>*
  store <8 x i32> %7, <8 x i32>* %11, align 4
  %index.next = add nuw i64 %index, 16
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader14

for.body.preheader14:                             ; preds = %for.body.preheader, %middle.block
  %indvars.iv.ph = phi i64 [ 0, %for.body.preheader ], [ %n.vec, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader14, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %indvars.iv.ph, %for.body.preheader14 ]
  %arrayidx = getelementptr inbounds i16, i16* %x, i64 %indvars.iv
  %13 = load i16, i16* %arrayidx, align 2
  %conv = zext i16 %13 to i32
  %mul = mul nuw i32 %conv, %conv1
  %arrayidx3 = getelementptr inbounds i32, i32* %s, i64 %indvars.iv
  store i32 %mul, i32* %arrayidx3, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}


define i16 @red_mla_dup_ext_u8_s8_s16(i8* noalias nocapture noundef readonly %A, i8 noundef %B, i32 noundef %n) {
; CHECK-LABEL: red_mla_dup_ext_u8_s8_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cbz w2, .LBB5_3
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    sxtb w9, w1
; CHECK-NEXT:    mov w10, w2
; CHECK-NEXT:    cmp w2, #15
; CHECK-NEXT:    b.hi .LBB5_4
; CHECK-NEXT:  // %bb.2:
; CHECK-NEXT:    mov x11, xzr
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    b .LBB5_7
; CHECK-NEXT:  .LBB5_3:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB5_4: // %vector.ph
; CHECK-NEXT:    dup v2.8b, w9
; CHECK-NEXT:    and x11, x10, #0xfffffff0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    add x8, x0, #8
; CHECK-NEXT:    movi v1.2d, #0000000000000000
; CHECK-NEXT:    mov x12, x11
; CHECK-NEXT:    sshll v2.8h, v2.8b, #0
; CHECK-NEXT:  .LBB5_5: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp d3, d4, [x8, #-8]
; CHECK-NEXT:    subs x12, x12, #16
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    ushll v3.8h, v3.8b, #0
; CHECK-NEXT:    ushll v4.8h, v4.8b, #0
; CHECK-NEXT:    mla v0.8h, v2.8h, v3.8h
; CHECK-NEXT:    mla v1.8h, v2.8h, v4.8h
; CHECK-NEXT:    b.ne .LBB5_5
; CHECK-NEXT:  // %bb.6: // %middle.block
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    cmp x11, x10
; CHECK-NEXT:    addv h0, v0.8h
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    b.eq .LBB5_9
; CHECK-NEXT:  .LBB5_7: // %for.body.preheader1
; CHECK-NEXT:    sub x10, x10, x11
; CHECK-NEXT:    add x11, x0, x11
; CHECK-NEXT:  .LBB5_8: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrb w12, [x11], #1
; CHECK-NEXT:    subs x10, x10, #1
; CHECK-NEXT:    madd w8, w12, w9, w8
; CHECK-NEXT:    b.ne .LBB5_8
; CHECK-NEXT:  .LBB5_9: // %for.cond.cleanup
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
entry:
  %conv2 = sext i8 %B to i16
  %cmp10.not = icmp eq i32 %n, 0
  br i1 %cmp10.not, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %min.iters.check = icmp ult i32 %n, 16
  br i1 %min.iters.check, label %for.body.preheader17, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %wide.trip.count, 4294967280
  %broadcast.splatinsert = insertelement <8 x i16> poison, i16 %conv2, i64 0
  %broadcast.splat = shufflevector <8 x i16> %broadcast.splatinsert, <8 x i16> poison, <8 x i32> zeroinitializer
  %broadcast.splatinsert15 = insertelement <8 x i16> poison, i16 %conv2, i64 0
  %broadcast.splat16 = shufflevector <8 x i16> %broadcast.splatinsert15, <8 x i16> poison, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <8 x i16> [ zeroinitializer, %vector.ph ], [ %8, %vector.body ]
  %vec.phi13 = phi <8 x i16> [ zeroinitializer, %vector.ph ], [ %9, %vector.body ]
  %0 = getelementptr inbounds i8, i8* %A, i64 %index
  %1 = bitcast i8* %0 to <8 x i8>*
  %wide.load = load <8 x i8>, <8 x i8>* %1, align 1
  %2 = getelementptr inbounds i8, i8* %0, i64 8
  %3 = bitcast i8* %2 to <8 x i8>*
  %wide.load14 = load <8 x i8>, <8 x i8>* %3, align 1
  %4 = zext <8 x i8> %wide.load to <8 x i16>
  %5 = zext <8 x i8> %wide.load14 to <8 x i16>
  %6 = mul nsw <8 x i16> %broadcast.splat, %4
  %7 = mul nsw <8 x i16> %broadcast.splat16, %5
  %8 = add <8 x i16> %6, %vec.phi
  %9 = add <8 x i16> %7, %vec.phi13
  %index.next = add nuw i64 %index, 16
  %10 = icmp eq i64 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <8 x i16> %9, %8
  %11 = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %bin.rdx)
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader17

for.body.preheader17:                             ; preds = %for.body.preheader, %middle.block
  %indvars.iv.ph = phi i64 [ 0, %for.body.preheader ], [ %n.vec, %middle.block ]
  %s.011.ph = phi i16 [ 0, %for.body.preheader ], [ %11, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  %s.0.lcssa = phi i16 [ 0, %entry ], [ %11, %middle.block ], [ %add, %for.body ]
  ret i16 %s.0.lcssa

for.body:                                         ; preds = %for.body.preheader17, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %indvars.iv.ph, %for.body.preheader17 ]
  %s.011 = phi i16 [ %add, %for.body ], [ %s.011.ph, %for.body.preheader17 ]
  %arrayidx = getelementptr inbounds i8, i8* %A, i64 %indvars.iv
  %12 = load i8, i8* %arrayidx, align 1
  %13 = zext i8 %12 to i16
  %mul = mul nsw i16 %13, %conv2
  %add = add i16 %mul, %s.011
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @sink_v2z64_1(i32 *%p, i32 *%d, i64 %n, <2 x i32> %a) {
; CHECK-LABEL: sink_v2z64_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:  .LBB6_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    add x8, x8, #8
; CHECK-NEXT:    subs x2, x2, #8
; CHECK-NEXT:    umull v1.2d, v1.2s, v0.s[1]
; CHECK-NEXT:    shrn v1.2s, v1.2d, #15
; CHECK-NEXT:    str d1, [x0], #32
; CHECK-NEXT:    b.ne .LBB6_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  %ext = zext <2 x i32> %a to <2 x i64>
  %broadcast.splat = shufflevector <2 x i64> %ext, <2 x i64> poison, <2 x i32> <i32 1, i32 1>
  br label %loop

loop:
  %index = phi i64 [ 0, %entry ], [ %index.next, %loop ]
  %g = getelementptr inbounds i32, i32 *%p, i64 %index
  %gb = bitcast i32* %g to <2 x i32>*
  %l = load <2 x i32>, <2 x i32> *%gb, align 4
  %e = zext <2 x i32> %l to <2 x i64>
  %m = mul <2 x i64> %e, %broadcast.splat
  %s = ashr <2 x i64> %m, <i64 15, i64 15>
  %t = trunc <2 x i64> %s to <2 x i32>
  %h = getelementptr inbounds i32, i32 *%d, i64 %index
  %hb = bitcast i32* %g to <2 x i32>*
  store <2 x i32> %t, <2 x i32> *%hb, align 4
  %index.next = add nuw i64 %index, 8
  %c = icmp eq i64 %index.next, %n
  br i1 %c, label %exit, label %loop

exit:
  ret void
}

define void @sink_v4i64_1(i32 *%p, i32 *%d, i64 %n, <2 x i32> %a) {
; CHECK-LABEL: sink_v4i64_1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:  .LBB7_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    add x8, x8, #8
; CHECK-NEXT:    subs x2, x2, #8
; CHECK-NEXT:    smull v2.2d, v1.2s, v0.s[1]
; CHECK-NEXT:    smull2 v1.2d, v1.4s, v0.s[1]
; CHECK-NEXT:    shrn v2.2s, v2.2d, #15
; CHECK-NEXT:    shrn2 v2.4s, v1.2d, #15
; CHECK-NEXT:    str q2, [x0], #32
; CHECK-NEXT:    b.ne .LBB7_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  %ext = sext <2 x i32> %a to <2 x i64>
  %broadcast.splat = shufflevector <2 x i64> %ext, <2 x i64> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  br label %loop

loop:
  %index = phi i64 [ 0, %entry ], [ %index.next, %loop ]
  %g = getelementptr inbounds i32, i32 *%p, i64 %index
  %gb = bitcast i32* %g to <4 x i32>*
  %l = load <4 x i32>, <4 x i32> *%gb, align 4
  %e = sext <4 x i32> %l to <4 x i64>
  %m = mul <4 x i64> %e, %broadcast.splat
  %s = ashr <4 x i64> %m, <i64 15, i64 15, i64 15, i64 15>
  %t = trunc <4 x i64> %s to <4 x i32>
  %h = getelementptr inbounds i32, i32 *%d, i64 %index
  %hb = bitcast i32* %g to <4 x i32>*
  store <4 x i32> %t, <4 x i32> *%hb, align 4
  %index.next = add nuw i64 %index, 8
  %c = icmp eq i64 %index.next, %n
  br i1 %c, label %exit, label %loop

exit:
  ret void
}

define void @sink_v8z16_0(i32 *%p, i32 *%d, i64 %n, <16 x i8> %a) {
; CHECK-LABEL: sink_v8z16_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup v0.8b, v0.b[0]
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB8_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    add x8, x8, #8
; CHECK-NEXT:    subs x2, x2, #8
; CHECK-NEXT:    umull v1.8h, v1.8b, v0.8b
; CHECK-NEXT:    cmlt v1.8h, v1.8h, #0
; CHECK-NEXT:    xtn v1.8b, v1.8h
; CHECK-NEXT:    str d1, [x0], #32
; CHECK-NEXT:    b.ne .LBB8_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  %ext = zext <16 x i8> %a to <16 x i16>
  %broadcast.splat = shufflevector <16 x i16> %ext, <16 x i16> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  br label %loop

loop:
  %index = phi i64 [ 0, %entry ], [ %index.next, %loop ]
  %g = getelementptr inbounds i32, i32 *%p, i64 %index
  %gb = bitcast i32* %g to <8 x i8>*
  %l = load <8 x i8>, <8 x i8> *%gb, align 4
  %e = zext <8 x i8> %l to <8 x i16>
  %m = mul <8 x i16> %e, %broadcast.splat
  %s = ashr <8 x i16> %m, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %t = trunc <8 x i16> %s to <8 x i8>
  %h = getelementptr inbounds i32, i32 *%d, i64 %index
  %hb = bitcast i32* %g to <8 x i8>*
  store <8 x i8> %t, <8 x i8> *%hb, align 4
  %index.next = add nuw i64 %index, 8
  %c = icmp eq i64 %index.next, %n
  br i1 %c, label %exit, label %loop

exit:
  ret void
}

define void @sink_v16s16_8(i32 *%p, i32 *%d, i64 %n, <16 x i8> %a) {
; CHECK-LABEL: sink_v16s16_8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup v1.8b, v0.b[10]
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    dup v0.16b, v0.b[10]
; CHECK-NEXT:  .LBB9_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    add x8, x8, #8
; CHECK-NEXT:    subs x2, x2, #8
; CHECK-NEXT:    smull2 v3.8h, v2.16b, v0.16b
; CHECK-NEXT:    smull v2.8h, v2.8b, v1.8b
; CHECK-NEXT:    cmlt v3.8h, v3.8h, #0
; CHECK-NEXT:    cmlt v2.8h, v2.8h, #0
; CHECK-NEXT:    uzp1 v2.16b, v2.16b, v3.16b
; CHECK-NEXT:    str q2, [x0], #32
; CHECK-NEXT:    b.ne .LBB9_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  %ext = sext <16 x i8> %a to <16 x i16>
  %broadcast.splat = shufflevector <16 x i16> %ext, <16 x i16> poison, <16 x i32> <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  br label %loop

loop:
  %index = phi i64 [ 0, %entry ], [ %index.next, %loop ]
  %g = getelementptr inbounds i32, i32 *%p, i64 %index
  %gb = bitcast i32* %g to <16 x i8>*
  %l = load <16 x i8>, <16 x i8> *%gb, align 4
  %e = sext <16 x i8> %l to <16 x i16>
  %m = mul <16 x i16> %e, %broadcast.splat
  %s = ashr <16 x i16> %m, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %t = trunc <16 x i16> %s to <16 x i8>
  %h = getelementptr inbounds i32, i32 *%d, i64 %index
  %hb = bitcast i32* %g to <16 x i8>*
  store <16 x i8> %t, <16 x i8> *%hb, align 4
  %index.next = add nuw i64 %index, 8
  %c = icmp eq i64 %index.next, %n
  br i1 %c, label %exit, label %loop

exit:
  ret void
}

declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>)

