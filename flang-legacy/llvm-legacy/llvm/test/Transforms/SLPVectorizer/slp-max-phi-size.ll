; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -slp-max-vf=1 < %s | FileCheck -check-prefix=MAX32 %s
; RUN: opt -passes=slp-vectorizer -S -slp-max-vf=8 < %s | FileCheck -check-prefix=MAX256 %s
; RUN: opt -passes=slp-vectorizer -S -slp-max-vf=32 < %s | FileCheck -check-prefix=MAX1024 %s
; RUN: opt -passes=slp-vectorizer -S < %s | FileCheck -check-prefix=MAX1024 %s

; Make sure we do not vectorize to create PHI wider than requested.
; On AMDGPU target wider vectorization will result in a higher register pressure,
; spilling, or even inability to allocate registers.

define void @phi_float32(half %hval, float %fval) {
; MAX32-LABEL: @phi_float32(
; MAX32-NEXT:  bb:
; MAX32-NEXT:    br label [[BB1:%.*]]
; MAX32:       bb1:
; MAX32-NEXT:    [[I:%.*]] = fpext half [[HVAL:%.*]] to float
; MAX32-NEXT:    [[I1:%.*]] = fmul float [[I]], [[FVAL:%.*]]
; MAX32-NEXT:    [[I2:%.*]] = fadd float 0.000000e+00, [[I1]]
; MAX32-NEXT:    [[I3:%.*]] = fpext half [[HVAL]] to float
; MAX32-NEXT:    [[I4:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I5:%.*]] = fadd float 0.000000e+00, [[I4]]
; MAX32-NEXT:    [[I6:%.*]] = fpext half [[HVAL]] to float
; MAX32-NEXT:    [[I7:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I8:%.*]] = fadd float 0.000000e+00, [[I7]]
; MAX32-NEXT:    [[I9:%.*]] = fpext half [[HVAL]] to float
; MAX32-NEXT:    [[I10:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I11:%.*]] = fadd float 0.000000e+00, [[I10]]
; MAX32-NEXT:    [[I12:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I13:%.*]] = fadd float 0.000000e+00, [[I12]]
; MAX32-NEXT:    [[I14:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I15:%.*]] = fadd float 0.000000e+00, [[I14]]
; MAX32-NEXT:    [[I16:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I17:%.*]] = fadd float 0.000000e+00, [[I16]]
; MAX32-NEXT:    [[I18:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I19:%.*]] = fadd float 0.000000e+00, [[I18]]
; MAX32-NEXT:    [[I20:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I21:%.*]] = fadd float 0.000000e+00, [[I20]]
; MAX32-NEXT:    [[I22:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I23:%.*]] = fadd float 0.000000e+00, [[I22]]
; MAX32-NEXT:    [[I24:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I25:%.*]] = fadd float 0.000000e+00, [[I24]]
; MAX32-NEXT:    [[I26:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I27:%.*]] = fadd float 0.000000e+00, [[I26]]
; MAX32-NEXT:    [[I28:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I29:%.*]] = fadd float 0.000000e+00, [[I28]]
; MAX32-NEXT:    [[I30:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I31:%.*]] = fadd float 0.000000e+00, [[I30]]
; MAX32-NEXT:    [[I32:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I33:%.*]] = fadd float 0.000000e+00, [[I32]]
; MAX32-NEXT:    [[I34:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I35:%.*]] = fadd float 0.000000e+00, [[I34]]
; MAX32-NEXT:    [[I36:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I37:%.*]] = fadd float 0.000000e+00, [[I36]]
; MAX32-NEXT:    [[I38:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I39:%.*]] = fadd float 0.000000e+00, [[I38]]
; MAX32-NEXT:    [[I40:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I41:%.*]] = fadd float 0.000000e+00, [[I40]]
; MAX32-NEXT:    [[I42:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I43:%.*]] = fadd float 0.000000e+00, [[I42]]
; MAX32-NEXT:    [[I44:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I45:%.*]] = fadd float 0.000000e+00, [[I44]]
; MAX32-NEXT:    [[I46:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I47:%.*]] = fadd float 0.000000e+00, [[I46]]
; MAX32-NEXT:    [[I48:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I49:%.*]] = fadd float 0.000000e+00, [[I48]]
; MAX32-NEXT:    [[I50:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I51:%.*]] = fadd float 0.000000e+00, [[I50]]
; MAX32-NEXT:    [[I52:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I53:%.*]] = fadd float 0.000000e+00, [[I52]]
; MAX32-NEXT:    [[I54:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I55:%.*]] = fadd float 0.000000e+00, [[I54]]
; MAX32-NEXT:    [[I56:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I57:%.*]] = fadd float 0.000000e+00, [[I56]]
; MAX32-NEXT:    [[I58:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I59:%.*]] = fadd float 0.000000e+00, [[I58]]
; MAX32-NEXT:    [[I60:%.*]] = fmul float [[I]], [[FVAL]]
; MAX32-NEXT:    [[I61:%.*]] = fadd float 0.000000e+00, [[I60]]
; MAX32-NEXT:    [[I62:%.*]] = fmul float [[I3]], [[FVAL]]
; MAX32-NEXT:    [[I63:%.*]] = fadd float 0.000000e+00, [[I62]]
; MAX32-NEXT:    [[I64:%.*]] = fmul float [[I6]], [[FVAL]]
; MAX32-NEXT:    [[I65:%.*]] = fadd float 0.000000e+00, [[I64]]
; MAX32-NEXT:    [[I66:%.*]] = fmul float [[I9]], [[FVAL]]
; MAX32-NEXT:    [[I67:%.*]] = fadd float 0.000000e+00, [[I66]]
; MAX32-NEXT:    switch i32 undef, label [[BB5:%.*]] [
; MAX32-NEXT:    i32 0, label [[BB2:%.*]]
; MAX32-NEXT:    i32 1, label [[BB3:%.*]]
; MAX32-NEXT:    i32 2, label [[BB4:%.*]]
; MAX32-NEXT:    ]
; MAX32:       bb3:
; MAX32-NEXT:    br label [[BB2]]
; MAX32:       bb4:
; MAX32-NEXT:    br label [[BB2]]
; MAX32:       bb5:
; MAX32-NEXT:    br label [[BB2]]
; MAX32:       bb2:
; MAX32-NEXT:    [[PHI1:%.*]] = phi float [ [[I19]], [[BB3]] ], [ [[I19]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I19]], [[BB1]] ]
; MAX32-NEXT:    [[PHI2:%.*]] = phi float [ [[I17]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I17]], [[BB5]] ], [ [[I17]], [[BB1]] ]
; MAX32-NEXT:    [[PHI3:%.*]] = phi float [ [[I15]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI4:%.*]] = phi float [ [[I13]], [[BB3]] ], [ [[I13]], [[BB4]] ], [ [[I13]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI5:%.*]] = phi float [ [[I11]], [[BB3]] ], [ [[I11]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I11]], [[BB1]] ]
; MAX32-NEXT:    [[PHI6:%.*]] = phi float [ [[I8]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I8]], [[BB5]] ], [ [[I8]], [[BB1]] ]
; MAX32-NEXT:    [[PHI7:%.*]] = phi float [ [[I5]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI8:%.*]] = phi float [ [[I2]], [[BB3]] ], [ [[I2]], [[BB4]] ], [ [[I2]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI9:%.*]] = phi float [ [[I21]], [[BB3]] ], [ [[I21]], [[BB4]] ], [ [[I21]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI10:%.*]] = phi float [ [[I23]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI11:%.*]] = phi float [ [[I25]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I25]], [[BB5]] ], [ [[I25]], [[BB1]] ]
; MAX32-NEXT:    [[PHI12:%.*]] = phi float [ [[I27]], [[BB3]] ], [ [[I27]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I27]], [[BB1]] ]
; MAX32-NEXT:    [[PHI13:%.*]] = phi float [ [[I29]], [[BB3]] ], [ [[I29]], [[BB4]] ], [ [[I29]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI14:%.*]] = phi float [ [[I31]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI15:%.*]] = phi float [ [[I33]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I33]], [[BB5]] ], [ [[I33]], [[BB1]] ]
; MAX32-NEXT:    [[PHI16:%.*]] = phi float [ [[I35]], [[BB3]] ], [ [[I35]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I35]], [[BB1]] ]
; MAX32-NEXT:    [[PHI17:%.*]] = phi float [ [[I37]], [[BB3]] ], [ [[I37]], [[BB4]] ], [ [[I37]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI18:%.*]] = phi float [ [[I39]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI19:%.*]] = phi float [ [[I41]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I41]], [[BB5]] ], [ [[I41]], [[BB1]] ]
; MAX32-NEXT:    [[PHI20:%.*]] = phi float [ [[I43]], [[BB3]] ], [ [[I43]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I43]], [[BB1]] ]
; MAX32-NEXT:    [[PHI21:%.*]] = phi float [ [[I45]], [[BB3]] ], [ [[I45]], [[BB4]] ], [ [[I45]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI22:%.*]] = phi float [ [[I47]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI23:%.*]] = phi float [ [[I49]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I49]], [[BB5]] ], [ [[I49]], [[BB1]] ]
; MAX32-NEXT:    [[PHI24:%.*]] = phi float [ [[I51]], [[BB3]] ], [ [[I51]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I51]], [[BB1]] ]
; MAX32-NEXT:    [[PHI25:%.*]] = phi float [ [[I53]], [[BB3]] ], [ [[I53]], [[BB4]] ], [ [[I53]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI26:%.*]] = phi float [ [[I55]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI27:%.*]] = phi float [ [[I57]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I57]], [[BB5]] ], [ [[I57]], [[BB1]] ]
; MAX32-NEXT:    [[PHI28:%.*]] = phi float [ [[I59]], [[BB3]] ], [ [[I59]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I59]], [[BB1]] ]
; MAX32-NEXT:    [[PHI29:%.*]] = phi float [ [[I61]], [[BB3]] ], [ [[I61]], [[BB4]] ], [ [[I61]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI30:%.*]] = phi float [ [[I63]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[FVAL]], [[BB1]] ]
; MAX32-NEXT:    [[PHI31:%.*]] = phi float [ [[I65]], [[BB3]] ], [ [[FVAL]], [[BB4]] ], [ [[I65]], [[BB5]] ], [ [[I65]], [[BB1]] ]
; MAX32-NEXT:    [[PHI32:%.*]] = phi float [ [[I67]], [[BB3]] ], [ [[I67]], [[BB4]] ], [ [[FVAL]], [[BB5]] ], [ [[I67]], [[BB1]] ]
; MAX32-NEXT:    store float [[PHI31]], float* undef, align 4
; MAX32-NEXT:    ret void
;
; MAX256-LABEL: @phi_float32(
; MAX256-NEXT:  bb:
; MAX256-NEXT:    br label [[BB1:%.*]]
; MAX256:       bb1:
; MAX256-NEXT:    [[I:%.*]] = fpext half [[HVAL:%.*]] to float
; MAX256-NEXT:    [[I3:%.*]] = fpext half [[HVAL]] to float
; MAX256-NEXT:    [[I6:%.*]] = fpext half [[HVAL]] to float
; MAX256-NEXT:    [[I9:%.*]] = fpext half [[HVAL]] to float
; MAX256-NEXT:    [[TMP0:%.*]] = insertelement <8 x float> poison, float [[I]], i32 0
; MAX256-NEXT:    [[SHUFFLE11:%.*]] = shufflevector <8 x float> [[TMP0]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX256-NEXT:    [[TMP1:%.*]] = insertelement <8 x float> poison, float [[FVAL:%.*]], i32 0
; MAX256-NEXT:    [[SHUFFLE12:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX256-NEXT:    [[TMP2:%.*]] = fmul <8 x float> [[SHUFFLE11]], [[SHUFFLE12]]
; MAX256-NEXT:    [[TMP3:%.*]] = fadd <8 x float> zeroinitializer, [[TMP2]]
; MAX256-NEXT:    [[TMP4:%.*]] = insertelement <8 x float> poison, float [[I3]], i32 0
; MAX256-NEXT:    [[SHUFFLE:%.*]] = shufflevector <8 x float> [[TMP4]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX256-NEXT:    [[TMP5:%.*]] = fmul <8 x float> [[SHUFFLE]], [[SHUFFLE12]]
; MAX256-NEXT:    [[TMP6:%.*]] = fadd <8 x float> zeroinitializer, [[TMP5]]
; MAX256-NEXT:    [[TMP7:%.*]] = insertelement <8 x float> poison, float [[I6]], i32 0
; MAX256-NEXT:    [[SHUFFLE5:%.*]] = shufflevector <8 x float> [[TMP7]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX256-NEXT:    [[TMP8:%.*]] = fmul <8 x float> [[SHUFFLE5]], [[SHUFFLE12]]
; MAX256-NEXT:    [[TMP9:%.*]] = fadd <8 x float> zeroinitializer, [[TMP8]]
; MAX256-NEXT:    [[TMP10:%.*]] = insertelement <8 x float> poison, float [[I9]], i32 0
; MAX256-NEXT:    [[SHUFFLE8:%.*]] = shufflevector <8 x float> [[TMP10]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX256-NEXT:    [[TMP11:%.*]] = fmul <8 x float> [[SHUFFLE8]], [[SHUFFLE12]]
; MAX256-NEXT:    [[TMP12:%.*]] = fadd <8 x float> zeroinitializer, [[TMP11]]
; MAX256-NEXT:    switch i32 undef, label [[BB5:%.*]] [
; MAX256-NEXT:    i32 0, label [[BB2:%.*]]
; MAX256-NEXT:    i32 1, label [[BB3:%.*]]
; MAX256-NEXT:    i32 2, label [[BB4:%.*]]
; MAX256-NEXT:    ]
; MAX256:       bb3:
; MAX256-NEXT:    br label [[BB2]]
; MAX256:       bb4:
; MAX256-NEXT:    br label [[BB2]]
; MAX256:       bb5:
; MAX256-NEXT:    br label [[BB2]]
; MAX256:       bb2:
; MAX256-NEXT:    [[TMP13:%.*]] = phi <8 x float> [ [[TMP6]], [[BB3]] ], [ [[SHUFFLE12]], [[BB4]] ], [ [[SHUFFLE12]], [[BB5]] ], [ [[SHUFFLE12]], [[BB1]] ]
; MAX256-NEXT:    [[TMP14:%.*]] = phi <8 x float> [ [[TMP9]], [[BB3]] ], [ [[SHUFFLE12]], [[BB4]] ], [ [[TMP9]], [[BB5]] ], [ [[TMP9]], [[BB1]] ]
; MAX256-NEXT:    [[TMP15:%.*]] = phi <8 x float> [ [[TMP12]], [[BB3]] ], [ [[TMP12]], [[BB4]] ], [ [[SHUFFLE12]], [[BB5]] ], [ [[TMP12]], [[BB1]] ]
; MAX256-NEXT:    [[TMP16:%.*]] = phi <8 x float> [ [[TMP3]], [[BB3]] ], [ [[TMP3]], [[BB4]] ], [ [[TMP3]], [[BB5]] ], [ [[SHUFFLE12]], [[BB1]] ]
; MAX256-NEXT:    [[TMP17:%.*]] = extractelement <8 x float> [[TMP14]], i32 7
; MAX256-NEXT:    store float [[TMP17]], float* undef, align 4
; MAX256-NEXT:    ret void
;
; MAX1024-LABEL: @phi_float32(
; MAX1024-NEXT:  bb:
; MAX1024-NEXT:    br label [[BB1:%.*]]
; MAX1024:       bb1:
; MAX1024-NEXT:    [[I:%.*]] = fpext half [[HVAL:%.*]] to float
; MAX1024-NEXT:    [[I3:%.*]] = fpext half [[HVAL]] to float
; MAX1024-NEXT:    [[I6:%.*]] = fpext half [[HVAL]] to float
; MAX1024-NEXT:    [[I9:%.*]] = fpext half [[HVAL]] to float
; MAX1024-NEXT:    [[TMP0:%.*]] = insertelement <8 x float> poison, float [[I]], i32 0
; MAX1024-NEXT:    [[SHUFFLE11:%.*]] = shufflevector <8 x float> [[TMP0]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX1024-NEXT:    [[TMP1:%.*]] = insertelement <8 x float> poison, float [[FVAL:%.*]], i32 0
; MAX1024-NEXT:    [[SHUFFLE12:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX1024-NEXT:    [[TMP2:%.*]] = fmul <8 x float> [[SHUFFLE11]], [[SHUFFLE12]]
; MAX1024-NEXT:    [[TMP3:%.*]] = fadd <8 x float> zeroinitializer, [[TMP2]]
; MAX1024-NEXT:    [[TMP4:%.*]] = insertelement <8 x float> poison, float [[I3]], i32 0
; MAX1024-NEXT:    [[SHUFFLE:%.*]] = shufflevector <8 x float> [[TMP4]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX1024-NEXT:    [[TMP5:%.*]] = fmul <8 x float> [[SHUFFLE]], [[SHUFFLE12]]
; MAX1024-NEXT:    [[TMP6:%.*]] = fadd <8 x float> zeroinitializer, [[TMP5]]
; MAX1024-NEXT:    [[TMP7:%.*]] = insertelement <8 x float> poison, float [[I6]], i32 0
; MAX1024-NEXT:    [[SHUFFLE5:%.*]] = shufflevector <8 x float> [[TMP7]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX1024-NEXT:    [[TMP8:%.*]] = fmul <8 x float> [[SHUFFLE5]], [[SHUFFLE12]]
; MAX1024-NEXT:    [[TMP9:%.*]] = fadd <8 x float> zeroinitializer, [[TMP8]]
; MAX1024-NEXT:    [[TMP10:%.*]] = insertelement <8 x float> poison, float [[I9]], i32 0
; MAX1024-NEXT:    [[SHUFFLE8:%.*]] = shufflevector <8 x float> [[TMP10]], <8 x float> poison, <8 x i32> zeroinitializer
; MAX1024-NEXT:    [[TMP11:%.*]] = fmul <8 x float> [[SHUFFLE8]], [[SHUFFLE12]]
; MAX1024-NEXT:    [[TMP12:%.*]] = fadd <8 x float> zeroinitializer, [[TMP11]]
; MAX1024-NEXT:    switch i32 undef, label [[BB5:%.*]] [
; MAX1024-NEXT:    i32 0, label [[BB2:%.*]]
; MAX1024-NEXT:    i32 1, label [[BB3:%.*]]
; MAX1024-NEXT:    i32 2, label [[BB4:%.*]]
; MAX1024-NEXT:    ]
; MAX1024:       bb3:
; MAX1024-NEXT:    br label [[BB2]]
; MAX1024:       bb4:
; MAX1024-NEXT:    br label [[BB2]]
; MAX1024:       bb5:
; MAX1024-NEXT:    br label [[BB2]]
; MAX1024:       bb2:
; MAX1024-NEXT:    [[TMP13:%.*]] = phi <8 x float> [ [[TMP6]], [[BB3]] ], [ [[SHUFFLE12]], [[BB4]] ], [ [[SHUFFLE12]], [[BB5]] ], [ [[SHUFFLE12]], [[BB1]] ]
; MAX1024-NEXT:    [[TMP14:%.*]] = phi <8 x float> [ [[TMP9]], [[BB3]] ], [ [[SHUFFLE12]], [[BB4]] ], [ [[TMP9]], [[BB5]] ], [ [[TMP9]], [[BB1]] ]
; MAX1024-NEXT:    [[TMP15:%.*]] = phi <8 x float> [ [[TMP12]], [[BB3]] ], [ [[TMP12]], [[BB4]] ], [ [[SHUFFLE12]], [[BB5]] ], [ [[TMP12]], [[BB1]] ]
; MAX1024-NEXT:    [[TMP16:%.*]] = phi <8 x float> [ [[TMP3]], [[BB3]] ], [ [[TMP3]], [[BB4]] ], [ [[TMP3]], [[BB5]] ], [ [[SHUFFLE12]], [[BB1]] ]
; MAX1024-NEXT:    [[TMP17:%.*]] = extractelement <8 x float> [[TMP14]], i32 7
; MAX1024-NEXT:    store float [[TMP17]], float* undef, align 4
; MAX1024-NEXT:    ret void
;
bb:
  br label %bb1

bb1:
  %i = fpext half %hval to float
  %i1 = fmul float %i, %fval
  %i2 = fadd float 0.000000e+00, %i1
  %i3 = fpext half %hval to float
  %i4 = fmul float %i3, %fval
  %i5 = fadd float 0.000000e+00, %i4
  %i6 = fpext half %hval to float
  %i7 = fmul float %i6, %fval
  %i8 = fadd float 0.000000e+00, %i7
  %i9 = fpext half %hval to float
  %i10 = fmul float %i9, %fval
  %i11 = fadd float 0.000000e+00, %i10
  %i12 = fmul float %i, %fval
  %i13 = fadd float 0.000000e+00, %i12
  %i14 = fmul float %i3, %fval
  %i15 = fadd float 0.000000e+00, %i14
  %i16 = fmul float %i6, %fval
  %i17 = fadd float 0.000000e+00, %i16
  %i18 = fmul float %i9, %fval
  %i19 = fadd float 0.000000e+00, %i18
  %i20 = fmul float %i, %fval
  %i21 = fadd float 0.000000e+00, %i20
  %i22 = fmul float %i3, %fval
  %i23 = fadd float 0.000000e+00, %i22
  %i24 = fmul float %i6, %fval
  %i25 = fadd float 0.000000e+00, %i24
  %i26 = fmul float %i9, %fval
  %i27 = fadd float 0.000000e+00, %i26
  %i28 = fmul float %i, %fval
  %i29 = fadd float 0.000000e+00, %i28
  %i30 = fmul float %i3, %fval
  %i31 = fadd float 0.000000e+00, %i30
  %i32 = fmul float %i6, %fval
  %i33 = fadd float 0.000000e+00, %i32
  %i34 = fmul float %i9, %fval
  %i35 = fadd float 0.000000e+00, %i34
  %i36 = fmul float %i, %fval
  %i37 = fadd float 0.000000e+00, %i36
  %i38 = fmul float %i3, %fval
  %i39 = fadd float 0.000000e+00, %i38
  %i40 = fmul float %i6, %fval
  %i41 = fadd float 0.000000e+00, %i40
  %i42 = fmul float %i9, %fval
  %i43 = fadd float 0.000000e+00, %i42
  %i44 = fmul float %i, %fval
  %i45 = fadd float 0.000000e+00, %i44
  %i46 = fmul float %i3, %fval
  %i47 = fadd float 0.000000e+00, %i46
  %i48 = fmul float %i6, %fval
  %i49 = fadd float 0.000000e+00, %i48
  %i50 = fmul float %i9, %fval
  %i51 = fadd float 0.000000e+00, %i50
  %i52 = fmul float %i, %fval
  %i53 = fadd float 0.000000e+00, %i52
  %i54 = fmul float %i3, %fval
  %i55 = fadd float 0.000000e+00, %i54
  %i56 = fmul float %i6, %fval
  %i57 = fadd float 0.000000e+00, %i56
  %i58 = fmul float %i9, %fval
  %i59 = fadd float 0.000000e+00, %i58
  %i60 = fmul float %i, %fval
  %i61 = fadd float 0.000000e+00, %i60
  %i62 = fmul float %i3, %fval
  %i63 = fadd float 0.000000e+00, %i62
  %i64 = fmul float %i6, %fval
  %i65 = fadd float 0.000000e+00, %i64
  %i66 = fmul float %i9, %fval
  %i67 = fadd float 0.000000e+00, %i66
  switch i32 undef, label %bb5 [
  i32 0, label %bb2
  i32 1, label %bb3
  i32 2, label %bb4
  ]

bb3:
  br label %bb2

bb4:
  br label %bb2

bb5:
  br label %bb2

bb2:
  %phi1 = phi float [ %i19, %bb3 ], [ %i19, %bb4 ], [ %fval, %bb5 ], [ %i19, %bb1 ]
  %phi2 = phi float [ %i17, %bb3 ], [ %fval, %bb4 ], [ %i17, %bb5 ], [ %i17, %bb1 ]
  %phi3 = phi float [ %i15, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi4 = phi float [ %i13, %bb3 ], [ %i13, %bb4 ], [ %i13, %bb5 ], [ %fval, %bb1 ]
  %phi5 = phi float [ %i11, %bb3 ], [ %i11, %bb4 ], [ %fval, %bb5 ], [ %i11, %bb1 ]
  %phi6 = phi float [ %i8, %bb3 ], [ %fval, %bb4 ], [ %i8, %bb5 ], [ %i8, %bb1 ]
  %phi7 = phi float [ %i5, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi8 = phi float [ %i2, %bb3 ], [ %i2, %bb4 ], [ %i2, %bb5 ], [ %fval, %bb1 ]
  %phi9 = phi float [ %i21, %bb3 ], [ %i21, %bb4 ], [ %i21, %bb5 ], [ %fval, %bb1 ]
  %phi10 = phi float [ %i23, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi11 = phi float [ %i25, %bb3 ], [ %fval, %bb4 ], [ %i25, %bb5 ], [ %i25, %bb1 ]
  %phi12 = phi float [ %i27, %bb3 ], [ %i27, %bb4 ], [ %fval, %bb5 ], [ %i27, %bb1 ]
  %phi13 = phi float [ %i29, %bb3 ], [ %i29, %bb4 ], [ %i29, %bb5 ], [ %fval, %bb1 ]
  %phi14 = phi float [ %i31, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi15 = phi float [ %i33, %bb3 ], [ %fval, %bb4 ], [ %i33, %bb5 ], [ %i33, %bb1 ]
  %phi16 = phi float [ %i35, %bb3 ], [ %i35, %bb4 ], [ %fval, %bb5 ], [ %i35, %bb1 ]
  %phi17 = phi float [ %i37, %bb3 ], [ %i37, %bb4 ], [ %i37, %bb5 ], [ %fval, %bb1 ]
  %phi18 = phi float [ %i39, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi19 = phi float [ %i41, %bb3 ], [ %fval, %bb4 ], [ %i41, %bb5 ], [ %i41, %bb1 ]
  %phi20 = phi float [ %i43, %bb3 ], [ %i43, %bb4 ], [ %fval, %bb5 ], [ %i43, %bb1 ]
  %phi21 = phi float [ %i45, %bb3 ], [ %i45, %bb4 ], [ %i45, %bb5 ], [ %fval, %bb1 ]
  %phi22 = phi float [ %i47, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi23 = phi float [ %i49, %bb3 ], [ %fval, %bb4 ], [ %i49, %bb5 ], [ %i49, %bb1 ]
  %phi24 = phi float [ %i51, %bb3 ], [ %i51, %bb4 ], [ %fval, %bb5 ], [ %i51, %bb1 ]
  %phi25 = phi float [ %i53, %bb3 ], [ %i53, %bb4 ], [ %i53, %bb5 ], [ %fval, %bb1 ]
  %phi26 = phi float [ %i55, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi27 = phi float [ %i57, %bb3 ], [ %fval, %bb4 ], [ %i57, %bb5 ], [ %i57, %bb1 ]
  %phi28 = phi float [ %i59, %bb3 ], [ %i59, %bb4 ], [ %fval, %bb5 ], [ %i59, %bb1 ]
  %phi29 = phi float [ %i61, %bb3 ], [ %i61, %bb4 ], [ %i61, %bb5 ], [ %fval, %bb1 ]
  %phi30 = phi float [ %i63, %bb3 ], [ %fval, %bb4 ], [ %fval, %bb5 ], [ %fval, %bb1 ]
  %phi31 = phi float [ %i65, %bb3 ], [ %fval, %bb4 ], [ %i65, %bb5 ], [ %i65, %bb1 ]
  %phi32 = phi float [ %i67, %bb3 ], [ %i67, %bb4 ], [ %fval, %bb5 ], [ %i67, %bb1 ]
  store float %phi31, float* undef
  ret void
}
