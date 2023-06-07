; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=objc-arc -S < %s | FileCheck %s

declare i8* @llvm.objc.initWeak(i8**, i8*)
declare i8* @llvm.objc.storeWeak(i8**, i8*)
declare i8* @llvm.objc.loadWeak(i8**)
declare void @llvm.objc.destroyWeak(i8**)
declare i8* @llvm.objc.loadWeakRetained(i8**)
declare void @llvm.objc.moveWeak(i8**, i8**)
declare void @llvm.objc.copyWeak(i8**, i8**)

; If the pointer-to-weak-pointer is null, it's undefined behavior.

define void @test0(i8* %p, i8** %q) {
; CHECK-LABEL: @test0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    store i1 true, i1* undef, align 1
; CHECK-NEXT:    ret void
;
entry:
  call i8* @llvm.objc.storeWeak(i8** null, i8* %p)
  call i8* @llvm.objc.storeWeak(i8** undef, i8* %p)
  call i8* @llvm.objc.loadWeakRetained(i8** null)
  call i8* @llvm.objc.loadWeakRetained(i8** undef)
  call i8* @llvm.objc.loadWeak(i8** null)
  call i8* @llvm.objc.loadWeak(i8** undef)
  call i8* @llvm.objc.initWeak(i8** null, i8* %p)
  call i8* @llvm.objc.initWeak(i8** undef, i8* %p)
  call void @llvm.objc.destroyWeak(i8** null)
  call void @llvm.objc.destroyWeak(i8** undef)

  call void @llvm.objc.copyWeak(i8** null, i8** %q)
  call void @llvm.objc.copyWeak(i8** undef, i8** %q)
  call void @llvm.objc.copyWeak(i8** %q, i8** null)
  call void @llvm.objc.copyWeak(i8** %q, i8** undef)

  call void @llvm.objc.moveWeak(i8** null, i8** %q)
  call void @llvm.objc.moveWeak(i8** undef, i8** %q)
  call void @llvm.objc.moveWeak(i8** %q, i8** null)
  call void @llvm.objc.moveWeak(i8** %q, i8** undef)

  ret void
}
