; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -o - -mtriple=x86_64-unknown-linux-gnu -mattr=+avx2 -slp-threshold=50 -slp-recursion-max-depth=6 < %s | FileCheck %s

define i32 @bar() local_unnamed_addr {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD78_1:%.*]] = add nsw i32 undef, undef
; CHECK-NEXT:    [[SUB86_1:%.*]] = sub nsw i32 undef, undef
; CHECK-NEXT:    [[ADD94_1:%.*]] = add nsw i32 undef, undef
; CHECK-NEXT:    [[SUB102_1:%.*]] = sub nsw i32 undef, undef
; CHECK-NEXT:    [[ADD78_2:%.*]] = add nsw i32 undef, undef
; CHECK-NEXT:    [[SUB102_3:%.*]] = sub nsw i32 undef, undef
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <16 x i32> poison, i32 [[SUB102_1]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <16 x i32> [[TMP0]], i32 [[ADD94_1]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <16 x i32> [[TMP1]], i32 [[ADD78_1]], i32 2
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <16 x i32> [[TMP2]], i32 [[SUB86_1]], i32 3
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <16 x i32> [[TMP3]], i32 [[ADD78_2]], i32 4
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <16 x i32> [[TMP4]], <16 x i32> poison, <16 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 0, i32 1, i32 2, i32 3, i32 undef, i32 4, i32 4, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <16 x i32> poison, i32 [[SUB86_1]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <16 x i32> [[TMP5]], i32 [[ADD78_1]], i32 1
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <16 x i32> [[TMP6]], i32 [[ADD94_1]], i32 2
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <16 x i32> [[TMP7]], i32 [[SUB102_1]], i32 3
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <16 x i32> [[TMP8]], i32 [[SUB102_3]], i32 4
; CHECK-NEXT:    [[SHUFFLE1:%.*]] = shufflevector <16 x i32> [[TMP9]], <16 x i32> poison, <16 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 4, i32 undef, i32 undef, i32 4>
; CHECK-NEXT:    [[TMP10:%.*]] = add nsw <16 x i32> [[SHUFFLE]], [[SHUFFLE1]]
; CHECK-NEXT:    [[TMP11:%.*]] = sub nsw <16 x i32> [[SHUFFLE]], [[SHUFFLE1]]
; CHECK-NEXT:    [[TMP12:%.*]] = shufflevector <16 x i32> [[TMP10]], <16 x i32> [[TMP11]], <16 x i32> <i32 0, i32 1, i32 18, i32 19, i32 4, i32 5, i32 22, i32 23, i32 8, i32 9, i32 26, i32 27, i32 12, i32 13, i32 30, i32 31>
; CHECK-NEXT:    [[TMP13:%.*]] = lshr <16 x i32> [[TMP12]], <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
; CHECK-NEXT:    [[TMP14:%.*]] = and <16 x i32> [[TMP13]], <i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537>
; CHECK-NEXT:    [[TMP15:%.*]] = mul nuw <16 x i32> [[TMP14]], <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
; CHECK-NEXT:    [[TMP16:%.*]] = add <16 x i32> [[TMP15]], [[TMP12]]
; CHECK-NEXT:    [[TMP17:%.*]] = xor <16 x i32> [[TMP16]], [[TMP15]]
; CHECK-NEXT:    [[TMP18:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[TMP17]])
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[TMP18]], 16
; CHECK-NEXT:    [[ADD119:%.*]] = add nuw nsw i32 undef, [[SHR]]
; CHECK-NEXT:    [[SHR120:%.*]] = lshr i32 [[ADD119]], 1
; CHECK-NEXT:    ret i32 [[SHR120]]
;
entry:
  %add103 = add nsw i32 undef, undef
  %sub104 = sub nsw i32 undef, undef
  %add105 = add nsw i32 undef, undef
  %sub106 = sub nsw i32 undef, undef
  %shr.i = lshr i32 %add103, 15
  %and.i = and i32 %shr.i, 65537
  %mul.i = mul nuw i32 %and.i, 65535
  %add.i = add i32 %mul.i, %add103
  %xor.i = xor i32 %add.i, %mul.i
  %shr.i64 = lshr i32 %add105, 15
  %and.i65 = and i32 %shr.i64, 65537
  %mul.i66 = mul nuw i32 %and.i65, 65535
  %add.i67 = add i32 %mul.i66, %add105
  %xor.i68 = xor i32 %add.i67, %mul.i66
  %shr.i69 = lshr i32 %sub104, 15
  %and.i70 = and i32 %shr.i69, 65537
  %mul.i71 = mul nuw i32 %and.i70, 65535
  %add.i72 = add i32 %mul.i71, %sub104
  %xor.i73 = xor i32 %add.i72, %mul.i71
  %shr.i74 = lshr i32 %sub106, 15
  %and.i75 = and i32 %shr.i74, 65537
  %mul.i76 = mul nuw i32 %and.i75, 65535
  %add.i77 = add i32 %mul.i76, %sub106
  %xor.i78 = xor i32 %add.i77, %mul.i76
  %add110 = add i32 %xor.i68, %xor.i
  %add112 = add i32 %add110, %xor.i73
  %add113 = add i32 %add112, %xor.i78
  %add78.1 = add nsw i32 undef, undef
  %sub86.1 = sub nsw i32 undef, undef
  %add94.1 = add nsw i32 undef, undef
  %sub102.1 = sub nsw i32 undef, undef
  %add103.1 = add nsw i32 %add94.1, %add78.1
  %sub104.1 = sub nsw i32 %add78.1, %add94.1
  %add105.1 = add nsw i32 %sub102.1, %sub86.1
  %sub106.1 = sub nsw i32 %sub86.1, %sub102.1
  %shr.i.1 = lshr i32 %add103.1, 15
  %and.i.1 = and i32 %shr.i.1, 65537
  %mul.i.1 = mul nuw i32 %and.i.1, 65535
  %add.i.1 = add i32 %mul.i.1, %add103.1
  %xor.i.1 = xor i32 %add.i.1, %mul.i.1
  %shr.i64.1 = lshr i32 %add105.1, 15
  %and.i65.1 = and i32 %shr.i64.1, 65537
  %mul.i66.1 = mul nuw i32 %and.i65.1, 65535
  %add.i67.1 = add i32 %mul.i66.1, %add105.1
  %xor.i68.1 = xor i32 %add.i67.1, %mul.i66.1
  %shr.i69.1 = lshr i32 %sub104.1, 15
  %and.i70.1 = and i32 %shr.i69.1, 65537
  %mul.i71.1 = mul nuw i32 %and.i70.1, 65535
  %add.i72.1 = add i32 %mul.i71.1, %sub104.1
  %xor.i73.1 = xor i32 %add.i72.1, %mul.i71.1
  %shr.i74.1 = lshr i32 %sub106.1, 15
  %and.i75.1 = and i32 %shr.i74.1, 65537
  %mul.i76.1 = mul nuw i32 %and.i75.1, 65535
  %add.i77.1 = add i32 %mul.i76.1, %sub106.1
  %xor.i78.1 = xor i32 %add.i77.1, %mul.i76.1
  %add108.1 = add i32 %xor.i68.1, %add113
  %add110.1 = add i32 %add108.1, %xor.i.1
  %add112.1 = add i32 %add110.1, %xor.i73.1
  %add113.1 = add i32 %add112.1, %xor.i78.1
  %add78.2 = add nsw i32 undef, undef
  %add103.2 = add nsw i32 undef, %add78.2
  %sub104.2 = sub nsw i32 %add78.2, undef
  %add105.2 = add nsw i32 undef, undef
  %sub106.2 = sub nsw i32 undef, undef
  %shr.i.2 = lshr i32 %add103.2, 15
  %and.i.2 = and i32 %shr.i.2, 65537
  %mul.i.2 = mul nuw i32 %and.i.2, 65535
  %add.i.2 = add i32 %mul.i.2, %add103.2
  %xor.i.2 = xor i32 %add.i.2, %mul.i.2
  %shr.i64.2 = lshr i32 %add105.2, 15
  %and.i65.2 = and i32 %shr.i64.2, 65537
  %mul.i66.2 = mul nuw i32 %and.i65.2, 65535
  %add.i67.2 = add i32 %mul.i66.2, %add105.2
  %xor.i68.2 = xor i32 %add.i67.2, %mul.i66.2
  %shr.i69.2 = lshr i32 %sub104.2, 15
  %and.i70.2 = and i32 %shr.i69.2, 65537
  %mul.i71.2 = mul nuw i32 %and.i70.2, 65535
  %add.i72.2 = add i32 %mul.i71.2, %sub104.2
  %xor.i73.2 = xor i32 %add.i72.2, %mul.i71.2
  %shr.i74.2 = lshr i32 %sub106.2, 15
  %and.i75.2 = and i32 %shr.i74.2, 65537
  %mul.i76.2 = mul nuw i32 %and.i75.2, 65535
  %add.i77.2 = add i32 %mul.i76.2, %sub106.2
  %xor.i78.2 = xor i32 %add.i77.2, %mul.i76.2
  %add108.2 = add i32 %xor.i68.2, %add113.1
  %add110.2 = add i32 %add108.2, %xor.i.2
  %add112.2 = add i32 %add110.2, %xor.i73.2
  %add113.2 = add i32 %add112.2, %xor.i78.2
  %sub102.3 = sub nsw i32 undef, undef
  %add103.3 = add nsw i32 undef, undef
  %sub104.3 = sub nsw i32 undef, undef
  %add105.3 = add nsw i32 %sub102.3, undef
  %sub106.3 = sub nsw i32 undef, %sub102.3
  %shr.i.3 = lshr i32 %add103.3, 15
  %and.i.3 = and i32 %shr.i.3, 65537
  %mul.i.3 = mul nuw i32 %and.i.3, 65535
  %add.i.3 = add i32 %mul.i.3, %add103.3
  %xor.i.3 = xor i32 %add.i.3, %mul.i.3
  %shr.i64.3 = lshr i32 %add105.3, 15
  %and.i65.3 = and i32 %shr.i64.3, 65537
  %mul.i66.3 = mul nuw i32 %and.i65.3, 65535
  %add.i67.3 = add i32 %mul.i66.3, %add105.3
  %xor.i68.3 = xor i32 %add.i67.3, %mul.i66.3
  %shr.i69.3 = lshr i32 %sub104.3, 15
  %and.i70.3 = and i32 %shr.i69.3, 65537
  %mul.i71.3 = mul nuw i32 %and.i70.3, 65535
  %add.i72.3 = add i32 %mul.i71.3, %sub104.3
  %xor.i73.3 = xor i32 %add.i72.3, %mul.i71.3
  %shr.i74.3 = lshr i32 %sub106.3, 15
  %and.i75.3 = and i32 %shr.i74.3, 65537
  %mul.i76.3 = mul nuw i32 %and.i75.3, 65535
  %add.i77.3 = add i32 %mul.i76.3, %sub106.3
  %xor.i78.3 = xor i32 %add.i77.3, %mul.i76.3
  %add108.3 = add i32 %xor.i68.3, %add113.2
  %add110.3 = add i32 %add108.3, %xor.i.3
  %add112.3 = add i32 %add110.3, %xor.i73.3
  %add113.3 = add i32 %add112.3, %xor.i78.3
  %shr = lshr i32 %add113.3, 16
  %add119 = add nuw nsw i32 undef, %shr
  %shr120 = lshr i32 %add119, 1
  ret i32 %shr120
}
