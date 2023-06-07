; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -S -passes=msan 2>&1 | FileCheck %s

target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define <2 x double> @test_x86_sse41_blendvpd(<2 x double> %a0, <2 x double> %a1, <2 x double> %a2) #0 {
; CHECK-LABEL: @test_x86_sse41_blendvpd(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSPROP:%.*]] = or <2 x i64> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[_MSPROP1:%.*]] = or <2 x i64> [[_MSPROP]], [[TMP3]]
; CHECK-NEXT:    [[RES:%.*]] = call <2 x double> @llvm.x86.sse41.blendvpd(<2 x double> [[A0:%.*]], <2 x double> [[A1:%.*]], <2 x double> [[A2:%.*]])
; CHECK-NEXT:    store <2 x i64> [[_MSPROP1]], <2 x i64>* bitcast ([100 x i64]* @__msan_retval_tls to <2 x i64>*), align 8
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
  %res = call <2 x double> @llvm.x86.sse41.blendvpd(<2 x double> %a0, <2 x double> %a1, <2 x double> %a2) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.blendvpd(<2 x double>, <2 x double>, <2 x double>) nounwind readnone


define <4 x float> @test_x86_sse41_blendvps(<4 x float> %a0, <4 x float> %a1, <4 x float> %a2) #0 {
; CHECK-LABEL: @test_x86_sse41_blendvps(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <4 x i32>*), align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i32>, <4 x i32>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSPROP:%.*]] = or <4 x i32> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[_MSPROP1:%.*]] = or <4 x i32> [[_MSPROP]], [[TMP3]]
; CHECK-NEXT:    [[RES:%.*]] = call <4 x float> @llvm.x86.sse41.blendvps(<4 x float> [[A0:%.*]], <4 x float> [[A1:%.*]], <4 x float> [[A2:%.*]])
; CHECK-NEXT:    store <4 x i32> [[_MSPROP1]], <4 x i32>* bitcast ([100 x i64]* @__msan_retval_tls to <4 x i32>*), align 8
; CHECK-NEXT:    ret <4 x float> [[RES]]
;
  %res = call <4 x float> @llvm.x86.sse41.blendvps(<4 x float> %a0, <4 x float> %a1, <4 x float> %a2) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.blendvps(<4 x float>, <4 x float>, <4 x float>) nounwind readnone


define <2 x double> @test_x86_sse41_dppd(<2 x double> %a0, <2 x double> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_dppd(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <2 x i64> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP3]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <2 x i64> [[TMP2]] to i128
; CHECK-NEXT:    [[_MSCMP1:%.*]] = icmp ne i128 [[TMP4]], 0
; CHECK-NEXT:    [[_MSOR:%.*]] = or i1 [[_MSCMP]], [[_MSCMP1]]
; CHECK-NEXT:    br i1 [[_MSOR]], label [[TMP5:%.*]], label [[TMP6:%.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       5:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4:[0-9]+]]
; CHECK-NEXT:    unreachable
; CHECK:       6:
; CHECK-NEXT:    [[RES:%.*]] = call <2 x double> @llvm.x86.sse41.dppd(<2 x double> [[A0:%.*]], <2 x double> [[A1:%.*]], i8 7)
; CHECK-NEXT:    store <2 x i64> zeroinitializer, <2 x i64>* bitcast ([100 x i64]* @__msan_retval_tls to <2 x i64>*), align 8
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
  %res = call <2 x double> @llvm.x86.sse41.dppd(<2 x double> %a0, <2 x double> %a1, i8 7) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.dppd(<2 x double>, <2 x double>, i8) nounwind readnone


define <4 x float> @test_x86_sse41_dpps(<4 x float> %a0, <4 x float> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_dpps(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i32> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP3]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <4 x i32> [[TMP2]] to i128
; CHECK-NEXT:    [[_MSCMP1:%.*]] = icmp ne i128 [[TMP4]], 0
; CHECK-NEXT:    [[_MSOR:%.*]] = or i1 [[_MSCMP]], [[_MSCMP1]]
; CHECK-NEXT:    br i1 [[_MSOR]], label [[TMP5:%.*]], label [[TMP6:%.*]], !prof [[PROF0]]
; CHECK:       5:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       6:
; CHECK-NEXT:    [[RES:%.*]] = call <4 x float> @llvm.x86.sse41.dpps(<4 x float> [[A0:%.*]], <4 x float> [[A1:%.*]], i8 7)
; CHECK-NEXT:    store <4 x i32> zeroinitializer, <4 x i32>* bitcast ([100 x i64]* @__msan_retval_tls to <4 x i32>*), align 8
; CHECK-NEXT:    ret <4 x float> [[RES]]
;
  %res = call <4 x float> @llvm.x86.sse41.dpps(<4 x float> %a0, <4 x float> %a1, i8 7) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.dpps(<4 x float>, <4 x float>, i8) nounwind readnone


define <4 x float> @test_x86_sse41_insertps(<4 x float> %a0, <4 x float> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_insertps(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i32> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP3]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <4 x i32> [[TMP2]] to i128
; CHECK-NEXT:    [[_MSCMP1:%.*]] = icmp ne i128 [[TMP4]], 0
; CHECK-NEXT:    [[_MSOR:%.*]] = or i1 [[_MSCMP]], [[_MSCMP1]]
; CHECK-NEXT:    br i1 [[_MSOR]], label [[TMP5:%.*]], label [[TMP6:%.*]], !prof [[PROF0]]
; CHECK:       5:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       6:
; CHECK-NEXT:    [[RES:%.*]] = call <4 x float> @llvm.x86.sse41.insertps(<4 x float> [[A0:%.*]], <4 x float> [[A1:%.*]], i8 17)
; CHECK-NEXT:    store <4 x i32> zeroinitializer, <4 x i32>* bitcast ([100 x i64]* @__msan_retval_tls to <4 x i32>*), align 8
; CHECK-NEXT:    ret <4 x float> [[RES]]
;
  %res = call <4 x float> @llvm.x86.sse41.insertps(<4 x float> %a0, <4 x float> %a1, i8 17) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.insertps(<4 x float>, <4 x float>, i8) nounwind readnone



define <8 x i16> @test_x86_sse41_mpsadbw(<16 x i8> %a0, <16 x i8> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_mpsadbw(
; CHECK-NEXT:    [[TMP1:%.*]] = load <16 x i8>, <16 x i8>* bitcast ([100 x i64]* @__msan_param_tls to <16 x i8>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <16 x i8>, <16 x i8>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <16 x i8>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <16 x i8> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP3]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <16 x i8> [[TMP2]] to i128
; CHECK-NEXT:    [[_MSCMP1:%.*]] = icmp ne i128 [[TMP4]], 0
; CHECK-NEXT:    [[_MSOR:%.*]] = or i1 [[_MSCMP]], [[_MSCMP1]]
; CHECK-NEXT:    br i1 [[_MSOR]], label [[TMP5:%.*]], label [[TMP6:%.*]], !prof [[PROF0]]
; CHECK:       5:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       6:
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> [[A0:%.*]], <16 x i8> [[A1:%.*]], i8 7)
; CHECK-NEXT:    store <8 x i16> zeroinitializer, <8 x i16>* bitcast ([100 x i64]* @__msan_retval_tls to <8 x i16>*), align 8
; CHECK-NEXT:    ret <8 x i16> [[RES]]
;
  %res = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> %a0, <16 x i8> %a1, i8 7) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8>, <16 x i8>, i8) nounwind readnone

define <8 x i16> @test_x86_sse41_mpsadbw_load_op0(<16 x i8>* %ptr, <16 x i8> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_mpsadbw_load_op0(
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i32 0, i32 0), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <16 x i8>, <16 x i8>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to <16 x i8>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSCMP2:%.*]] = icmp ne i64 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[_MSCMP2]], label [[TMP3:%.*]], label [[TMP4:%.*]], !prof [[PROF0]]
; CHECK:       3:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[A0:%.*]] = load <16 x i8>, <16 x i8>* [[PTR:%.*]], align 16
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint <16 x i8>* [[PTR]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = xor i64 [[TMP5]], 87960930222080
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to <16 x i8>*
; CHECK-NEXT:    [[_MSLD:%.*]] = load <16 x i8>, <16 x i8>* [[TMP7]], align 16
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast <16 x i8> [[_MSLD]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP8]], 0
; CHECK-NEXT:    [[TMP9:%.*]] = bitcast <16 x i8> [[TMP2]] to i128
; CHECK-NEXT:    [[_MSCMP1:%.*]] = icmp ne i128 [[TMP9]], 0
; CHECK-NEXT:    [[_MSOR:%.*]] = or i1 [[_MSCMP]], [[_MSCMP1]]
; CHECK-NEXT:    br i1 [[_MSOR]], label [[TMP10:%.*]], label [[TMP11:%.*]], !prof [[PROF0]]
; CHECK:       10:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       11:
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> [[A0]], <16 x i8> [[A1:%.*]], i8 7)
; CHECK-NEXT:    store <8 x i16> zeroinitializer, <8 x i16>* bitcast ([100 x i64]* @__msan_retval_tls to <8 x i16>*), align 8
; CHECK-NEXT:    ret <8 x i16> [[RES]]
;
  %a0 = load <16 x i8>, <16 x i8>* %ptr
  %res = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> %a0, <16 x i8> %a1, i8 7) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}

define <8 x i16> @test_x86_sse41_packusdw(<4 x i32> %a0, <4 x i32> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_packusdw(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne <4 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ne <4 x i32> [[TMP2]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = sext <4 x i1> [[TMP5]] to <4 x i32>
; CHECK-NEXT:    [[_MSPROP_VECTOR_PACK:%.*]] = call <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32> [[TMP4]], <4 x i32> [[TMP6]])
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> [[A0:%.*]], <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    store <8 x i16> [[_MSPROP_VECTOR_PACK]], <8 x i16>* bitcast ([100 x i64]* @__msan_retval_tls to <8 x i16>*), align 8
; CHECK-NEXT:    ret <8 x i16> [[RES]]
;
  %res = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> %a0, <4 x i32> %a1) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32>, <4 x i32>) nounwind readnone


define <8 x i16> @test_x86_sse41_packusdw_fold() #0 {
; CHECK-LABEL: @test_x86_sse41_packusdw_fold(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSPROP_VECTOR_PACK:%.*]] = call <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32> zeroinitializer, <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> zeroinitializer, <4 x i32> <i32 65535, i32 65536, i32 -1, i32 -131072>)
; CHECK-NEXT:    store <8 x i16> [[_MSPROP_VECTOR_PACK]], <8 x i16>* bitcast ([100 x i64]* @__msan_retval_tls to <8 x i16>*), align 8
; CHECK-NEXT:    ret <8 x i16> [[RES]]
;
  %res = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> zeroinitializer, <4 x i32> <i32 65535, i32 65536, i32 -1, i32 -131072>)
  ret <8 x i16> %res
}


define <16 x i8> @test_x86_sse41_pblendvb(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> %a2) #0 {
; CHECK-LABEL: @test_x86_sse41_pblendvb(
; CHECK-NEXT:    [[TMP1:%.*]] = load <16 x i8>, <16 x i8>* bitcast ([100 x i64]* @__msan_param_tls to <16 x i8>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <16 x i8>, <16 x i8>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <16 x i8>*), align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <16 x i8>, <16 x i8>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 32) to <16 x i8>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSPROP:%.*]] = or <16 x i8> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[_MSPROP1:%.*]] = or <16 x i8> [[_MSPROP]], [[TMP3]]
; CHECK-NEXT:    [[RES:%.*]] = call <16 x i8> @llvm.x86.sse41.pblendvb(<16 x i8> [[A0:%.*]], <16 x i8> [[A1:%.*]], <16 x i8> [[A2:%.*]])
; CHECK-NEXT:    store <16 x i8> [[_MSPROP1]], <16 x i8>* bitcast ([100 x i64]* @__msan_retval_tls to <16 x i8>*), align 8
; CHECK-NEXT:    ret <16 x i8> [[RES]]
;
  %res = call <16 x i8> @llvm.x86.sse41.pblendvb(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> %a2) ; <<16 x i8>> [#uses=1]
  ret <16 x i8> %res
}
declare <16 x i8> @llvm.x86.sse41.pblendvb(<16 x i8>, <16 x i8>, <16 x i8>) nounwind readnone


define <8 x i16> @test_x86_sse41_phminposuw(<8 x i16> %a0) #0 {
; CHECK-LABEL: @test_x86_sse41_phminposuw(
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i16>, <8 x i16>* bitcast ([100 x i64]* @__msan_param_tls to <8 x i16>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i16> @llvm.x86.sse41.phminposuw(<8 x i16> [[A0:%.*]])
; CHECK-NEXT:    store <8 x i16> [[TMP1]], <8 x i16>* bitcast ([100 x i64]* @__msan_retval_tls to <8 x i16>*), align 8
; CHECK-NEXT:    ret <8 x i16> [[RES]]
;
  %res = call <8 x i16> @llvm.x86.sse41.phminposuw(<8 x i16> %a0) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.phminposuw(<8 x i16>) nounwind readnone


define i32 @test_x86_sse41_ptestc(<2 x i64> %a0, <2 x i64> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_ptestc(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = or <2 x i64> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne <2 x i64> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <2 x i1> [[TMP4]] to i2
; CHECK-NEXT:    [[TMP6:%.*]] = zext i2 [[TMP5]] to i32
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.x86.sse41.ptestc(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]])
; CHECK-NEXT:    store i32 [[TMP6]], i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %a0, <2 x i64> %a1) ; <i32> [#uses=1]
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestc(<2 x i64>, <2 x i64>) nounwind readnone


define i32 @test_x86_sse41_ptestnzc(<2 x i64> %a0, <2 x i64> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_ptestnzc(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = or <2 x i64> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne <2 x i64> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <2 x i1> [[TMP4]] to i2
; CHECK-NEXT:    [[TMP6:%.*]] = zext i2 [[TMP5]] to i32
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.x86.sse41.ptestnzc(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]])
; CHECK-NEXT:    store i32 [[TMP6]], i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = call i32 @llvm.x86.sse41.ptestnzc(<2 x i64> %a0, <2 x i64> %a1) ; <i32> [#uses=1]
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestnzc(<2 x i64>, <2 x i64>) nounwind readnone


define i32 @test_x86_sse41_ptestz(<2 x i64> %a0, <2 x i64> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_ptestz(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = or <2 x i64> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne <2 x i64> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <2 x i1> [[TMP4]] to i2
; CHECK-NEXT:    [[TMP6:%.*]] = zext i2 [[TMP5]] to i32
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.x86.sse41.ptestz(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]])
; CHECK-NEXT:    store i32 [[TMP6]], i32* bitcast ([100 x i64]* @__msan_retval_tls to i32*), align 8
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %a0, <2 x i64> %a1) ; <i32> [#uses=1]
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestz(<2 x i64>, <2 x i64>) nounwind readnone


define <2 x double> @test_x86_sse41_round_pd(<2 x double> %a0) #0 {
; CHECK-LABEL: @test_x86_sse41_round_pd(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i64> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP3:%.*]], label [[TMP4:%.*]], !prof [[PROF0]]
; CHECK:       3:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[RES:%.*]] = call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> [[A0:%.*]], i32 7)
; CHECK-NEXT:    store <2 x i64> zeroinitializer, <2 x i64>* bitcast ([100 x i64]* @__msan_retval_tls to <2 x i64>*), align 8
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
  %res = call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %a0, i32 7) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.round.pd(<2 x double>, i32) nounwind readnone


define <4 x float> @test_x86_sse41_round_ps(<4 x float> %a0) #0 {
; CHECK-LABEL: @test_x86_sse41_round_ps(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <4 x i32> [[TMP1]] to i128
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i128 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP3:%.*]], label [[TMP4:%.*]], !prof [[PROF0]]
; CHECK:       3:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[RES:%.*]] = call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> [[A0:%.*]], i32 7)
; CHECK-NEXT:    store <4 x i32> zeroinitializer, <4 x i32>* bitcast ([100 x i64]* @__msan_retval_tls to <4 x i32>*), align 8
; CHECK-NEXT:    ret <4 x float> [[RES]]
;
  %res = call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %a0, i32 7) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.round.ps(<4 x float>, i32) nounwind readnone


define <2 x double> @test_x86_sse41_round_sd(<2 x double> %a0, <2 x double> %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_round_sd(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x i64> [[TMP1]], <2 x i64> [[TMP2]], <2 x i32> <i32 2, i32 1>
; CHECK-NEXT:    [[RES:%.*]] = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> [[A0:%.*]], <2 x double> [[A1:%.*]], i32 7)
; CHECK-NEXT:    store <2 x i64> [[TMP3]], <2 x i64>* bitcast ([100 x i64]* @__msan_retval_tls to <2 x i64>*), align 8
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
  %res = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %a0, <2 x double> %a1, i32 7) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.round.sd(<2 x double>, <2 x double>, i32) nounwind readnone


define <2 x double> @test_x86_sse41_round_sd_load(<2 x double> %a0, <2 x double>* %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_round_sd_load(
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([100 x i64]* @__msan_param_tls to <2 x i64>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i64 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP3:%.*]], label [[TMP4:%.*]], !prof [[PROF0]]
; CHECK:       3:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[A1B:%.*]] = load <2 x double>, <2 x double>* [[A1:%.*]], align 16
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint <2 x double>* [[A1]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = xor i64 [[TMP5]], 87960930222080
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to <2 x i64>*
; CHECK-NEXT:    [[_MSLD:%.*]] = load <2 x i64>, <2 x i64>* [[TMP7]], align 16
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <2 x i64> [[TMP2]], <2 x i64> [[_MSLD]], <2 x i32> <i32 2, i32 1>
; CHECK-NEXT:    [[RES:%.*]] = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> [[A0:%.*]], <2 x double> [[A1B]], i32 7)
; CHECK-NEXT:    store <2 x i64> [[TMP8]], <2 x i64>* bitcast ([100 x i64]* @__msan_retval_tls to <2 x i64>*), align 8
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
  %a1b = load <2 x double>, <2 x double>* %a1
  %res = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %a0, <2 x double> %a1b, i32 7) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}


define <4 x float> @test_x86_sse41_round_ss_load(<4 x float> %a0, <4 x float>* %a1) #0 {
; CHECK-LABEL: @test_x86_sse41_round_ss_load(
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([100 x i64]* @__msan_param_tls to <4 x i32>*), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i64 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP3:%.*]], label [[TMP4:%.*]], !prof [[PROF0]]
; CHECK:       3:
; CHECK-NEXT:    call void @__msan_warning_noreturn() #[[ATTR4]]
; CHECK-NEXT:    unreachable
; CHECK:       4:
; CHECK-NEXT:    [[A1B:%.*]] = load <4 x float>, <4 x float>* [[A1:%.*]], align 16
; CHECK-NEXT:    [[TMP5:%.*]] = ptrtoint <4 x float>* [[A1]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = xor i64 [[TMP5]], 87960930222080
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to <4 x i32>*
; CHECK-NEXT:    [[_MSLD:%.*]] = load <4 x i32>, <4 x i32>* [[TMP7]], align 16
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> [[_MSLD]], <4 x i32> <i32 4, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[RES:%.*]] = call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> [[A0:%.*]], <4 x float> [[A1B]], i32 7)
; CHECK-NEXT:    store <4 x i32> [[TMP8]], <4 x i32>* bitcast ([100 x i64]* @__msan_retval_tls to <4 x i32>*), align 8
; CHECK-NEXT:    ret <4 x float> [[RES]]
;
  %a1b = load <4 x float>, <4 x float>* %a1
  %res = call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %a0, <4 x float> %a1b, i32 7) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.round.ss(<4 x float>, <4 x float>, i32) nounwind readnone

attributes #0 = { sanitize_memory }
