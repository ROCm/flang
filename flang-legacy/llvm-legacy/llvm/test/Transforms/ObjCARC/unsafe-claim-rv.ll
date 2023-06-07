; RUN: opt -passes=objc-arc -S < %s | FileCheck %s

; Generated by compiling:
;
; id baz(void *X) { return (__bridge_transfer id)X; }
; 
; void foo(id X) {
; void *Y = 0;
; if (X)
;   Y = (__bridge_retained void *)X;
; baz(Y);
; }
;
; clang -x objective-c -mllvm -enable-objc-arc-opts=0 -fobjc-arc -S -emit-llvm test.m
;
; And then hand-reduced further. 

declare i8* @llvm.objc.autoreleaseReturnValue(i8*)
declare i8* @llvm.objc.unsafeClaimAutoreleasedReturnValue(i8*)
declare i8* @llvm.objc.retain(i8*)
declare void @llvm.objc.release(i8*)

define void @foo(i8* %X) {
entry:
  %0 = tail call i8* @llvm.objc.retain(i8* %X) 
  %tobool = icmp eq i8* %0, null
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %1 = tail call i8* @llvm.objc.retain(i8* nonnull %0)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %Y.0 = phi i8* [ %1, %if.then ], [ null, %entry ]
  %2 = tail call i8* @llvm.objc.autoreleaseReturnValue(i8* %Y.0)
  %3 = tail call i8* @llvm.objc.unsafeClaimAutoreleasedReturnValue(i8* %2)
  tail call void @llvm.objc.release(i8* %0) 
  ret void
}

; CHECK: if.then
; CHECK: tail call i8* @llvm.objc.retain
; CHECK: %Y.0 = phi
; CHECK-NEXT: tail call void @llvm.objc.release
; CHECK-NEXT: tail call void @llvm.objc.release

