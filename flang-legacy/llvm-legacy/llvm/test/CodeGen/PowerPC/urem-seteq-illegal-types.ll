; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=PPC
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=PPC64LE

define i1 @test_urem_odd(i13 %X) nounwind {
; PPC-LABEL: test_urem_odd:
; PPC:       # %bb.0:
; PPC-NEXT:    mulli 3, 3, 3277
; PPC-NEXT:    clrlwi 3, 3, 19
; PPC-NEXT:    li 4, 0
; PPC-NEXT:    cmplwi 3, 1639
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bclr 12, 0, 0
; PPC-NEXT:  # %bb.1:
; PPC-NEXT:    ori 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_odd:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    mulli 3, 3, 3277
; PPC64LE-NEXT:    li 4, 0
; PPC64LE-NEXT:    clrlwi 3, 3, 19
; PPC64LE-NEXT:    cmplwi 3, 1639
; PPC64LE-NEXT:    li 3, 1
; PPC64LE-NEXT:    isellt 3, 3, 4
; PPC64LE-NEXT:    blr
  %urem = urem i13 %X, 5
  %cmp = icmp eq i13 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_even(i27 %X) nounwind {
; PPC-LABEL: test_urem_even:
; PPC:       # %bb.0:
; PPC-NEXT:    lis 4, 1755
; PPC-NEXT:    ori 4, 4, 28087
; PPC-NEXT:    mullw 3, 3, 4
; PPC-NEXT:    rlwinm 4, 3, 31, 6, 31
; PPC-NEXT:    rlwimi 4, 3, 26, 5, 5
; PPC-NEXT:    lis 3, 146
; PPC-NEXT:    ori 3, 3, 18725
; PPC-NEXT:    cmplw 4, 3
; PPC-NEXT:    li 3, 0
; PPC-NEXT:    li 4, 1
; PPC-NEXT:    bc 12, 0, .LBB1_1
; PPC-NEXT:    blr
; PPC-NEXT:  .LBB1_1:
; PPC-NEXT:    addi 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_even:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    lis 4, 1755
; PPC64LE-NEXT:    ori 4, 4, 28087
; PPC64LE-NEXT:    mullw 3, 3, 4
; PPC64LE-NEXT:    lis 4, 146
; PPC64LE-NEXT:    rlwinm 5, 3, 31, 6, 31
; PPC64LE-NEXT:    rlwimi 5, 3, 26, 5, 5
; PPC64LE-NEXT:    ori 3, 4, 18725
; PPC64LE-NEXT:    li 4, 1
; PPC64LE-NEXT:    cmplw 5, 3
; PPC64LE-NEXT:    li 3, 0
; PPC64LE-NEXT:    isellt 3, 4, 3
; PPC64LE-NEXT:    blr
  %urem = urem i27 %X, 14
  %cmp = icmp eq i27 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_odd_setne(i4 %X) nounwind {
; PPC-LABEL: test_urem_odd_setne:
; PPC:       # %bb.0:
; PPC-NEXT:    mulli 3, 3, 13
; PPC-NEXT:    clrlwi 3, 3, 28
; PPC-NEXT:    li 4, 0
; PPC-NEXT:    cmplwi 3, 3
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bclr 12, 1, 0
; PPC-NEXT:  # %bb.1:
; PPC-NEXT:    ori 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_odd_setne:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    slwi 5, 3, 1
; PPC64LE-NEXT:    li 4, 0
; PPC64LE-NEXT:    add 3, 3, 5
; PPC64LE-NEXT:    neg 3, 3
; PPC64LE-NEXT:    clrlwi 3, 3, 28
; PPC64LE-NEXT:    cmplwi 3, 3
; PPC64LE-NEXT:    li 3, 1
; PPC64LE-NEXT:    iselgt 3, 3, 4
; PPC64LE-NEXT:    blr
  %urem = urem i4 %X, 5
  %cmp = icmp ne i4 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_negative_odd(i9 %X) nounwind {
; PPC-LABEL: test_urem_negative_odd:
; PPC:       # %bb.0:
; PPC-NEXT:    mulli 3, 3, 307
; PPC-NEXT:    clrlwi 3, 3, 23
; PPC-NEXT:    li 4, 0
; PPC-NEXT:    cmplwi 3, 1
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bclr 12, 1, 0
; PPC-NEXT:  # %bb.1:
; PPC-NEXT:    ori 3, 4, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_negative_odd:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    mulli 3, 3, 307
; PPC64LE-NEXT:    li 4, 0
; PPC64LE-NEXT:    clrlwi 3, 3, 23
; PPC64LE-NEXT:    cmplwi 3, 1
; PPC64LE-NEXT:    li 3, 1
; PPC64LE-NEXT:    iselgt 3, 3, 4
; PPC64LE-NEXT:    blr
  %urem = urem i9 %X, -5
  %cmp = icmp ne i9 %urem, 0
  ret i1 %cmp
}

define <3 x i1> @test_urem_vec(<3 x i11> %X) nounwind {
; PPC-LABEL: test_urem_vec:
; PPC:       # %bb.0:
; PPC-NEXT:    mulli 3, 3, 683
; PPC-NEXT:    rlwinm 7, 3, 31, 22, 31
; PPC-NEXT:    rlwimi 7, 3, 10, 21, 21
; PPC-NEXT:    mulli 5, 5, 819
; PPC-NEXT:    li 6, 0
; PPC-NEXT:    cmplwi 7, 341
; PPC-NEXT:    mulli 3, 4, 1463
; PPC-NEXT:    addi 4, 5, -1638
; PPC-NEXT:    addi 3, 3, -1463
; PPC-NEXT:    clrlwi 4, 4, 21
; PPC-NEXT:    clrlwi 3, 3, 21
; PPC-NEXT:    cmplwi 1, 4, 1
; PPC-NEXT:    cmplwi 5, 3, 292
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bc 12, 21, .LBB4_2
; PPC-NEXT:  # %bb.1:
; PPC-NEXT:    ori 4, 6, 0
; PPC-NEXT:    b .LBB4_3
; PPC-NEXT:  .LBB4_2:
; PPC-NEXT:    addi 4, 3, 0
; PPC-NEXT:  .LBB4_3:
; PPC-NEXT:    bc 12, 5, .LBB4_5
; PPC-NEXT:  # %bb.4:
; PPC-NEXT:    ori 5, 6, 0
; PPC-NEXT:    b .LBB4_6
; PPC-NEXT:  .LBB4_5:
; PPC-NEXT:    addi 5, 3, 0
; PPC-NEXT:  .LBB4_6:
; PPC-NEXT:    bclr 12, 1, 0
; PPC-NEXT:  # %bb.7:
; PPC-NEXT:    ori 3, 6, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_vec:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    addis 6, 2, .LCPI4_0@toc@ha
; PPC64LE-NEXT:    mtfprwz 0, 3
; PPC64LE-NEXT:    addis 3, 2, .LCPI4_1@toc@ha
; PPC64LE-NEXT:    addi 6, 6, .LCPI4_0@toc@l
; PPC64LE-NEXT:    mtfprwz 2, 4
; PPC64LE-NEXT:    addi 3, 3, .LCPI4_1@toc@l
; PPC64LE-NEXT:    addis 4, 2, .LCPI4_2@toc@ha
; PPC64LE-NEXT:    lxvd2x 1, 0, 6
; PPC64LE-NEXT:    mtvsrwz 36, 5
; PPC64LE-NEXT:    xxmrghw 34, 2, 0
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    addi 3, 4, .LCPI4_2@toc@l
; PPC64LE-NEXT:    addis 4, 2, .LCPI4_4@toc@ha
; PPC64LE-NEXT:    addi 4, 4, .LCPI4_4@toc@l
; PPC64LE-NEXT:    xxswapd 35, 1
; PPC64LE-NEXT:    lxvd2x 1, 0, 3
; PPC64LE-NEXT:    addis 3, 2, .LCPI4_3@toc@ha
; PPC64LE-NEXT:    addi 3, 3, .LCPI4_3@toc@l
; PPC64LE-NEXT:    vperm 2, 4, 2, 3
; PPC64LE-NEXT:    vspltisw 3, -11
; PPC64LE-NEXT:    xxswapd 36, 0
; PPC64LE-NEXT:    xxswapd 37, 1
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    lxvd2x 1, 0, 4
; PPC64LE-NEXT:    addis 3, 2, .LCPI4_5@toc@ha
; PPC64LE-NEXT:    addi 3, 3, .LCPI4_5@toc@l
; PPC64LE-NEXT:    vsrw 3, 3, 3
; PPC64LE-NEXT:    vsubuwm 2, 2, 4
; PPC64LE-NEXT:    xxswapd 36, 0
; PPC64LE-NEXT:    lxvd2x 0, 0, 3
; PPC64LE-NEXT:    vmuluwm 2, 2, 5
; PPC64LE-NEXT:    xxswapd 37, 1
; PPC64LE-NEXT:    xxland 32, 34, 35
; PPC64LE-NEXT:    vslw 2, 2, 4
; PPC64LE-NEXT:    vsrw 4, 0, 5
; PPC64LE-NEXT:    xxlor 1, 36, 34
; PPC64LE-NEXT:    xxswapd 34, 0
; PPC64LE-NEXT:    xxland 35, 1, 35
; PPC64LE-NEXT:    vcmpgtuw 2, 3, 2
; PPC64LE-NEXT:    xxswapd 0, 34
; PPC64LE-NEXT:    xxsldwi 1, 34, 34, 1
; PPC64LE-NEXT:    mfvsrwz 5, 34
; PPC64LE-NEXT:    mffprwz 3, 0
; PPC64LE-NEXT:    mffprwz 4, 1
; PPC64LE-NEXT:    blr
  %urem = urem <3 x i11> %X, <i11 6, i11 7, i11 -5>
  %cmp = icmp ne <3 x i11> %urem, <i11 0, i11 1, i11 2>
  ret <3 x i1> %cmp
}

define i1 @test_urem_oversized(i66 %X) nounwind {
; PPC-LABEL: test_urem_oversized:
; PPC:       # %bb.0:
; PPC-NEXT:    lis 6, -12795
; PPC-NEXT:    ori 6, 6, 40665
; PPC-NEXT:    mulhwu 7, 5, 6
; PPC-NEXT:    lis 9, 12057
; PPC-NEXT:    ori 9, 9, 37186
; PPC-NEXT:    mullw 11, 4, 6
; PPC-NEXT:    addc 7, 11, 7
; PPC-NEXT:    lis 11, -5526
; PPC-NEXT:    ori 11, 11, 61135
; PPC-NEXT:    mulhwu 8, 4, 6
; PPC-NEXT:    addze 8, 8
; PPC-NEXT:    mulhwu 10, 5, 9
; PPC-NEXT:    mullw 4, 4, 9
; PPC-NEXT:    mullw 9, 5, 9
; PPC-NEXT:    addc 7, 9, 7
; PPC-NEXT:    addze 9, 10
; PPC-NEXT:    rotlwi 10, 7, 31
; PPC-NEXT:    mullw 3, 3, 6
; PPC-NEXT:    mullw 6, 5, 6
; PPC-NEXT:    slwi 5, 5, 1
; PPC-NEXT:    add 3, 5, 3
; PPC-NEXT:    rotlwi 5, 6, 31
; PPC-NEXT:    rlwimi 5, 7, 31, 0, 0
; PPC-NEXT:    add 7, 8, 9
; PPC-NEXT:    add 4, 4, 7
; PPC-NEXT:    add 3, 4, 3
; PPC-NEXT:    rlwimi 10, 3, 31, 0, 0
; PPC-NEXT:    cmplw 5, 11
; PPC-NEXT:    cmplwi 1, 10, 13
; PPC-NEXT:    rlwinm 3, 3, 31, 31, 31
; PPC-NEXT:    crand 20, 6, 0
; PPC-NEXT:    crandc 21, 4, 6
; PPC-NEXT:    rlwimi. 3, 6, 1, 30, 30
; PPC-NEXT:    cror 20, 20, 21
; PPC-NEXT:    crnand 20, 2, 20
; PPC-NEXT:    li 3, 1
; PPC-NEXT:    bc 12, 20, .LBB5_1
; PPC-NEXT:    blr
; PPC-NEXT:  .LBB5_1:
; PPC-NEXT:    li 3, 0
; PPC-NEXT:    blr
;
; PPC64LE-LABEL: test_urem_oversized:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    lis 5, 6028
; PPC64LE-NEXT:    ori 5, 5, 51361
; PPC64LE-NEXT:    rldic 5, 5, 33, 2
; PPC64LE-NEXT:    oris 5, 5, 52741
; PPC64LE-NEXT:    ori 5, 5, 40665
; PPC64LE-NEXT:    mulhdu 6, 3, 5
; PPC64LE-NEXT:    mulld 4, 4, 5
; PPC64LE-NEXT:    mulld 5, 3, 5
; PPC64LE-NEXT:    sldi 3, 3, 1
; PPC64LE-NEXT:    add 3, 6, 3
; PPC64LE-NEXT:    add 3, 3, 4
; PPC64LE-NEXT:    lis 4, -8538
; PPC64LE-NEXT:    rotldi 6, 5, 63
; PPC64LE-NEXT:    ori 4, 4, 44780
; PPC64LE-NEXT:    rldimi 6, 3, 63, 0
; PPC64LE-NEXT:    rlwinm 3, 3, 31, 31, 31
; PPC64LE-NEXT:    rldicl 4, 4, 4, 28
; PPC64LE-NEXT:    rlwimi. 3, 5, 1, 30, 30
; PPC64LE-NEXT:    cmpld 1, 6, 4
; PPC64LE-NEXT:    li 3, 1
; PPC64LE-NEXT:    crnand 20, 2, 4
; PPC64LE-NEXT:    isel 3, 0, 3, 20
; PPC64LE-NEXT:    blr
  %urem = urem i66 %X, 1234567890
  %cmp = icmp eq i66 %urem, 0
  ret i1 %cmp
}
