; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix \
; RUN:   -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-AIX

define dso_local zeroext i8 @test1(ptr noundef %addr, i8 noundef zeroext %newval) local_unnamed_addr #0 {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -32(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    stbcx. 4, 0, 3
; CHECK-NEXT:    bne 0, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    bl dummy
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB0_2: # %if.end
; CHECK-NEXT:    li 3, 55
; CHECK-NEXT:    addi 1, 1, 32
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test1:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    mflr 0
; CHECK-AIX-NEXT:    std 0, 16(1)
; CHECK-AIX-NEXT:    stdu 1, -112(1)
; CHECK-AIX-NEXT:    stbcx. 4, 0, 3
; CHECK-AIX-NEXT:    bne 0, L..BB0_2
; CHECK-AIX-NEXT:  # %bb.1: # %if.then
; CHECK-AIX-NEXT:    bl .dummy[PR]
; CHECK-AIX-NEXT:    nop
; CHECK-AIX-NEXT:  L..BB0_2: # %if.end
; CHECK-AIX-NEXT:    li 3, 55
; CHECK-AIX-NEXT:    addi 1, 1, 112
; CHECK-AIX-NEXT:    ld 0, 16(1)
; CHECK-AIX-NEXT:    mtlr 0
; CHECK-AIX-NEXT:    blr
entry:
  %conv = zext i8 %newval to i32
  %0 = tail call i32 @llvm.ppc.stbcx(ptr %addr, i32 %conv)
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @dummy() #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i8 55
}

define dso_local signext i16 @test2(ptr noundef %addr, i16 noundef signext %newval) local_unnamed_addr #0 {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -32(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    sthcx. 4, 0, 3
; CHECK-NEXT:    bne 0, .LBB1_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    bl dummy
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB1_2: # %if.end
; CHECK-NEXT:    li 3, 55
; CHECK-NEXT:    addi 1, 1, 32
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test2:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    mflr 0
; CHECK-AIX-NEXT:    std 0, 16(1)
; CHECK-AIX-NEXT:    stdu 1, -112(1)
; CHECK-AIX-NEXT:    sthcx. 4, 0, 3
; CHECK-AIX-NEXT:    bne 0, L..BB1_2
; CHECK-AIX-NEXT:  # %bb.1: # %if.then
; CHECK-AIX-NEXT:    bl .dummy[PR]
; CHECK-AIX-NEXT:    nop
; CHECK-AIX-NEXT:  L..BB1_2: # %if.end
; CHECK-AIX-NEXT:    li 3, 55
; CHECK-AIX-NEXT:    addi 1, 1, 112
; CHECK-AIX-NEXT:    ld 0, 16(1)
; CHECK-AIX-NEXT:    mtlr 0
; CHECK-AIX-NEXT:    blr
entry:
  %0 = sext i16 %newval to i32
  %1 = tail call i32 @llvm.ppc.sthcx(ptr %addr, i32 %0)
  %tobool.not = icmp eq i32 %1, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @dummy() #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i16 55
}

define dso_local signext i32 @test3(ptr noundef %addr, i32 noundef signext %newval) local_unnamed_addr #0 {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -32(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    stwcx. 4, 0, 3
; CHECK-NEXT:    bne 0, .LBB2_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    bl dummy
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB2_2: # %if.end
; CHECK-NEXT:    li 3, 55
; CHECK-NEXT:    addi 1, 1, 32
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test3:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    mflr 0
; CHECK-AIX-NEXT:    std 0, 16(1)
; CHECK-AIX-NEXT:    stdu 1, -112(1)
; CHECK-AIX-NEXT:    stwcx. 4, 0, 3
; CHECK-AIX-NEXT:    bne 0, L..BB2_2
; CHECK-AIX-NEXT:  # %bb.1: # %if.then
; CHECK-AIX-NEXT:    bl .dummy[PR]
; CHECK-AIX-NEXT:    nop
; CHECK-AIX-NEXT:  L..BB2_2: # %if.end
; CHECK-AIX-NEXT:    li 3, 55
; CHECK-AIX-NEXT:    addi 1, 1, 112
; CHECK-AIX-NEXT:    ld 0, 16(1)
; CHECK-AIX-NEXT:    mtlr 0
; CHECK-AIX-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.ppc.stwcx(ptr %addr, i32 %newval)
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @dummy() #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 55
}

define dso_local i64 @test4(ptr noundef %addr, i64 noundef %newval) local_unnamed_addr #0 {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 0, 16(1)
; CHECK-NEXT:    stdu 1, -32(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    stdcx. 4, 0, 3
; CHECK-NEXT:    bne 0, .LBB3_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    bl dummy
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB3_2: # %if.end
; CHECK-NEXT:    li 3, 55
; CHECK-NEXT:    addi 1, 1, 32
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: test4:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    mflr 0
; CHECK-AIX-NEXT:    std 0, 16(1)
; CHECK-AIX-NEXT:    stdu 1, -112(1)
; CHECK-AIX-NEXT:    stdcx. 4, 0, 3
; CHECK-AIX-NEXT:    bne 0, L..BB3_2
; CHECK-AIX-NEXT:  # %bb.1: # %if.then
; CHECK-AIX-NEXT:    bl .dummy[PR]
; CHECK-AIX-NEXT:    nop
; CHECK-AIX-NEXT:  L..BB3_2: # %if.end
; CHECK-AIX-NEXT:    li 3, 55
; CHECK-AIX-NEXT:    addi 1, 1, 112
; CHECK-AIX-NEXT:    ld 0, 16(1)
; CHECK-AIX-NEXT:    mtlr 0
; CHECK-AIX-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.ppc.stdcx(ptr %addr, i64 %newval)
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @dummy() #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i64 55
}

declare i32 @llvm.ppc.stbcx(ptr, i32) #1
declare i32 @llvm.ppc.sthcx(ptr, i32) #1
declare i32 @llvm.ppc.stwcx(ptr, i32) #1
declare i32 @llvm.ppc.stdcx(ptr, i64) #1
declare void @dummy(...) local_unnamed_addr #2
