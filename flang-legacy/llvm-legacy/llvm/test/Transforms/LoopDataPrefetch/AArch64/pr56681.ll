; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --loop-data-prefetch --prefetch-distance=3000 -debug-only=loop-data-prefetch -S < %s 2>&1 | FileCheck %s

; REQUIRES: asserts

; CHECK:  Please set both PrefetchDistance and CacheLineSize for loop data prefetch

define void @calc() {
; CHECK-LABEL: @calc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  ret void
}
