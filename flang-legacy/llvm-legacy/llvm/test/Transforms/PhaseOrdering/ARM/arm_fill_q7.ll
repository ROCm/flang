; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O3 -S                                        | FileCheck --check-prefix=OLDPM %s
; RUN: opt < %s -passes='default<O3>' -S | FileCheck --check-prefix=NEWPM %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv6m-none-none-eabi"

; Not only should we be able to to form memsets here, the original loops
; should be deleted, too.

; Function Attrs: nounwind
define dso_local void @arm_fill_q7(i8 signext %value, i8* %pDst, i32 %blockSize) #0 {
; OLDPM-LABEL: @arm_fill_q7(
; OLDPM-NEXT:  entry:
; OLDPM-NEXT:    [[CMP_NOT20:%.*]] = icmp ult i32 [[BLOCKSIZE:%.*]], 4
; OLDPM-NEXT:    br i1 [[CMP_NOT20]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; OLDPM:       while.body.preheader:
; OLDPM-NEXT:    [[TMP0:%.*]] = and i32 [[BLOCKSIZE]], -4
; OLDPM-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[PDST:%.*]], i8 [[VALUE:%.*]], i32 [[TMP0]], i1 false)
; OLDPM-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, i8* [[PDST]], i32 [[TMP0]]
; OLDPM-NEXT:    br label [[WHILE_END]]
; OLDPM:       while.end:
; OLDPM-NEXT:    [[PDST_ADDR_0_LCSSA:%.*]] = phi i8* [ [[PDST]], [[ENTRY:%.*]] ], [ [[SCEVGEP]], [[WHILE_BODY_PREHEADER]] ]
; OLDPM-NEXT:    [[REM:%.*]] = and i32 [[BLOCKSIZE]], 3
; OLDPM-NEXT:    [[CMP14_NOT17:%.*]] = icmp eq i32 [[REM]], 0
; OLDPM-NEXT:    br i1 [[CMP14_NOT17]], label [[WHILE_END18:%.*]], label [[WHILE_BODY16_PREHEADER:%.*]]
; OLDPM:       while.body16.preheader:
; OLDPM-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[PDST_ADDR_0_LCSSA]], i8 [[VALUE]], i32 [[REM]], i1 false)
; OLDPM-NEXT:    br label [[WHILE_END18]]
; OLDPM:       while.end18:
; OLDPM-NEXT:    ret void
;
; NEWPM-LABEL: @arm_fill_q7(
; NEWPM-NEXT:  entry:
; NEWPM-NEXT:    [[CMP_NOT17:%.*]] = icmp ult i32 [[BLOCKSIZE:%.*]], 4
; NEWPM-NEXT:    br i1 [[CMP_NOT17]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; NEWPM:       while.body.preheader:
; NEWPM-NEXT:    [[TMP0:%.*]] = and i32 [[BLOCKSIZE]], -4
; NEWPM-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[PDST:%.*]], i8 [[VALUE:%.*]], i32 [[TMP0]], i1 false)
; NEWPM-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, i8* [[PDST]], i32 [[TMP0]]
; NEWPM-NEXT:    br label [[WHILE_END]]
; NEWPM:       while.end:
; NEWPM-NEXT:    [[PDST_ADDR_0_LCSSA:%.*]] = phi i8* [ [[PDST]], [[ENTRY:%.*]] ], [ [[SCEVGEP]], [[WHILE_BODY_PREHEADER]] ]
; NEWPM-NEXT:    [[REM:%.*]] = and i32 [[BLOCKSIZE]], 3
; NEWPM-NEXT:    [[CMP14_NOT20:%.*]] = icmp eq i32 [[REM]], 0
; NEWPM-NEXT:    br i1 [[CMP14_NOT20]], label [[WHILE_END18:%.*]], label [[WHILE_BODY16_PREHEADER:%.*]]
; NEWPM:       while.body16.preheader:
; NEWPM-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[PDST_ADDR_0_LCSSA]], i8 [[VALUE]], i32 [[REM]], i1 false)
; NEWPM-NEXT:    br label [[WHILE_END18]]
; NEWPM:       while.end18:
; NEWPM-NEXT:    ret void
;
entry:
  %value.addr = alloca i8, align 1
  %pDst.addr = alloca i8*, align 4
  %blockSize.addr = alloca i32, align 4
  %blkCnt = alloca i32, align 4
  %packedValue = alloca i32, align 4
  store i8 %value, i8* %value.addr, align 1, !tbaa !3
  store i8* %pDst, i8** %pDst.addr, align 4, !tbaa !6
  store i32 %blockSize, i32* %blockSize.addr, align 4, !tbaa !8
  %0 = bitcast i32* %blkCnt to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #3
  %1 = bitcast i32* %packedValue to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %1) #3
  %2 = load i8, i8* %value.addr, align 1, !tbaa !3
  %conv = sext i8 %2 to i32
  %shl = shl i32 %conv, 0
  %and = and i32 %shl, 255
  %3 = load i8, i8* %value.addr, align 1, !tbaa !3
  %conv1 = sext i8 %3 to i32
  %shl2 = shl i32 %conv1, 8
  %and3 = and i32 %shl2, 65280
  %or = or i32 %and, %and3
  %4 = load i8, i8* %value.addr, align 1, !tbaa !3
  %conv4 = sext i8 %4 to i32
  %shl5 = shl i32 %conv4, 16
  %and6 = and i32 %shl5, 16711680
  %or7 = or i32 %or, %and6
  %5 = load i8, i8* %value.addr, align 1, !tbaa !3
  %conv8 = sext i8 %5 to i32
  %shl9 = shl i32 %conv8, 24
  %and10 = and i32 %shl9, -16777216
  %or11 = or i32 %or7, %and10
  store i32 %or11, i32* %packedValue, align 4, !tbaa !8
  %6 = load i32, i32* %blockSize.addr, align 4, !tbaa !8
  %shr = lshr i32 %6, 2
  store i32 %shr, i32* %blkCnt, align 4, !tbaa !8
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %7 = load i32, i32* %blkCnt, align 4, !tbaa !8
  %cmp = icmp ugt i32 %7, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %8 = load i32, i32* %packedValue, align 4, !tbaa !8
  call void @write_q7x4_ia(i8** %pDst.addr, i32 %8)
  %9 = load i32, i32* %blkCnt, align 4, !tbaa !8
  %dec = add i32 %9, -1
  store i32 %dec, i32* %blkCnt, align 4, !tbaa !8
  br label %while.cond, !llvm.loop !10

while.end:                                        ; preds = %while.cond
  %10 = load i32, i32* %blockSize.addr, align 4, !tbaa !8
  %rem = urem i32 %10, 4
  store i32 %rem, i32* %blkCnt, align 4, !tbaa !8
  br label %while.cond13

while.cond13:                                     ; preds = %while.body16, %while.end
  %11 = load i32, i32* %blkCnt, align 4, !tbaa !8
  %cmp14 = icmp ugt i32 %11, 0
  br i1 %cmp14, label %while.body16, label %while.end18

while.body16:                                     ; preds = %while.cond13
  %12 = load i8, i8* %value.addr, align 1, !tbaa !3
  %13 = load i8*, i8** %pDst.addr, align 4, !tbaa !6
  %incdec.ptr = getelementptr inbounds i8, i8* %13, i32 1
  store i8* %incdec.ptr, i8** %pDst.addr, align 4, !tbaa !6
  store i8 %12, i8* %13, align 1, !tbaa !3
  %14 = load i32, i32* %blkCnt, align 4, !tbaa !8
  %dec17 = add i32 %14, -1
  store i32 %dec17, i32* %blkCnt, align 4, !tbaa !8
  br label %while.cond13, !llvm.loop !12

while.end18:                                      ; preds = %while.cond13
  %15 = bitcast i32* %packedValue to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %15) #3
  %16 = bitcast i32* %blkCnt to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %16) #3
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: alwaysinline nounwind
define internal void @write_q7x4_ia(i8** %pQ7, i32 %value) #2 {
entry:
  %pQ7.addr = alloca i8**, align 4
  %value.addr = alloca i32, align 4
  %val = alloca i32, align 4
  store i8** %pQ7, i8*** %pQ7.addr, align 4, !tbaa !6
  store i32 %value, i32* %value.addr, align 4, !tbaa !8
  %0 = bitcast i32* %val to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #3
  %1 = load i32, i32* %value.addr, align 4, !tbaa !8
  store i32 %1, i32* %val, align 4, !tbaa !8
  %2 = load i32, i32* %val, align 4, !tbaa !8
  %and = and i32 %2, 255
  %conv = trunc i32 %and to i8
  %3 = load i8**, i8*** %pQ7.addr, align 4, !tbaa !6
  %4 = load i8*, i8** %3, align 4, !tbaa !6
  %arrayidx = getelementptr inbounds i8, i8* %4, i32 0
  store i8 %conv, i8* %arrayidx, align 1, !tbaa !3
  %5 = load i32, i32* %val, align 4, !tbaa !8
  %shr = ashr i32 %5, 8
  %and1 = and i32 %shr, 255
  %conv2 = trunc i32 %and1 to i8
  %6 = load i8**, i8*** %pQ7.addr, align 4, !tbaa !6
  %7 = load i8*, i8** %6, align 4, !tbaa !6
  %arrayidx3 = getelementptr inbounds i8, i8* %7, i32 1
  store i8 %conv2, i8* %arrayidx3, align 1, !tbaa !3
  %8 = load i32, i32* %val, align 4, !tbaa !8
  %shr4 = ashr i32 %8, 16
  %and5 = and i32 %shr4, 255
  %conv6 = trunc i32 %and5 to i8
  %9 = load i8**, i8*** %pQ7.addr, align 4, !tbaa !6
  %10 = load i8*, i8** %9, align 4, !tbaa !6
  %arrayidx7 = getelementptr inbounds i8, i8* %10, i32 2
  store i8 %conv6, i8* %arrayidx7, align 1, !tbaa !3
  %11 = load i32, i32* %val, align 4, !tbaa !8
  %shr8 = ashr i32 %11, 24
  %and9 = and i32 %shr8, 255
  %conv10 = trunc i32 %and9 to i8
  %12 = load i8**, i8*** %pQ7.addr, align 4, !tbaa !6
  %13 = load i8*, i8** %12, align 4, !tbaa !6
  %arrayidx11 = getelementptr inbounds i8, i8* %13, i32 3
  store i8 %conv10, i8* %arrayidx11, align 1, !tbaa !3
  %14 = load i8**, i8*** %pQ7.addr, align 4, !tbaa !6
  %15 = load i8*, i8** %14, align 4, !tbaa !6
  %add.ptr = getelementptr inbounds i8, i8* %15, i32 4
  store i8* %add.ptr, i8** %14, align 4, !tbaa !6
  %16 = bitcast i32* %val to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %16) #3
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m0plus" "target-features"="+armv6-m,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-dotprod,-dsp,-fp16fml,-fullfp16,-hwdiv,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-ras,-sb,-sha2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { alwaysinline nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m0plus" "target-features"="+armv6-m,+strict-align,+thumb-mode,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-dotprod,-dsp,-fp16fml,-fullfp16,-hwdiv,-hwdiv-arm,-i8mm,-lob,-mve,-mve.fp,-ras,-sb,-sha2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"min_enum_size", i32 4}
!2 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 07f234be1ccbce131704f580aa3f117083a887f7)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"any pointer", !4, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !4, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
