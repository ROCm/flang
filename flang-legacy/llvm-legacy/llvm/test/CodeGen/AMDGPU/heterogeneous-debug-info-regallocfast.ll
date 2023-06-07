; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs -stop-after=regallocfast %s -o - | FileCheck %s

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.def(metadata, metadata) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.kill(metadata) #0

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local i32 @single_block_referrer_live_until_terminator() #1 !dbg !5 {
  ; CHECK-LABEL: name: single_block_referrer_live_until_terminator
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   DBG_DEF !8, renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY killed renamable $sgpr4, debug-location !11
  ; CHECK-NEXT:   DBG_KILL !8
  ; CHECK-NEXT:   SI_RETURN implicit killed $vgpr0, debug-location !11
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void @llvm.dbg.def(metadata !8, metadata i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void asm sideeffect "S_NOP 1", ""()
  ret i32 %0, !dbg !11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local i32 @single_block_referrer_live_until_kill() #1 !dbg !12 {
  ; CHECK-LABEL: name: single_block_referrer_live_until_kill
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   DBG_DEF !13, renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_KILL !13
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY killed renamable $sgpr4, debug-location !15
  ; CHECK-NEXT:   SI_RETURN implicit killed $vgpr0, debug-location !15
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void @llvm.dbg.def(metadata !13, metadata i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void @llvm.dbg.kill(metadata !13)
  call void asm sideeffect "S_NOP 1", ""()
  ret i32 %0, !dbg !15
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @single_block_dangling_referrer_live_until_terminator() #1 !dbg !16 {
  ; CHECK-LABEL: name: single_block_dangling_referrer_live_until_terminator
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_DEF !17, renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_KILL !17
  ; CHECK-NEXT:   SI_RETURN debug-location !19
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1", ""()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void @llvm.dbg.def(metadata !17, metadata i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  ret void, !dbg !19
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @single_block_dangling_referrer_live_until_kill() #1 !dbg !20 {
  ; CHECK-LABEL: name: single_block_dangling_referrer_live_until_kill
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_DEF !21, renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_KILL !21
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   SI_RETURN debug-location !23
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1", ""()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void @llvm.dbg.def(metadata !21, metadata i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void @llvm.dbg.kill(metadata !21)
  call void asm sideeffect "S_NOP 1", ""()
  ret void, !dbg !23
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @single_block_dangling_referrer_live_until_clobber() #1 !dbg !24 {
  ; CHECK-LABEL: name: single_block_dangling_referrer_live_until_clobber
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   DBG_DEF !25, renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; clobber s4", 1 /* sideeffect attdialect */, 12 /* clobber */, implicit-def dead early-clobber $sgpr4
  ; CHECK-NEXT:   DBG_KILL !25
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1", 1 /* sideeffect attdialect */
  ; CHECK-NEXT:   SI_RETURN debug-location !27
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1", ""()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void @llvm.dbg.def(metadata !25, metadata i32 %0)
  call void asm sideeffect "S_NOP 1", ""()
  call void asm sideeffect "S_NOP 1 ; clobber s4", "~{s4}"()
  call void asm sideeffect "S_NOP 1", ""()
  ret void, !dbg !27
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @multi_block_dangling_referrer_kill_before() #1 !dbg !28 {
  ; CHECK-LABEL: name: multi_block_dangling_referrer_kill_before
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.def:
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   DBG_DEF !29, renamable $sgpr4
  ; CHECK-NEXT:   DBG_KILL !29
  ; CHECK-NEXT:   S_BRANCH %bb.2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.exit:
  ; CHECK-NEXT:   SI_RETURN debug-location !31
entry:
  call void @llvm.dbg.kill(metadata !29)
  br label %def

def:                                              ; preds = %entry
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void @llvm.dbg.def(metadata !29, metadata i32 %0)
  br label %exit

exit:                                             ; preds = %def
  ret void, !dbg !31
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @multi_block_dangling_referrer_kill_after() #1 !dbg !32 {
  ; CHECK-LABEL: name: multi_block_dangling_referrer_kill_after
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.def:
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   DBG_DEF !33, renamable $sgpr4
  ; CHECK-NEXT:   DBG_KILL !33
  ; CHECK-NEXT:   S_BRANCH %bb.2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.exit:
  ; CHECK-NEXT:   SI_RETURN debug-location !35
entry:
  br label %def

def:                                              ; preds = %entry
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void @llvm.dbg.def(metadata !33, metadata i32 %0)
  br label %exit

exit:                                             ; preds = %def
  call void @llvm.dbg.kill(metadata !33)
  ret void, !dbg !35
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @drop_dangling_with_kill_before() #1 !dbg !36 {
  ; CHECK-LABEL: name: drop_dangling_with_kill_before
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.def:
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; clobber s4", 1 /* sideeffect attdialect */, 12 /* clobber */, implicit-def dead early-clobber $sgpr4
  ; CHECK-NEXT:   S_BRANCH %bb.2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.exit:
  ; CHECK-NEXT:   SI_RETURN debug-location !39
entry:
  call void @llvm.dbg.kill(metadata !37)
  br label %def

def:                                              ; preds = %entry
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1 ; clobber s4", "~{s4}"()
  call void @llvm.dbg.def(metadata !37, metadata i32 %0)
  br label %exit

exit:                                             ; preds = %def
  ret void, !dbg !39
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @drop_dangling_with_kill_after() #1 !dbg !40 {
  ; CHECK-LABEL: name: drop_dangling_with_kill_after
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.def:
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; clobber s4", 1 /* sideeffect attdialect */, 12 /* clobber */, implicit-def dead early-clobber $sgpr4
  ; CHECK-NEXT:   S_BRANCH %bb.2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.exit:
  ; CHECK-NEXT:   SI_RETURN debug-location !43
entry:
  br label %def

def:                                              ; preds = %entry
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1 ; clobber s4", "~{s4}"()
  call void @llvm.dbg.def(metadata !41, metadata i32 %0)
  br label %exit

exit:                                             ; preds = %def
  call void @llvm.dbg.kill(metadata !41)
  ret void, !dbg !43
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define dso_local void @drop_dangling_without_kill() #1 !dbg !44 {
  ; CHECK-LABEL: name: drop_dangling_without_kill
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; def $0", 1 /* sideeffect attdialect */, 2097162 /* regdef:SReg_32 */, def renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; use $0", 1 /* sideeffect attdialect */, 2097161 /* reguse:SReg_32 */, killed renamable $sgpr4
  ; CHECK-NEXT:   INLINEASM &"S_NOP 1 ; clobber s4", 1 /* sideeffect attdialect */, 12 /* clobber */, implicit-def dead early-clobber $sgpr4
  ; CHECK-NEXT:   SI_RETURN debug-location !47
entry:
  %0 = call i32 asm sideeffect "S_NOP 1 ; def $0", "=r"()
  call void asm sideeffect "S_NOP 1 ; use $0", "r"(i32 %0)
  call void asm sideeffect "S_NOP 1 ; clobber s4", "~{s4}"()
  call void @llvm.dbg.def(metadata !45, metadata i32 %0)
  ret void, !dbg !47
}

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #1 = { convergent mustprogress noinline nounwind optnone "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="gfx900" "target-features"="+16-bit-insts,+ci-insts,+dpp,+flat-address-space,+gfx8-insts,+gfx9-insts,+s-memrealtime,+s-memtime-inst" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}
!llvm.ident = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 15.0.0 (ssh://slinder1@gerrit-git.amd.com:29418/lightning/ec/llvm-project 279c53d1096f0d6c96f4f3060357c56eaa921587)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "<stdin>", directory: "/home/slinder1/llvm-project/amd-stg-open")
!2 = !{i32 2, !"Debug Info Version", i32 4}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{!"clang version 15.0.0 (ssh://slinder1@gerrit-git.amd.com:29418/lightning/ec/llvm-project 279c53d1096f0d6c96f4f3060357c56eaa921587)"}
!5 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!6 = !DISubroutineType(types: !7)
!7 = !{}
!8 = distinct !DILifetime(object: !9, location: !DIExpr(DIOpReferrer(i32)))
!9 = !DILocalVariable(scope: !5, type: !10)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 1, column: 35, scope: !5)
!12 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!13 = distinct !DILifetime(object: !14, location: !DIExpr(DIOpReferrer(i32)))
!14 = !DILocalVariable(scope: !12, type: !10)
!15 = !DILocation(line: 1, column: 35, scope: !12)
!16 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!17 = distinct !DILifetime(object: !18, location: !DIExpr(DIOpReferrer(i32)))
!18 = !DILocalVariable(scope: !16, type: !10)
!19 = !DILocation(line: 1, column: 35, scope: !16)
!20 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!21 = distinct !DILifetime(object: !22, location: !DIExpr(DIOpReferrer(i32)))
!22 = !DILocalVariable(scope: !20, type: !10)
!23 = !DILocation(line: 1, column: 35, scope: !20)
!24 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!25 = distinct !DILifetime(object: !26, location: !DIExpr(DIOpReferrer(i32)))
!26 = !DILocalVariable(scope: !24, type: !10)
!27 = !DILocation(line: 1, column: 35, scope: !24)
!28 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!29 = distinct !DILifetime(object: !30, location: !DIExpr(DIOpReferrer(i32)))
!30 = !DILocalVariable(scope: !28, type: !10)
!31 = !DILocation(line: 1, column: 35, scope: !28)
!32 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!33 = distinct !DILifetime(object: !34, location: !DIExpr(DIOpReferrer(i32)))
!34 = !DILocalVariable(scope: !32, type: !10)
!35 = !DILocation(line: 1, column: 35, scope: !32)
!36 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!37 = distinct !DILifetime(object: !38, location: !DIExpr(DIOpReferrer(i32)))
!38 = !DILocalVariable(scope: !36, type: !10)
!39 = !DILocation(line: 1, column: 35, scope: !36)
!40 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!41 = distinct !DILifetime(object: !42, location: !DIExpr(DIOpReferrer(i32)))
!42 = !DILocalVariable(scope: !40, type: !10)
!43 = !DILocation(line: 1, column: 35, scope: !40)
!44 = distinct !DISubprogram(scope: null, type: !6, spFlags: DISPFlagDefinition, unit: !0)
!45 = distinct !DILifetime(object: !46, location: !DIExpr(DIOpReferrer(i32)))
!46 = !DILocalVariable(scope: !44, type: !10)
!47 = !DILocation(line: 1, column: 35, scope: !44)
