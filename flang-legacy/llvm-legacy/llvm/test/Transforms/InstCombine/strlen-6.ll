; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verify that strlen calls with members of constant structs are folded.
;
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; struct A_a4 { char a[4]; };
%struct.A_a4 = type { [4 x i8] }

; struct A_a4_a5 { char a[4], b[5]; };
%struct.A_a4_a5 = type { [4 x i8], [5 x i8] }

; struct A_a4_i32_a5 { char a[4]; int32_t i; char b[5]; };
%struct.A_a4_i32_a5 = type { [4 x i8], i32, [5 x i8] }

@a_s3 = constant %struct.A_a4 { [4 x i8 ] c"123\00" }
@a_s3_s4 = constant %struct.A_a4_a5 { [4 x i8 ] c"123\00", [5 x i8] c"1234\00" }
@a_s3_i32_s4 = constant %struct.A_a4_i32_a5 { [4 x i8 ] c"123\00", i32 -1, [5 x i8] c"1234\00" }

; Structs with flexible array members.
@ax_s3 = constant { i8, [4 x i8] } { i8 3, [4 x i8] c"123\00" }
@ax_s5 = constant { i16, [6 x i8] } { i16 5, [6 x i8] c"12345\00" }
@ax_s7 = constant { i32, i32, [8 x i8] } { i32 7, i32 0, [8 x i8] c"1234567\00" }

@ax = external global [0 x i64]


declare i64 @strlen(ptr)


; Fold strlen(a_s3.a) to 3.

define i64 @fold_strlen_a_S3_to_3() {
; CHECK-LABEL: @fold_strlen_a_S3_to_3(
; CHECK-NEXT:    ret i64 3
;
  %len = call i64 @strlen(ptr @a_s3)
  ret i64 %len
}


; Fold strlen(&a_s3.a[1]) to 2.

define i64 @fold_strlen_a_S3_p1_to_2() {
; CHECK-LABEL: @fold_strlen_a_S3_p1_to_2(
; CHECK-NEXT:    ret i64 2
;
  %ptr = getelementptr %struct.A_a4, ptr @a_s3, i32 0, i32 0, i32 1
  %len = call i64 @strlen(ptr %ptr)
  ret i64 %len
}


; Fold strlen(&a_s3.a[2]) to 1.

define i64 @fold_strlen_a_S3_p2_to_1() {
; CHECK-LABEL: @fold_strlen_a_S3_p2_to_1(
; CHECK-NEXT:    ret i64 1
;
  %ptr = getelementptr %struct.A_a4, ptr @a_s3, i32 0, i32 0, i32 2
  %len = call i64 @strlen(ptr %ptr)
  ret i64 %len
}


; Fold strlen(&a_s3.a[3]) to 0.

define i64 @fold_strlen_a_S3_p3_to_0() {
; CHECK-LABEL: @fold_strlen_a_S3_p3_to_0(
; CHECK-NEXT:    ret i64 0
;
  %ptr = getelementptr %struct.A_a4, ptr @a_s3, i32 0, i32 0, i32 3
  %len = call i64 @strlen(ptr %ptr)
  ret i64 %len
}


; Fold strlen(a_s3_s4.a) to 3.

define i64 @fold_strlen_a_S3_s4_to_3() {
; CHECK-LABEL: @fold_strlen_a_S3_s4_to_3(
; CHECK-NEXT:    ret i64 3
;
  %len = call i64 @strlen(ptr @a_s3_s4)
  ret i64 %len
}


; Fold strlen(&a_s3_s4.a[2]) to 1.

define i64 @fold_strlen_a_S3_p2_s4_to_1() {
; CHECK-LABEL: @fold_strlen_a_S3_p2_s4_to_1(
; CHECK-NEXT:    ret i64 1
;
  %ptr = getelementptr %struct.A_a4_a5, ptr @a_s3_s4, i32 0, i32 0, i32 2
  %len = call i64 @strlen(ptr %ptr)
  ret i64 %len
}


; Fold strlen(a_s3_s4.b) to 4.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_S4_to_4() {
; CHECK-LABEL: @fold_strlen_a_s3_S4_to_4(
; CHECK-NEXT:    store i64 4, ptr @ax, align 4
; CHECK-NEXT:    store i64 4, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_a5, ptr @a_s3_s4, i32 0, i32 0, i32 4
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_a5, ptr @a_s3_s4, i32 0, i32 1, i32 0
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(&a_s3_s4.b[1]) to 3.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_S4_p1_to_3() {
; CHECK-LABEL: @fold_strlen_a_s3_S4_p1_to_3(
; CHECK-NEXT:    store i64 3, ptr @ax, align 4
; CHECK-NEXT:    store i64 3, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_a5, ptr @a_s3_s4, i32 0, i32 0, i32 5
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_a5, ptr @a_s3_s4, i32 0, i32 1, i32 1
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(a_s3_i32_s4.b) to 4.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_i32_S4_to_4() {
; CHECK-LABEL: @fold_strlen_a_s3_i32_S4_to_4(
; CHECK-NEXT:    store i64 4, ptr @ax, align 4
; CHECK-NEXT:    store i64 4, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 0, i32 8
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 2, i32 0
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(&a_s3_i32_s4.b[1]) to 3.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_i32_S4_p1_to_3() {
; CHECK-LABEL: @fold_strlen_a_s3_i32_S4_p1_to_3(
; CHECK-NEXT:    store i64 3, ptr @ax, align 4
; CHECK-NEXT:    store i64 3, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 0, i32 9
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 2, i32 0
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(&a_s3_i32_s4.b[2]) to 2.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_i32_S4_p2_to_2() {
; CHECK-LABEL: @fold_strlen_a_s3_i32_S4_p2_to_2(
; CHECK-NEXT:    store i64 2, ptr @ax, align 4
; CHECK-NEXT:    store i64 2, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 0, i32 10
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 2, i32 2
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(&a_s3_i32_s4.b[3]) to 1.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_i32_S4_p3_to_1() {
; CHECK-LABEL: @fold_strlen_a_s3_i32_S4_p3_to_1(
; CHECK-NEXT:    store i64 1, ptr @ax, align 4
; CHECK-NEXT:    store i64 1, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 0, i32 11
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 2, i32 3
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(&a_s3_i32_s4.b[4]) to 0.
; Exercise both variants of the GEP index.

define void @fold_strlen_a_s3_i32_S4_p4_to_0() {
; CHECK-LABEL: @fold_strlen_a_s3_i32_S4_p4_to_0(
; CHECK-NEXT:    store i64 0, ptr @ax, align 4
; CHECK-NEXT:    store i64 0, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    ret void
;
  %p1 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 0, i32 12
  %len1 = call i64 @strlen(ptr %p1)
  store i64 %len1, ptr @ax

  %p2 = getelementptr %struct.A_a4_i32_a5, ptr @a_s3_i32_s4, i32 0, i32 2, i32 4
  %len2 = call i64 @strlen(ptr %p2)
  %pax1 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len1, ptr %pax1

  ret void
}


; Fold strlen(ax_sN.a) of an constant initialized flexible array member
; to N for N in { 3, 5, 7 }.

define void @fold_strlen_ax_s() {
; CHECK-LABEL: @fold_strlen_ax_s(
; CHECK-NEXT:    store i64 3, ptr @ax, align 4
; CHECK-NEXT:    store i64 5, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 1), align 4
; CHECK-NEXT:    store i64 7, ptr getelementptr inbounds ([0 x i64], ptr @ax, i64 0, i64 2), align 4
; CHECK-NEXT:    ret void
;
  %pax_s3 = getelementptr { i8, [4 x i8] }, ptr @ax_s3, i64 0, i32 1, i64 0
  %len3 = call i64 @strlen(ptr %pax_s3)
  store i64 %len3, ptr @ax

  %pax_s5 = getelementptr { i16, [6 x i8] }, ptr @ax_s5, i64 0, i32 1, i64 0
  %len5 = call i64 @strlen(ptr %pax_s5)
  %pax2 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 1
  store i64 %len5, ptr %pax2

  %pax_s7 = getelementptr { i32, i32, [8 x i8] }, ptr @ax_s7, i64 0, i32 2, i64 0
  %len7 = call i64 @strlen(ptr %pax_s7)
  %pax3 = getelementptr inbounds [0 x i64], ptr @ax, i64 0, i64 2
  store i64 %len7, ptr %pax3

  ret void
}
