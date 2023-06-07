; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;
; Verify that snprintf calls with a constant size not exceeding INT_MAX
; and a "%s" format string and a const string argument are transformed
; into memcpy.  Also verify that a size in excess of INT_MAX prevents
; the transformation.
;
; RUN: opt < %s -passes=instcombine -S -data-layout="E" | FileCheck %s -check-prefixes=ANY,BE
; RUN: opt < %s -passes=instcombine -S -data-layout="e" | FileCheck %s -check-prefixes=ANY,LE

@pcnt_s = constant [3 x i8] c"%s\00"
@s = constant [4 x i8] c"123\00"

@adst = external global [0 x ptr]
@asiz = external global [0 x i32]

declare i32 @snprintf(ptr, i64, ptr, ...)


; Verify that all snprintf calls with a bound between INT_MAX and down
; to 0 are transformed to memcpy.

define void @fold_snprintf_pcnt_s() {
; BE-LABEL: @fold_snprintf_pcnt_s(
; BE-NEXT:    [[PDIMAX:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 2147483647), align 8
; BE-NEXT:    store i32 825373440, ptr [[PDIMAX]], align 1
; BE-NEXT:    store i32 3, ptr @asiz, align 4
; BE-NEXT:    [[PD5:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 5), align 8
; BE-NEXT:    store i32 825373440, ptr [[PD5]], align 1
; BE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 5), align 4
; BE-NEXT:    [[PD4:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 4), align 8
; BE-NEXT:    store i32 825373440, ptr [[PD4]], align 1
; BE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 4), align 4
; BE-NEXT:    [[PD3:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 3), align 8
; BE-NEXT:    store i16 12594, ptr [[PD3]], align 1
; BE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[PD3]], i64 2
; BE-NEXT:    store i8 0, ptr [[ENDPTR]], align 1
; BE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 3), align 4
; BE-NEXT:    [[PD2:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 2), align 8
; BE-NEXT:    store i8 49, ptr [[PD2]], align 1
; BE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[PD2]], i64 1
; BE-NEXT:    store i8 0, ptr [[ENDPTR1]], align 1
; BE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 2), align 4
; BE-NEXT:    [[PD1:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 1), align 8
; BE-NEXT:    store i8 0, ptr [[PD1]], align 1
; BE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 1), align 4
; BE-NEXT:    store i32 3, ptr @asiz, align 4
; BE-NEXT:    ret void
;
; LE-LABEL: @fold_snprintf_pcnt_s(
; LE-NEXT:    [[PDIMAX:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 2147483647), align 8
; LE-NEXT:    store i32 3355185, ptr [[PDIMAX]], align 1
; LE-NEXT:    store i32 3, ptr @asiz, align 4
; LE-NEXT:    [[PD5:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 5), align 8
; LE-NEXT:    store i32 3355185, ptr [[PD5]], align 1
; LE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 5), align 4
; LE-NEXT:    [[PD4:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 4), align 8
; LE-NEXT:    store i32 3355185, ptr [[PD4]], align 1
; LE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 4), align 4
; LE-NEXT:    [[PD3:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 3), align 8
; LE-NEXT:    store i16 12849, ptr [[PD3]], align 1
; LE-NEXT:    [[ENDPTR:%.*]] = getelementptr inbounds i8, ptr [[PD3]], i64 2
; LE-NEXT:    store i8 0, ptr [[ENDPTR]], align 1
; LE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 3), align 4
; LE-NEXT:    [[PD2:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 2), align 8
; LE-NEXT:    store i8 49, ptr [[PD2]], align 1
; LE-NEXT:    [[ENDPTR1:%.*]] = getelementptr inbounds i8, ptr [[PD2]], i64 1
; LE-NEXT:    store i8 0, ptr [[ENDPTR1]], align 1
; LE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 2), align 4
; LE-NEXT:    [[PD1:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 1), align 8
; LE-NEXT:    store i8 0, ptr [[PD1]], align 1
; LE-NEXT:    store i32 3, ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 1), align 4
; LE-NEXT:    store i32 3, ptr @asiz, align 4
; LE-NEXT:    ret void
;

  %pdimax = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 2147483647)
  %nimax = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pdimax, i64 2147483647, ptr @pcnt_s, ptr @s)
  store i32 %nimax, ptr @asiz

  %pd5 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 5)
  %n5 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd5, i64 5, ptr @pcnt_s, ptr @s)
  store i32 %n5, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 5)

  %pd4 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 4)
  %n4 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd4, i64 4, ptr @pcnt_s, ptr @s)
  store i32 %n4, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 4)

  %pd3 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 3)
  %n3 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd3, i64 3, ptr @pcnt_s, ptr @s)
  store i32 %n3, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 3)

  %pd2 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 2)
  %n2 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd2, i64 2, ptr @pcnt_s, ptr @s)
  store i32 %n2, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 2)

  %pd1 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 1)
  %n1 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd1, i64 1, ptr @pcnt_s, ptr @s)
  store i32 %n1, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 1)

  %pd0 = load ptr, ptr @adst
  %n0 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pd0, i64 0, ptr @pcnt_s, ptr @s)
  store i32 %n0, ptr @asiz

  ret void
}


; Verify that snprintf calls with a bound greater than INT_MAX are not
; transformed.  POSIX requires implementations to set errno to EOVERFLOW
; so such calls could be folded to just that followed by returning -1.

define void @call_snprintf_pcnt_s_ximax() {
; ANY-LABEL: @call_snprintf_pcnt_s_ximax(
; ANY-NEXT:    [[PDM1:%.*]] = load ptr, ptr getelementptr inbounds ([0 x ptr], ptr @adst, i64 0, i64 1), align 8
; ANY-NEXT:    [[NM1:%.*]] = call i32 (ptr, i64, ptr, ...) @snprintf(ptr noundef nonnull dereferenceable(1) [[PDM1]], i64 -1, ptr nonnull @pcnt_s, ptr nonnull @s)
; ANY-NEXT:    store i32 [[NM1]], ptr getelementptr inbounds ([0 x i32], ptr @asiz, i64 0, i64 1), align 4
; ANY-NEXT:    [[PDIMAXP1:%.*]] = load ptr, ptr @adst, align 8
; ANY-NEXT:    [[NIMAXP1:%.*]] = call i32 (ptr, i64, ptr, ...) @snprintf(ptr noundef nonnull dereferenceable(1) [[PDIMAXP1]], i64 2147483648, ptr nonnull @pcnt_s, ptr nonnull @s)
; ANY-NEXT:    store i32 [[NIMAXP1]], ptr @asiz, align 4
; ANY-NEXT:    ret void
;

  %pdm1 = load ptr, ptr getelementptr ([0 x ptr], ptr @adst, i32 0, i32 1)
  %nm1 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pdm1, i64 -1, ptr @pcnt_s, ptr @s)
  store i32 %nm1, ptr getelementptr ([0 x i32], ptr @asiz, i32 0, i32 1)

  %pdimaxp1 = load ptr, ptr @adst
  %nimaxp1 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr %pdimaxp1, i64 2147483648, ptr @pcnt_s, ptr @s)
  store i32 %nimaxp1, ptr @asiz

  ret void
}
