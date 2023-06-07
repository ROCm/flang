; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --codegen-opt-level=2 -mtriple=x86_64 -lower-amx-type %s -S | FileCheck %s

define void @combine_amx_cast_inside_bb() {
; CHECK-LABEL: @combine_amx_cast_inside_bb(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP0]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %tmp)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %1)
  ret void
}

; Cases where amxcast can be combined across bb
; %5 and %6 is combined together since %goodphi's incoming is phi or amxcast
define void @combine_amx_cast_and_phi() {
; CHECK-LABEL: @combine_amx_cast_and_phi(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <110 x i32>* [[TMP2]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP2]], align 512
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP4]], i64 40)
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <616 x i8>* [[TMP1]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP1]], align 1024
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP6]], i64 56)
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast <560 x i8>* [[TMP0]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP9:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP8]], i64 40)
; CHECK-NEXT:    [[TMP10:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP5]], x86_amx [[TMP7]], x86_amx [[TMP9]])
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP_I_I]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[TMP11:%.*]] = phi x86_amx [ [[TMP3]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP10]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP11]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %4 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %1, x86_amx %2, x86_amx %3)
  %5 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %4)
  br label %for.cond.cleanup.i.i

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %goodphi = phi <110 x i32> [ %tmp, %wrapper_entry ], [ %5, %for.body.i.lr.ph.i ]
  %6 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %goodphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %6)
  ret void
}

; Cases where amxcast can't be combined across bb
; %5 and %6 is not combined together since %evilphi's incoming is not phi or amxcast
define void @fail_to_combine_amx_cast_and_phi(<110 x i32> %tmp) {
; CHECK-LABEL: @fail_to_combine_amx_cast_and_phi(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP4:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP5:%.*]] = add <110 x i32> [[TMP:%.*]], [[TMP]]
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <110 x i32>* [[TMP4]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP4]], align 512
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP6]], i64 40)
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast <616 x i8>* [[TMP3]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP3]], align 1024
; CHECK-NEXT:    [[TMP9:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP8]], i64 56)
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast <560 x i8>* [[TMP2]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP2]], align 1024
; CHECK-NEXT:    [[TMP11:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP10]], i64 40)
; CHECK-NEXT:    [[TMP12:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP7]], x86_amx [[TMP9]], x86_amx [[TMP11]])
; CHECK-NEXT:    [[TMP13:%.*]] = bitcast <110 x i32>* [[TMP1]] to i8*
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* [[TMP13]], i64 40, x86_amx [[TMP12]])
; CHECK-NEXT:    [[TMP14:%.*]] = load <110 x i32>, <110 x i32>* [[TMP1]], align 512
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP_I_I]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[EVILPHI:%.*]] = phi <110 x i32> [ [[TMP5]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP14]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    [[TMP15:%.*]] = bitcast <110 x i32>* [[TMP0]] to i8*
; CHECK-NEXT:    store <110 x i32> [[EVILPHI]], <110 x i32>* [[TMP0]], align 512
; CHECK-NEXT:    [[TMP16:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP15]], i64 40)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP16]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = add <110 x i32> %tmp, %tmp
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %4 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %1, x86_amx %2, x86_amx %3)
  %5 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %4)
  br label %for.cond.cleanup.i.i

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %evilphi = phi <110 x i32> [ %0, %wrapper_entry ], [ %5, %for.body.i.lr.ph.i ]
  %6 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %evilphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %6)
  ret void
}

; Cases where amxcast can't be combined across bb
; %5 and %6 is not combined together since %evilphi's user aka %evilphi2 is not inside phi web.
define void @fail_to_combine_amx_cast_and_phi2() {
; CHECK-LABEL: @fail_to_combine_amx_cast_and_phi2(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP4:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP5:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP6:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast <110 x i32>* [[TMP5]] to i8*
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* [[TMP7]], i64 40, x86_amx [[TMP6]])
; CHECK-NEXT:    [[TMP8:%.*]] = load <110 x i32>, <110 x i32>* [[TMP5]], align 512
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP9:%.*]] = bitcast <110 x i32>* [[TMP4]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP4]], align 512
; CHECK-NEXT:    [[TMP10:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP9]], i64 40)
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast <616 x i8>* [[TMP3]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP3]], align 1024
; CHECK-NEXT:    [[TMP12:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP11]], i64 56)
; CHECK-NEXT:    [[TMP13:%.*]] = bitcast <560 x i8>* [[TMP2]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP2]], align 1024
; CHECK-NEXT:    [[TMP14:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP13]], i64 40)
; CHECK-NEXT:    [[TMP15:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP10]], x86_amx [[TMP12]], x86_amx [[TMP14]])
; CHECK-NEXT:    [[TMP16:%.*]] = bitcast <110 x i32>* [[TMP1]] to i8*
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* [[TMP16]], i64 40, x86_amx [[TMP15]])
; CHECK-NEXT:    [[TMP17:%.*]] = load <110 x i32>, <110 x i32>* [[TMP1]], align 512
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I]], label [[EXIT:%.*]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[GOODPHI:%.*]] = phi <110 x i32> [ [[TMP8]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP17]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = bitcast <110 x i32>* [[TMP0]] to i8*
; CHECK-NEXT:    store <110 x i32> [[GOODPHI]], <110 x i32>* [[TMP0]], align 512
; CHECK-NEXT:    [[TMP19:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP18]], i64 40)
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP19]])
; CHECK-NEXT:    br i1 undef, label [[EXIT]], label [[FOR_BODY_I_LR_PH_I]]
; CHECK:       exit:
; CHECK-NEXT:    [[EVILPHI2:%.*]] = phi <110 x i32> [ [[GOODPHI]], [[FOR_COND_CLEANUP_I_I]] ], [ [[TMP17]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    store <110 x i32> [[EVILPHI2]], <110 x i32>* undef, align 512
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %4 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %1, x86_amx %2, x86_amx %3)
  %5 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %4)
  br i1 undef, label %for.cond.cleanup.i.i, label %exit

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %goodphi = phi <110 x i32> [ %tmp, %wrapper_entry ], [ %5, %for.body.i.lr.ph.i ]
  %6 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %goodphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %6)
  br i1 undef, label %exit, label %for.body.i.lr.ph.i
exit:
  %evilphi2 = phi <110 x i32> [ %goodphi, %for.cond.cleanup.i.i ], [ %5, %for.body.i.lr.ph.i ]
  store <110 x i32> %evilphi2, <110 x i32>* undef, align 512
  ret void
}

define void @fail_to_combine_amx_cast_and_phi_due_to_const_value() {
; CHECK-LABEL: @fail_to_combine_amx_cast_and_phi_due_to_const_value(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tilezero.internal(i16 11, i16 40)
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <110 x i32>* [[TMP2]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP2]], align 512
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP4]], i64 40)
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <616 x i8>* [[TMP1]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP1]], align 1024
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP6]], i64 56)
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast <560 x i8>* [[TMP0]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP9:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP8]], i64 40)
; CHECK-NEXT:    [[TMP10:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP5]], x86_amx [[TMP7]], x86_amx [[TMP9]])
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP_I_I]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[TMP11:%.*]] = phi x86_amx [ [[TMP3]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP10]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP11]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %0 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %3 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %0, x86_amx %1, x86_amx %2)
  %4 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %3)
  br label %for.cond.cleanup.i.i

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %evilphi = phi <110 x i32> [ undef, %wrapper_entry ], [ %4, %for.body.i.lr.ph.i ]
  %5 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %evilphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %5)
  ret void
}

; Cases where amxcast can be combined across bb
; When optimizeAMXCastFromPhi process %6 and %goodphi, %goodphi2 is outside the phi-web, so the optimization stop
; When optimizeAMXCastFromPhi process %7 and %goodphi2, the optimization continue.
define void @combine_amx_cast_and_multiple_phi() {
; CHECK-LABEL: @combine_amx_cast_and_multiple_phi(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <110 x i32>* [[TMP2]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP2]], align 512
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP4]], i64 40)
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <616 x i8>* [[TMP1]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP1]], align 1024
; CHECK-NEXT:    [[TMP7:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP6]], i64 56)
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast <560 x i8>* [[TMP0]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP9:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP8]], i64 40)
; CHECK-NEXT:    [[TMP10:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP5]], x86_amx [[TMP7]], x86_amx [[TMP9]])
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I]], label [[EXIT:%.*]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[TMP11:%.*]] = phi x86_amx [ [[TMP3]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP10]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP11]])
; CHECK-NEXT:    br i1 undef, label [[EXIT]], label [[FOR_BODY_I_LR_PH_I]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP12:%.*]] = phi x86_amx [ [[TMP11]], [[FOR_COND_CLEANUP_I_I]] ], [ [[TMP10]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP12]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %4 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %1, x86_amx %2, x86_amx %3)
  %5 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %4)
  br i1 undef, label %for.cond.cleanup.i.i, label %exit

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %goodphi = phi <110 x i32> [ %tmp, %wrapper_entry ], [ %5, %for.body.i.lr.ph.i ]
  %6 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %goodphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %6)
  br i1 undef, label %exit, label %for.body.i.lr.ph.i
exit:
  %evilphi2 = phi <110 x i32> [ %goodphi, %for.cond.cleanup.i.i ], [ %5, %for.body.i.lr.ph.i ]
  %7 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %evilphi2)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %7)
  ret void
}

; Currently we are not able to delete DeadPHICycle, later we will handle with them
define void @combine_amx_cast_and_phi_in_a_circle() {
; CHECK-LABEL: @combine_amx_cast_and_phi_in_a_circle(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <616 x i8>, align 64
; CHECK-NEXT:    [[TMP3:%.*]] = alloca <110 x i32>, align 64
; CHECK-NEXT:    [[TMP4:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <110 x i32>* [[TMP3]] to i8*
; CHECK-NEXT:    store <110 x i32> undef, <110 x i32>* [[TMP3]], align 512
; CHECK-NEXT:    [[TMP6:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* [[TMP5]], i64 40)
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast <616 x i8>* [[TMP2]] to i8*
; CHECK-NEXT:    store <616 x i8> undef, <616 x i8>* [[TMP2]], align 1024
; CHECK-NEXT:    [[TMP8:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* [[TMP7]], i64 56)
; CHECK-NEXT:    [[TMP9:%.*]] = bitcast <560 x i8>* [[TMP1]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP1]], align 1024
; CHECK-NEXT:    [[TMP10:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP9]], i64 40)
; CHECK-NEXT:    [[TMP11:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP6]], x86_amx [[TMP8]], x86_amx [[TMP10]])
; CHECK-NEXT:    [[TMP12:%.*]] = bitcast <110 x i32>* [[TMP0]] to i8*
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* [[TMP12]], i64 40, x86_amx [[TMP11]])
; CHECK-NEXT:    [[TMP13:%.*]] = load <110 x i32>, <110 x i32>* [[TMP0]], align 512
; CHECK-NEXT:    br i1 undef, label [[BB2:%.*]], label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP14:%.*]] = phi x86_amx [ [[TMP15:%.*]], [[BB3]] ], [ [[TMP11]], [[BB1]] ]
; CHECK-NEXT:    [[GOODPHI:%.*]] = phi <110 x i32> [ [[EVILPHI2:%.*]], [[BB3]] ], [ [[TMP13]], [[BB1]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP14]])
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[TMP15]] = phi x86_amx [ [[TMP14]], [[BB2]] ], [ [[TMP11]], [[BB1]] ]
; CHECK-NEXT:    [[EVILPHI2]] = phi <110 x i32> [ [[GOODPHI]], [[BB2]] ], [ [[TMP13]], [[BB1]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP15]])
; CHECK-NEXT:    br i1 undef, label [[BB2]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP15]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  br label %bb1

bb1:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> undef)
  %2 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> undef)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %4 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %1, x86_amx %2, x86_amx %3)
  %5 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %4)
  br i1 undef, label %bb2, label %bb3

bb2:                             ; preds = %bb1, %wrapper_entry
  %goodphi = phi <110 x i32> [ %evilphi2, %bb3], [ %5, %bb1 ]
  %6 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %goodphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %6)
  br label %bb3
bb3:
  %evilphi2 = phi <110 x i32> [ %goodphi, %bb2 ], [ %5, %bb1 ]
  %7 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %evilphi2)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %7)
  br i1 undef, label %bb2, label %exit
exit:
  %8 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %evilphi2)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %8)
  ret void
}

define void @eliminate_unused_phi_and_cast() {
; CHECK-LABEL: @eliminate_unused_phi_and_cast(
; CHECK-NEXT:  wrapper_entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca <560 x i8>, align 64
; CHECK-NEXT:    [[TMP1:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    br i1 undef, label [[FOR_COND_CLEANUP_I_I:%.*]], label [[FOR_BODY_I_LR_PH_I:%.*]]
; CHECK:       for.body.i.lr.ph.i:
; CHECK-NEXT:    [[TMP2:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* undef, i64 undef)
; CHECK-NEXT:    [[TMP3:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* undef, i64 undef)
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <560 x i8>* [[TMP0]] to i8*
; CHECK-NEXT:    store <560 x i8> undef, <560 x i8>* [[TMP0]], align 1024
; CHECK-NEXT:    [[TMP5:%.*]] = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* [[TMP4]], i64 40)
; CHECK-NEXT:    [[TMP6:%.*]] = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx [[TMP2]], x86_amx [[TMP3]], x86_amx [[TMP5]])
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP_I_I]]
; CHECK:       for.cond.cleanup.i.i:
; CHECK-NEXT:    [[TMP7:%.*]] = phi x86_amx [ [[TMP1]], [[WRAPPER_ENTRY:%.*]] ], [ [[TMP6]], [[FOR_BODY_I_LR_PH_I]] ]
; CHECK-NEXT:    call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx [[TMP7]])
; CHECK-NEXT:    ret void
;
wrapper_entry:
  %0 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 40, i8* undef, i64 undef)
  %tmp = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %0)
  br i1 undef, label %for.cond.cleanup.i.i, label %for.body.i.lr.ph.i

for.body.i.lr.ph.i:                               ; preds = %wrapper_entry
  %1 = call x86_amx @llvm.x86.tileloadd64.internal(i16 11, i16 56, i8* undef, i64 undef)
  %v1 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %1)
  %2 = call x86_amx @llvm.x86.tileloadd64.internal(i16 14, i16 40, i8* undef, i64 undef)
  %v2 = call <616 x i8> @llvm.x86.cast.tile.to.vector.v616i8(x86_amx %2)
  %3 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %v1)
  %4 = call x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8> %v2)
  %5 = call x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8> undef)
  %6 = call x86_amx @llvm.x86.tdpbssd.internal(i16 11, i16 40, i16 56, x86_amx %3, x86_amx %4, x86_amx %5)
  %7 = call <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx %6)
  br label %for.cond.cleanup.i.i

for.cond.cleanup.i.i:                             ; preds = %for.body.i.lr.ph.i, %wrapper_entry
  %goodphi = phi <110 x i32> [ %tmp, %wrapper_entry ], [ %7, %for.body.i.lr.ph.i ]
  %8 = call x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32> %goodphi)
  call void @llvm.x86.tilestored64.internal(i16 11, i16 40, i8* undef, i64 undef, x86_amx %8)
  ret void
}

declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, i8*, i64)
declare <110 x i32> @llvm.x86.cast.tile.to.vector.v110i32(x86_amx)
declare <616 x i8> @llvm.x86.cast.tile.to.vector.v616i8(x86_amx)
declare x86_amx @llvm.x86.cast.vector.to.tile.v110i32(<110 x i32>)
declare void @llvm.x86.tilestored64.internal(i16, i16, i8*, i64, x86_amx)
declare x86_amx @llvm.x86.cast.vector.to.tile.v616i8(<616 x i8>)
declare x86_amx @llvm.x86.cast.vector.to.tile.v560i8(<560 x i8>)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
