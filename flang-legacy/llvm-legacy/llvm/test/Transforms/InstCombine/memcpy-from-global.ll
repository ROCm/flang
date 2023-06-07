; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64"
@C.0.1248 = internal constant [128 x float] [ float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float 0.000000e+00, float -1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float -1.000000e+00, float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00 ], align 32		; <ptr> [#uses=1]

define float @test1(i32 %hash, float %x, float %y, float %z, float %w) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 [[HASH:%.*]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = and i32 [[TMP3]], 124
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP753:%.*]] = getelementptr [128 x float], ptr @C.0.1248, i64 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP9:%.*]] = load float, ptr [[TMP753]], align 16
; CHECK-NEXT:    [[TMP11:%.*]] = fmul float [[TMP9]], [[X:%.*]]
; CHECK-NEXT:    [[TMP13:%.*]] = fadd float [[TMP11]], 0.000000e+00
; CHECK-NEXT:    [[TMP17_SUM52:%.*]] = or i32 [[TMP5]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP17_SUM52]] to i64
; CHECK-NEXT:    [[TMP1851:%.*]] = getelementptr [128 x float], ptr @C.0.1248, i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[TMP19:%.*]] = load float, ptr [[TMP1851]], align 4
; CHECK-NEXT:    [[TMP21:%.*]] = fmul float [[TMP19]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP23:%.*]] = fadd float [[TMP21]], [[TMP13]]
; CHECK-NEXT:    [[TMP27_SUM50:%.*]] = or i32 [[TMP5]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP27_SUM50]] to i64
; CHECK-NEXT:    [[TMP2849:%.*]] = getelementptr [128 x float], ptr @C.0.1248, i64 0, i64 [[TMP2]]
; CHECK-NEXT:    [[TMP29:%.*]] = load float, ptr [[TMP2849]], align 8
; CHECK-NEXT:    [[TMP31:%.*]] = fmul float [[TMP29]], [[Z:%.*]]
; CHECK-NEXT:    [[TMP33:%.*]] = fadd float [[TMP31]], [[TMP23]]
; CHECK-NEXT:    [[TMP37_SUM48:%.*]] = or i32 [[TMP5]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = zext i32 [[TMP37_SUM48]] to i64
; CHECK-NEXT:    [[TMP3847:%.*]] = getelementptr [128 x float], ptr @C.0.1248, i64 0, i64 [[TMP3]]
; CHECK-NEXT:    [[TMP39:%.*]] = load float, ptr [[TMP3847]], align 4
; CHECK-NEXT:    [[TMP41:%.*]] = fmul float [[TMP39]], [[W:%.*]]
; CHECK-NEXT:    [[TMP43:%.*]] = fadd float [[TMP41]], [[TMP33]]
; CHECK-NEXT:    ret float [[TMP43]]
;
entry:
  %lookupTable = alloca [128 x float], align 16		; <ptr> [#uses=5]
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %lookupTable, ptr align 16 @C.0.1248, i64 512, i1 false)


  %tmp3 = shl i32 %hash, 2		; <i32> [#uses=1]
  %tmp5 = and i32 %tmp3, 124		; <i32> [#uses=4]
  %tmp753 = getelementptr [128 x float], ptr %lookupTable, i32 0, i32 %tmp5		; <ptr> [#uses=1]
  %tmp9 = load float, ptr %tmp753		; <float> [#uses=1]
  %tmp11 = fmul float %tmp9, %x		; <float> [#uses=1]
  %tmp13 = fadd float %tmp11, 0.000000e+00		; <float> [#uses=1]
  %tmp17.sum52 = or i32 %tmp5, 1		; <i32> [#uses=1]
  %tmp1851 = getelementptr [128 x float], ptr %lookupTable, i32 0, i32 %tmp17.sum52		; <ptr> [#uses=1]
  %tmp19 = load float, ptr %tmp1851		; <float> [#uses=1]
  %tmp21 = fmul float %tmp19, %y		; <float> [#uses=1]
  %tmp23 = fadd float %tmp21, %tmp13		; <float> [#uses=1]
  %tmp27.sum50 = or i32 %tmp5, 2		; <i32> [#uses=1]
  %tmp2849 = getelementptr [128 x float], ptr %lookupTable, i32 0, i32 %tmp27.sum50		; <ptr> [#uses=1]
  %tmp29 = load float, ptr %tmp2849		; <float> [#uses=1]
  %tmp31 = fmul float %tmp29, %z		; <float> [#uses=1]
  %tmp33 = fadd float %tmp31, %tmp23		; <float> [#uses=1]
  %tmp37.sum48 = or i32 %tmp5, 3		; <i32> [#uses=1]
  %tmp3847 = getelementptr [128 x float], ptr %lookupTable, i32 0, i32 %tmp37.sum48		; <ptr> [#uses=1]
  %tmp39 = load float, ptr %tmp3847		; <float> [#uses=1]
  %tmp41 = fmul float %tmp39, %w		; <float> [#uses=1]
  %tmp43 = fadd float %tmp41, %tmp33		; <float> [#uses=1]
  ret float %tmp43
}

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) nocapture, ptr nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p0.p1.i64(ptr nocapture, ptr addrspace(1) nocapture, i64, i1) nounwind
declare void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) nocapture, ptr addrspace(1) nocapture, i64, i1) nounwind

%T = type { i8, [123 x i8] }
%U = type { i32, i32, i32, i32, i32 }

@G = constant %T {i8 1, [123 x i8] zeroinitializer }
@H = constant [2 x %U] zeroinitializer, align 16
@I = internal addrspace(1) constant [4 x float] zeroinitializer , align 4

define void @test2() {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[B:%.*]] = alloca [[T:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(124) [[B]], ptr noundef nonnull align 16 dereferenceable(124) @G, i64 124, i1 false)
; CHECK-NEXT:    call void @bar(ptr nonnull [[B]])
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  %B = alloca %T


; %A alloca is deleted

; use @G instead of %A
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @G, i64 124, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %B, ptr align 4 %A, i64 124, i1 false)
  call void @bar(ptr %B)
  ret void
}

define void @test2_no_null_opt() #0 {
; CHECK-LABEL: @test2_no_null_opt(
; CHECK-NEXT:    [[B:%.*]] = alloca [[T:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(124) [[B]], ptr noundef nonnull align 16 dereferenceable(124) @G, i64 124, i1 false)
; CHECK-NEXT:    call void @bar(ptr nonnull [[B]])
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  %B = alloca %T


; %A alloca is deleted

; use @G instead of %A
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @G, i64 124, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %B, ptr align 4 %A, i64 124, i1 false)
  call void @bar(ptr %B)
  ret void
}

define void @test2_addrspacecast() {
; CHECK-LABEL: @test2_addrspacecast(
; CHECK-NEXT:    [[B:%.*]] = alloca [[T:%.*]], align 8
; CHECK-NEXT:    [[B_CAST:%.*]] = addrspacecast ptr [[B]] to ptr addrspace(1)
; CHECK-NEXT:    call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) noundef align 4 dereferenceable(124) [[B_CAST]], ptr addrspace(1) noundef align 4 dereferenceable(124) addrspacecast (ptr @G to ptr addrspace(1)), i64 124, i1 false)
; CHECK-NEXT:    call void @bar_as1(ptr addrspace(1) [[B_CAST]])
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  %B = alloca %T
  %a.cast = addrspacecast ptr %A to ptr addrspace(1)
  %b.cast = addrspacecast ptr %B to ptr addrspace(1)


; %A alloca is deleted
; This doesn't exactly match what test2 does, because folding the type
; cast into the alloca doesn't work for the addrspacecast yet.

; use @G instead of %A
  call void @llvm.memcpy.p1.p0.i64(ptr addrspace(1) align 4 %a.cast, ptr align 4 @G, i64 124, i1 false)
  call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) align 4 %b.cast, ptr addrspace(1) align 4 %a.cast, i64 124, i1 false)
  call void @bar_as1(ptr addrspace(1) %b.cast)
  ret void
}

declare void @bar(ptr)
declare void @bar_as1(ptr addrspace(1))


;; Should be able to eliminate the alloca.
define void @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    call void @bar(ptr nonnull @G) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @G, i64 124, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}

define void @test3_addrspacecast() {
; CHECK-LABEL: @test3_addrspacecast(
; CHECK-NEXT:    call void @bar(ptr nonnull @G) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %A, ptr addrspace(1) align 4 addrspacecast (ptr @G to ptr addrspace(1)), i64 124, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}


define void @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    call void @baz(ptr nonnull byval(i8) @G)
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @G, i64 124, i1 false)
  call void @baz(ptr byval(i8) %A)
  ret void
}

declare void @llvm.lifetime.start.p0(i64, ptr)
define void @test5() {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    call void @baz(ptr nonnull byval(i8) @G)
; CHECK-NEXT:    ret void
;
  %A = alloca %T
  call void @llvm.lifetime.start.p0(i64 -1, ptr %A)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @G, i64 124, i1 false)
  call void @baz(ptr byval(i8) %A)
  ret void
}


declare void @baz(ptr byval(i8))


define void @test6() {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    call void @bar(ptr nonnull @H) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %A = alloca %U, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %A, ptr align 16 @H, i64 20, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}

define void @test7() {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    call void @bar(ptr nonnull @H) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %A = alloca %U, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 @H, i64 20, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}

define void @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[AL:%.*]] = alloca [[U:%.*]], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(20) [[AL]], ptr noundef nonnull align 4 dereferenceable(20) getelementptr inbounds ([2 x %U], ptr @H, i64 0, i64 1), i64 20, i1 false)
; CHECK-NEXT:    call void @bar(ptr nonnull [[AL]]) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %al = alloca %U, align 16
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %al, ptr align 4 getelementptr ([2 x %U], ptr @H, i64 0, i32 1), i64 20, i1 false)
  call void @bar(ptr %al) readonly
  ret void
}


define void @test8_addrspacecast() {
; CHECK-LABEL: @test8_addrspacecast(
; CHECK-NEXT:    [[AL:%.*]] = alloca [[U:%.*]], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0.p1.i64(ptr noundef nonnull align 16 dereferenceable(20) [[AL]], ptr addrspace(1) noundef align 4 dereferenceable(20) addrspacecast (ptr getelementptr inbounds ([2 x %U], ptr @H, i64 0, i64 1) to ptr addrspace(1)), i64 20, i1 false)
; CHECK-NEXT:    call void @bar(ptr nonnull [[AL]]) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %Al = alloca %U, align 16
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %Al, ptr addrspace(1) align 4 addrspacecast (ptr getelementptr ([2 x %U], ptr @H, i64 0, i32 1) to ptr addrspace(1)), i64 20, i1 false)
  call void @bar(ptr %Al) readonly
  ret void
}

define void @test9() {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    call void @bar(ptr nonnull getelementptr inbounds ([2 x %U], ptr @H, i64 0, i64 1)) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %A = alloca %U, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %A, ptr align 4 getelementptr ([2 x %U], ptr @H, i64 0, i32 1), i64 20, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}

define void @test9_addrspacecast() {
; CHECK-LABEL: @test9_addrspacecast(
; CHECK-NEXT:    call void @bar(ptr nonnull getelementptr inbounds ([2 x %U], ptr @H, i64 0, i64 1)) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  %A = alloca %U, align 4
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %A, ptr addrspace(1) align 4 addrspacecast (ptr getelementptr ([2 x %U], ptr @H, i64 0, i32 1) to ptr addrspace(1)), i64 20, i1 false)
  call void @bar(ptr %A) readonly
  ret void
}

@bbb = local_unnamed_addr global [1000000 x i8] zeroinitializer, align 16
@_ZL3KKK = internal unnamed_addr constant [3 x i8] c"\01\01\02", align 1

; Should not replace alloca with global because of size mismatch.
define void @test9_small_global() {
; CHECK-LABEL: @test9_small_global(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CC:%.*]] = alloca [1000000 x i8], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(3) [[CC]], ptr noundef nonnull align 16 dereferenceable(3) @_ZL3KKK, i64 3, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(1000000) @bbb, ptr noundef nonnull align 16 dereferenceable(1000000) [[CC]], i64 1000000, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %cc = alloca [1000000 x i8], align 16
  call void @llvm.memcpy.p0.p0.i64(ptr %cc, ptr @_ZL3KKK, i64 3, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 @bbb, ptr align 16 %cc, i64 1000000, i1 false)
  ret void
}

; Should replace alloca with global as they have exactly the same size.
define void @test10_same_global() {
; CHECK-LABEL: @test10_same_global(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(3) @bbb, ptr noundef nonnull align 16 dereferenceable(3) @_ZL3KKK, i64 3, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %cc = alloca [3 x i8], align 1
  call void @llvm.memcpy.p0.p0.i64(ptr %cc, ptr @_ZL3KKK, i64 3, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr @bbb, ptr %cc, i64 3, i1 false)
  ret void
}

; Should replace alloca with global even when the global is in a different address space
define float @test11(i64 %i) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[G:%.*]] = getelementptr [4 x float], ptr addrspace(1) @I, i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[R:%.*]] = load float, ptr addrspace(1) [[G]], align 4
; CHECK-NEXT:    ret float [[R]]
;

entry:
  %a = alloca [4 x float], align 4
  call void @llvm.lifetime.start.p0(i64 16, ptr %a)
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %a, ptr addrspace(1) align 4 @I, i64 16, i1 false)
  %g = getelementptr inbounds [4 x float], ptr %a, i64 0, i64 %i
  %r = load float, ptr %g, align 4
  ret float %r
}

; If the memcpy is volatile, it should not be removed
define float @test11_volatile(i64 %i) {
; CHECK-LABEL: @test11_volatile(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca [4 x float], align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 16, ptr nonnull [[A]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p1.i64(ptr align 4 [[A]], ptr addrspace(1) align 4 @I, i64 16, i1 true)
; CHECK-NEXT:    [[G:%.*]] = getelementptr inbounds [4 x float], ptr [[A]], i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[R:%.*]] = load float, ptr [[G]], align 4
; CHECK-NEXT:    ret float [[R]]
;

entry:
  %a = alloca [4 x float], align 4
  call void @llvm.lifetime.start.p0(i64 16, ptr %a)
  call void @llvm.memcpy.p0.p1.i64(ptr align 4 %a, ptr addrspace(1) align 4 @I, i64 16, i1 true)
  %g = getelementptr inbounds [4 x float], ptr %a, i64 0, i64 %i
  %r = load float, ptr %g, align 4
  ret float %r
}

attributes #0 = { null_pointer_is_valid }
