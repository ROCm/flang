; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs\
; RUN:       -mcpu=pwr9 --ppc-enable-pipeliner 2>&1 | FileCheck %s

%0 = type { double, double, double, i32, i32 }
declare i8* @malloc() local_unnamed_addr

define void @phi3(i32*) nounwind {
; CHECK-LABEL: phi3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 29, -24(1) # 8-byte Folded Spill
; CHECK-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -64(1)
; CHECK-NEXT:    mr 30, 3
; CHECK-NEXT:    bl malloc
; CHECK-NEXT:    nop
; CHECK-NEXT:    mr 29, 3
; CHECK-NEXT:    bl malloc
; CHECK-NEXT:    nop
; CHECK-NEXT:    addi 7, 30, -4
; CHECK-NEXT:    mtctr 3
; CHECK-NEXT:    addi 4, 29, -8
; CHECK-NEXT:    li 5, 0
; CHECK-NEXT:    lwzu 8, 4(7)
; CHECK-NEXT:    bdz .LBB0_5
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    extswsli 6, 5, 5
; CHECK-NEXT:    add 5, 8, 5
; CHECK-NEXT:    lwzu 8, 4(7)
; CHECK-NEXT:    bdz .LBB0_4
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    add 6, 3, 6
; CHECK-NEXT:    stdu 6, 8(4)
; CHECK-NEXT:    extswsli 6, 5, 5
; CHECK-NEXT:    add 5, 8, 5
; CHECK-NEXT:    lwzu 8, 4(7)
; CHECK-NEXT:    bdz .LBB0_4
; CHECK-NEXT:    .p2align 5
; CHECK-NEXT:  .LBB0_3: #
; CHECK-NEXT:    add 9, 3, 6
; CHECK-NEXT:    extswsli 6, 5, 5
; CHECK-NEXT:    add 5, 8, 5
; CHECK-NEXT:    lwzu 8, 4(7)
; CHECK-NEXT:    stdu 9, 8(4)
; CHECK-NEXT:    bdnz .LBB0_3
; CHECK-NEXT:  .LBB0_4:
; CHECK-NEXT:    add 6, 3, 6
; CHECK-NEXT:    stdu 6, 8(4)
; CHECK-NEXT:  .LBB0_5:
; CHECK-NEXT:    extswsli 5, 5, 5
; CHECK-NEXT:    add 3, 3, 5
; CHECK-NEXT:    stdu 3, 8(4)
; CHECK-NEXT:    addi 1, 1, 64
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-NEXT:    ld 29, -24(1) # 8-byte Folded Reload
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
  %2 = tail call noalias i8* @malloc()
  %3 = bitcast i8* %2 to %0**
  %4 = tail call noalias i8* @malloc()
  %5 = bitcast i8* %4 to %0*
  br label %6

6:                                                ; preds = %6, %1
  %7 = phi i64 [ %16, %6 ], [ 0, %1 ]
  %8 = phi i32 [ %15, %6 ], [ 0, %1 ]
  %9 = phi i64 [ %17, %6 ], [ undef, %1 ]
  %10 = sext i32 %8 to i64
  %11 = getelementptr inbounds %0, %0* %5, i64 %10
  %12 = getelementptr inbounds %0*, %0** %3, i64 %7
  store %0* %11, %0** %12, align 8
  %13 = getelementptr inbounds i32, i32* %0, i64 %7
  %14 = load i32, i32* %13, align 4
  %15 = add nsw i32 %14, %8
  %16 = add nuw nsw i64 %7, 1
  %17 = add i64 %9, -1
  %18 = icmp eq i64 %17, 0
  br i1 %18, label %19, label %6

19:                                               ; preds = %6
  ret void
}
