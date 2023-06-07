; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verify that calls to strtoul and strtoull are interpreted correctly even
; in corner cases (or not folded).
;
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i32 @strtoul(ptr, ptr, i32)
declare i64 @strtoull(ptr, ptr, i32)


; All POSIX whitespace characters.
@ws = constant [7 x i8] c"\09\0d\0a\0b\0c \00"

; A negative and positive number preceded by all POSIX whitespace.
@ws_im123 = constant [11 x i8] c"\09\0d\0a\0b\0c -123\00"
@ws_ip234 = constant [11 x i8] c"\09\0d\0a\0b\0c +234\00"

@i32min = constant [13 x i8] c" -2147483648\00"
@i32min_m1 = constant [13 x i8] c" -2147483649\00"
@o32min = constant [15 x i8] c" +020000000000\00"
@mo32min = constant [15 x i8] c" -020000000000\00"
@x32min = constant [13 x i8] c" +0x80000000\00"
@mx32min = constant [13 x i8] c" +0x80000000\00"

@i32max = constant [12 x i8] c" 2147483647\00"
@i32max_p1 = constant [12 x i8] c" 2147483648\00"
@mX01 = constant [6 x i8] c" -0X1\00"

@ui32max = constant [12 x i8] c" 4294967295\00"
@ui32max_p1 = constant [12 x i8] c" 4294967296\00"

@i64min = constant [22 x i8] c" -9223372036854775808\00"
@i64min_m1 = constant [22 x i8] c" -9223372036854775809\00"

@i64max = constant [21 x i8] c" 9223372036854775807\00"
@i64max_p1 = constant [21 x i8] c" 9223372036854775808\00"

@ui64max = constant [22 x i8] c" 18446744073709551615\00"
@x64max = constant [20 x i8] c" 0xffffffffffffffff\00"
@ui64max_p1 = constant [22 x i8] c" 18446744073709551616\00"

@endptr = external global ptr


; Exercise folding calls to 32-bit strtoul.

define void @fold_strtoul(ptr %ps) {
; CHECK-LABEL: @fold_strtoul(
; CHECK-NEXT:    store ptr getelementptr inbounds ([11 x i8], ptr @ws_im123, i64 0, i64 10), ptr @endptr, align 8
; CHECK-NEXT:    store i32 -123, ptr [[PS:%.*]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([11 x i8], ptr @ws_ip234, i64 0, i64 10), ptr @endptr, align 8
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr i32, ptr [[PS]], i64 1
; CHECK-NEXT:    store i32 234, ptr [[PS1]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @i32min_m1, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS2:%.*]] = getelementptr i32, ptr [[PS]], i64 2
; CHECK-NEXT:    store i32 2147483647, ptr [[PS2]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @i32min, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS3:%.*]] = getelementptr i32, ptr [[PS]], i64 3
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS3]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([15 x i8], ptr @o32min, i64 0, i64 14), ptr @endptr, align 8
; CHECK-NEXT:    [[PS4:%.*]] = getelementptr i32, ptr [[PS]], i64 4
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS4]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([15 x i8], ptr @mo32min, i64 0, i64 14), ptr @endptr, align 8
; CHECK-NEXT:    [[PS5:%.*]] = getelementptr i32, ptr [[PS]], i64 5
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS5]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @x32min, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS6:%.*]] = getelementptr i32, ptr [[PS]], i64 6
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS6]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @mx32min, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS7:%.*]] = getelementptr i32, ptr [[PS]], i64 7
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS7]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([12 x i8], ptr @i32max, i64 0, i64 11), ptr @endptr, align 8
; CHECK-NEXT:    [[PS8:%.*]] = getelementptr i32, ptr [[PS]], i64 8
; CHECK-NEXT:    store i32 2147483647, ptr [[PS8]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([6 x i8], ptr @mX01, i64 0, i64 5), ptr @endptr, align 8
; CHECK-NEXT:    [[PS9:%.*]] = getelementptr i32, ptr [[PS]], i64 9
; CHECK-NEXT:    store i32 -1, ptr [[PS9]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([12 x i8], ptr @i32max_p1, i64 0, i64 11), ptr @endptr, align 8
; CHECK-NEXT:    [[PS10:%.*]] = getelementptr i32, ptr [[PS]], i64 10
; CHECK-NEXT:    store i32 -2147483648, ptr [[PS10]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([12 x i8], ptr @ui32max, i64 0, i64 11), ptr @endptr, align 8
; CHECK-NEXT:    [[PS11:%.*]] = getelementptr i32, ptr [[PS]], i64 11
; CHECK-NEXT:    store i32 -1, ptr [[PS11]], align 4
; CHECK-NEXT:    ret void
;
; Fold a valid sequence with leading POSIX whitespace and a minus to
; (uint32_t)-123.
  %im123 = call i32 @strtoul(ptr @ws_im123, ptr @endptr, i32 10)
  store i32 %im123, ptr %ps

; Fold a valid sequence with leading POSIX whitespace and a plus to +234.
  %ip234 = call i32 @strtoul(ptr @ws_ip234, ptr @endptr, i32 10)
  %ps1 = getelementptr i32, ptr %ps, i32 1
  store i32 %ip234, ptr %ps1

; Fold the result of conversion that's equal to INT32_MIN - 1.
  %i32min32m1 = call i32 @strtoul(ptr @i32min_m1, ptr @endptr, i32 10)
  %ps2 = getelementptr i32, ptr %ps, i32 2
  store i32 %i32min32m1, ptr %ps2

; Fold INT32_MIN.
  %i32min = call i32 @strtoul(ptr @i32min, ptr @endptr, i32 10)
  %ps3 = getelementptr i32, ptr %ps, i32 3
  store i32 %i32min, ptr %ps3

; Fold INT32_MIN in octal.
  %o32min = call i32 @strtoul(ptr @o32min, ptr @endptr, i32 0)
  %ps4 = getelementptr i32, ptr %ps, i32 4
  store i32 %o32min, ptr %ps4

; Fold -INT32_MIN in octal.
  %mo32min = call i32 @strtoul(ptr @mo32min, ptr @endptr, i32 0)
  %ps5 = getelementptr i32, ptr %ps, i32 5
  store i32 %mo32min, ptr %ps5

; Fold INT32_MIN in hex.
  %x32min = call i32 @strtoul(ptr @x32min, ptr @endptr, i32 0)
  %ps6 = getelementptr i32, ptr %ps, i32 6
  store i32 %x32min, ptr %ps6

; Fold -INT32_MIN in hex.
  %mx32min = call i32 @strtoul(ptr @mx32min, ptr @endptr, i32 0)
  %ps7 = getelementptr i32, ptr %ps, i32 7
  store i32 %x32min, ptr %ps7

; Fold INT32_MAX.
  %i32max = call i32 @strtoul(ptr @i32max, ptr @endptr, i32 10)
  %ps8 = getelementptr i32, ptr %ps, i32 8
  store i32 %i32max, ptr %ps8

; Fold -0x01.
  %mX01 = call i32 @strtoul(ptr @mX01, ptr @endptr, i32 0)
  %ps9 = getelementptr i32, ptr %ps, i32 9
  store i32 %mX01, ptr %ps9

; Fold the result of conversion that's equal to INT32_MAX + 1.
  %i32max32p1 = call i32 @strtoul(ptr @i32max_p1, ptr @endptr, i32 10)
  %ps10 = getelementptr i32, ptr %ps, i32 10
  store i32 %i32max32p1, ptr %ps10

; Fold UINT32_MAX.
  %ui32max = call i32 @strtoul(ptr @ui32max, ptr @endptr, i32 10)
  %ps11 = getelementptr i32, ptr %ps, i32 11
  store i32 %ui32max, ptr %ps11

  ret void
}


; Exercise not folding calls to 32-bit strtoul.

define void @call_strtoul(ptr %ps) {
; CHECK-LABEL: @call_strtoul(
; CHECK-NEXT:    [[MINM1:%.*]] = call i32 @strtoul(ptr nonnull @i64min_m1, ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    store i32 [[MINM1]], ptr [[PS:%.*]], align 4
; CHECK-NEXT:    [[MAXP1:%.*]] = call i32 @strtoul(ptr nonnull @ui32max_p1, ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr i32, ptr [[PS]], i64 1
; CHECK-NEXT:    store i32 [[MAXP1]], ptr [[PS1]], align 4
; CHECK-NEXT:    [[NWS:%.*]] = call i32 @strtoul(ptr nonnull @ws, ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS2:%.*]] = getelementptr i32, ptr [[PS]], i64 2
; CHECK-NEXT:    store i32 [[NWS]], ptr [[PS2]], align 4
; CHECK-NEXT:    [[NWSP6:%.*]] = call i32 @strtoul(ptr nonnull getelementptr inbounds ([7 x i8], ptr @ws, i64 0, i64 6), ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS3:%.*]] = getelementptr i32, ptr [[PS]], i64 3
; CHECK-NEXT:    store i32 [[NWSP6]], ptr [[PS3]], align 4
; CHECK-NEXT:    ret void
;
; Do not fold the result of conversion that overflows uint32_t.  This
; could be folded into a constant provided errnor were set to ERANGE.
  %minm1 = call i32 @strtoul(ptr @i64min_m1, ptr @endptr, i32 10)
  store i32 %minm1, ptr %ps

; Do not fold the result of conversion that's greater than UINT32_MAX
; (same logic as above applies here).
  %maxp1 = call i32 @strtoul(ptr @ui32max_p1, ptr @endptr, i32 10)
  %ps1 = getelementptr i32, ptr %ps, i32 1
  store i32 %maxp1, ptr %ps1

; Do not fold a sequence consisting of just whitespace characters.
  %nws = call i32 @strtoul(ptr @ws, ptr @endptr, i32 10)
  %ps2 = getelementptr i32, ptr %ps, i32 2
  store i32 %nws, ptr %ps2

; Do not fold an empty sequence.  The library call may or may not end up
; storing EINVAL in errno.
  %pswsp6 = getelementptr [7 x i8], ptr @ws, i32 0, i32 6
  %nwsp6 = call i32 @strtoul(ptr %pswsp6, ptr @endptr, i32 10)
  %ps3 = getelementptr i32, ptr %ps, i32 3
  store i32 %nwsp6, ptr %ps3

  ret void
}


; Exercise folding calls to 64-bit strtoull.

define void @fold_strtoull(ptr %ps) {
; CHECK-LABEL: @fold_strtoull(
; CHECK-NEXT:    store ptr getelementptr inbounds ([11 x i8], ptr @ws_im123, i64 0, i64 10), ptr @endptr, align 8
; CHECK-NEXT:    store i64 -123, ptr [[PS:%.*]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([11 x i8], ptr @ws_ip234, i64 0, i64 10), ptr @endptr, align 8
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr i64, ptr [[PS]], i64 1
; CHECK-NEXT:    store i64 234, ptr [[PS1]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([22 x i8], ptr @i64min_m1, i64 0, i64 21), ptr @endptr, align 8
; CHECK-NEXT:    [[PS2:%.*]] = getelementptr i64, ptr [[PS]], i64 2
; CHECK-NEXT:    store i64 9223372036854775807, ptr [[PS2]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @i32min, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS3:%.*]] = getelementptr i64, ptr [[PS]], i64 3
; CHECK-NEXT:    store i64 -2147483648, ptr [[PS3]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([15 x i8], ptr @o32min, i64 0, i64 14), ptr @endptr, align 8
; CHECK-NEXT:    [[PS4:%.*]] = getelementptr i64, ptr [[PS]], i64 4
; CHECK-NEXT:    store i64 2147483648, ptr [[PS4]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([13 x i8], ptr @x32min, i64 0, i64 12), ptr @endptr, align 8
; CHECK-NEXT:    [[PS5:%.*]] = getelementptr i64, ptr [[PS]], i64 5
; CHECK-NEXT:    store i64 2147483648, ptr [[PS5]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([22 x i8], ptr @i64min, i64 0, i64 21), ptr @endptr, align 8
; CHECK-NEXT:    [[PS6:%.*]] = getelementptr i64, ptr [[PS]], i64 6
; CHECK-NEXT:    store i64 -9223372036854775808, ptr [[PS6]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([21 x i8], ptr @i64max, i64 0, i64 20), ptr @endptr, align 8
; CHECK-NEXT:    [[PS7:%.*]] = getelementptr i64, ptr [[PS]], i64 7
; CHECK-NEXT:    store i64 9223372036854775807, ptr [[PS7]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([21 x i8], ptr @i64max_p1, i64 0, i64 20), ptr @endptr, align 8
; CHECK-NEXT:    [[PS8:%.*]] = getelementptr i64, ptr [[PS]], i64 8
; CHECK-NEXT:    store i64 -9223372036854775808, ptr [[PS8]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([22 x i8], ptr @ui64max, i64 0, i64 21), ptr @endptr, align 8
; CHECK-NEXT:    [[PS9:%.*]] = getelementptr i64, ptr [[PS]], i64 9
; CHECK-NEXT:    store i64 -1, ptr [[PS9]], align 4
; CHECK-NEXT:    store ptr getelementptr inbounds ([20 x i8], ptr @x64max, i64 0, i64 19), ptr @endptr, align 8
; CHECK-NEXT:    [[PS10:%.*]] = getelementptr i64, ptr [[PS]], i64 10
; CHECK-NEXT:    store i64 -1, ptr [[PS10]], align 4
; CHECK-NEXT:    ret void
;
; Fold a valid sequence with leading POSIX whitespace and a minus to
; (uint64_t)-123.
  %im123 = call i64 @strtoull(ptr @ws_im123, ptr @endptr, i32 10)
  store i64 %im123, ptr %ps

; Fold a valid sequence with leading POSIX whitespace and a plus to +234.
  %ip234 = call i64 @strtoull(ptr @ws_ip234, ptr @endptr, i32 10)
  %ps1 = getelementptr i64, ptr %ps, i32 1
  store i64 %ip234, ptr %ps1

; Fold the result of conversion that's equal to INT64_MIN - 1.
  %i64min32m1 = call i64 @strtoull(ptr @i64min_m1, ptr @endptr, i32 10)
  %ps2 = getelementptr i64, ptr %ps, i32 2
  store i64 %i64min32m1, ptr %ps2

; Fold INT32_MIN.
  %i32min = call i64 @strtoull(ptr @i32min, ptr @endptr, i32 10)
  %ps3 = getelementptr i64, ptr %ps, i32 3
  store i64 %i32min, ptr %ps3

; Fold INT32_MIN in octal.
  %o32min = call i64 @strtoull(ptr @o32min, ptr @endptr, i32 0)
  %ps4 = getelementptr i64, ptr %ps, i32 4
  store i64 %o32min, ptr %ps4

; Fold INT32_MIN in hex.
  %x32min = call i64 @strtoull(ptr @x32min, ptr @endptr, i32 0)
  %ps5 = getelementptr i64, ptr %ps, i32 5
  store i64 %x32min, ptr %ps5

; Fold INT64_MIN.
  %i64min = call i64 @strtoull(ptr @i64min, ptr @endptr, i32 10)
  %ps6 = getelementptr i64, ptr %ps, i32 6
  store i64 %i64min, ptr %ps6

; Fold INT64_MAX.
  %i64max = call i64 @strtoull(ptr @i64max, ptr @endptr, i32 10)
  %ps7 = getelementptr i64, ptr %ps, i32 7
  store i64 %i64max, ptr %ps7

; Fold the result of conversion that's equal to INT64_MAX + 1 to INT64_MIN.
  %i64max32p1 = call i64 @strtoull(ptr @i64max_p1, ptr @endptr, i32 10)
  %ps8 = getelementptr i64, ptr %ps, i32 8
  store i64 %i64max32p1, ptr %ps8

; Fold UINT64_MAX.
  %ui64max = call i64 @strtoull(ptr @ui64max, ptr @endptr, i32 10)
  %ps9 = getelementptr i64, ptr %ps, i32 9
  store i64 %ui64max, ptr %ps9

; Fold UINT64_MAX in hex.
  %x64max = call i64 @strtoull(ptr @x64max, ptr @endptr, i32 0)
  %ps10 = getelementptr i64, ptr %ps, i32 10
  store i64 %x64max, ptr %ps10

  ret void
}


; Exercise not folding calls to 64-bit strtoull.

define void @call_strtoull(ptr %ps) {
; CHECK-LABEL: @call_strtoull(
; CHECK-NEXT:    [[MAXP1:%.*]] = call i64 @strtoull(ptr nonnull @ui64max_p1, ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr i64, ptr [[PS:%.*]], i64 1
; CHECK-NEXT:    store i64 [[MAXP1]], ptr [[PS1]], align 4
; CHECK-NEXT:    [[NWS:%.*]] = call i64 @strtoull(ptr nonnull @ws, ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS2:%.*]] = getelementptr i64, ptr [[PS]], i64 2
; CHECK-NEXT:    store i64 [[NWS]], ptr [[PS2]], align 4
; CHECK-NEXT:    [[NWSP6:%.*]] = call i64 @strtoull(ptr nonnull getelementptr inbounds ([7 x i8], ptr @ws, i64 0, i64 6), ptr nonnull @endptr, i32 10)
; CHECK-NEXT:    [[PS3:%.*]] = getelementptr i64, ptr [[PS]], i64 3
; CHECK-NEXT:    store i64 [[NWSP6]], ptr [[PS3]], align 4
; CHECK-NEXT:    ret void
;
; Do not fold the result of conversion that overflows uint64_t.  This
; could be folded into a constant provided errnor were set to ERANGE.
  %maxp1 = call i64 @strtoull(ptr @ui64max_p1, ptr @endptr, i32 10)
  %ps1 = getelementptr i64, ptr %ps, i32 1
  store i64 %maxp1, ptr %ps1

; Do not fold a sequence consisting of just whitespace characters.
  %nws = call i64 @strtoull(ptr @ws, ptr @endptr, i32 10)
  %ps2 = getelementptr i64, ptr %ps, i32 2
  store i64 %nws, ptr %ps2

; Do not fold an empty sequence.  The library call may or may not end up
; storing EINVAL in errno.
  %pswsp6 = getelementptr [7 x i8], ptr @ws, i32 0, i32 6
  %nwsp6 = call i64 @strtoull(ptr %pswsp6, ptr @endptr, i32 10)
  %ps3 = getelementptr i64, ptr %ps, i32 3
  store i64 %nwsp6, ptr %ps3

  ret void
}
