// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -no-opaque-pointers -triple amdgcn-amd-amdhsa -target-cpu gfx906 -x hip \
// RUN:  -aux-triple x86_64-unknown-linux-gnu -fcuda-is-device -emit-llvm %s \
// RUN:  -o - | FileCheck %s

// RUN: %clang_cc1 -no-opaque-pointers -triple amdgcn-amd-amdhsa -target-cpu gfx906 -x hip \
// RUN:  -aux-triple x86_64-pc-windows-msvc -fcuda-is-device -emit-llvm %s \
// RUN:  -o - | FileCheck %s

#include "Inputs/cuda.h"

// CHECK-LABEL: @_Z16use_dispatch_ptrPi(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[OUT:%.*]] = alloca i32*, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ADDR:%.*]] = alloca i32*, align 8, addrspace(5)
// CHECK-NEXT:    [[DISPATCH_PTR:%.*]] = alloca i32*, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ASCAST:%.*]] = addrspacecast i32* addrspace(5)* [[OUT]] to i32**
// CHECK-NEXT:    [[OUT_ADDR_ASCAST:%.*]] = addrspacecast i32* addrspace(5)* [[OUT_ADDR]] to i32**
// CHECK-NEXT:    [[DISPATCH_PTR_ASCAST:%.*]] = addrspacecast i32* addrspace(5)* [[DISPATCH_PTR]] to i32**
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast i32 addrspace(1)* [[OUT_COERCE:%.*]] to i32*
// CHECK-NEXT:    store i32* [[TMP0]], i32** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    [[OUT1:%.*]] = load i32*, i32** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    store i32* [[OUT1]], i32** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = call align 4 dereferenceable(64) i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
// CHECK-NEXT:    [[TMP2:%.*]] = addrspacecast i8 addrspace(4)* [[TMP1]] to i32*
// CHECK-NEXT:    store i32* [[TMP2]], i32** [[DISPATCH_PTR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[DISPATCH_PTR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[TMP3]], align 4
// CHECK-NEXT:    [[TMP5:%.*]] = load i32*, i32** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store i32 [[TMP4]], i32* [[TMP5]], align 4
// CHECK-NEXT:    ret void
//
__global__ void use_dispatch_ptr(int* out) {
  const int* dispatch_ptr = (const int*)__builtin_amdgcn_dispatch_ptr();
  *out = *dispatch_ptr;
}

__global__
    // CHECK-LABEL: @_Z12test_ds_fmaxf(
    // CHECK-NEXT:  entry:
    // CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca float, align 4, addrspace(5)
    // CHECK-NEXT:    [[X:%.*]] = alloca float, align 4, addrspace(5)
    // CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[SRC_ADDR]] to float*
    // CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[X]] to float*
    // CHECK-NEXT:    store float [[SRC:%.*]], float* [[SRC_ADDR_ASCAST]], align 4
    // CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[SRC_ADDR_ASCAST]], align 4
    // CHECK-NEXT:    [[TMP1:%.*]] = call contract float @llvm.amdgcn.ds.fmax.f32(float addrspace(3)* @_ZZ12test_ds_fmaxfE6shared, float [[TMP0]], i32 0, i32 0, i1 false)
    // CHECK-NEXT:    store volatile float [[TMP1]], float* [[X_ASCAST]], align 4
    // CHECK-NEXT:    ret void
    //
    void
    test_ds_fmax(float src) {
  __shared__ float shared;
  volatile float x = __builtin_amdgcn_ds_fmaxf(&shared, src, 0, 0, false);
}

// CHECK-LABEL: @_Z12test_ds_faddf(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[X:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[SRC_ADDR]] to float*
// CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[X]] to float*
// CHECK-NEXT:    store float [[SRC:%.*]], float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP1:%.*]] = call contract float @llvm.amdgcn.ds.fadd.f32(float addrspace(3)* @_ZZ12test_ds_faddfE6shared, float [[TMP0]], i32 0, i32 0, i1 false)
// CHECK-NEXT:    store volatile float [[TMP1]], float* [[X_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
__global__ void test_ds_fadd(float src) {
  __shared__ float shared;
  volatile float x = __builtin_amdgcn_ds_faddf(&shared, src, 0, 0, false);
}

// CHECK-LABEL: @_Z12test_ds_fminfPf(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SHARED:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[SHARED_ADDR:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[X:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[SHARED_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[SHARED]] to float**
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[SRC_ADDR]] to float*
// CHECK-NEXT:    [[SHARED_ADDR_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[SHARED_ADDR]] to float**
// CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[X]] to float*
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast float addrspace(1)* [[SHARED_COERCE:%.*]] to float*
// CHECK-NEXT:    store float* [[TMP0]], float** [[SHARED_ASCAST]], align 8
// CHECK-NEXT:    [[SHARED1:%.*]] = load float*, float** [[SHARED_ASCAST]], align 8
// CHECK-NEXT:    store float [[SRC:%.*]], float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    store float* [[SHARED1]], float** [[SHARED_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load float*, float** [[SHARED_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = addrspacecast float* [[TMP1]] to float addrspace(3)*
// CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP4:%.*]] = call contract float @llvm.amdgcn.ds.fmin.f32(float addrspace(3)* [[TMP2]], float [[TMP3]], i32 0, i32 0, i1 false)
// CHECK-NEXT:    store volatile float [[TMP4]], float* [[X_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
__global__ void test_ds_fmin(float src, float *shared) {
  volatile float x = __builtin_amdgcn_ds_fminf(shared, src, 0, 0, false);
}

// CHECK-LABEL: @_Z33test_ret_builtin_nondef_addrspacev(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[X:%.*]] = alloca i8*, align 8, addrspace(5)
// CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast i8* addrspace(5)* [[X]] to i8**
// CHECK-NEXT:    [[TMP0:%.*]] = call align 4 dereferenceable(64) i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
// CHECK-NEXT:    [[TMP1:%.*]] = addrspacecast i8 addrspace(4)* [[TMP0]] to i8*
// CHECK-NEXT:    store i8* [[TMP1]], i8** [[X_ASCAST]], align 8
// CHECK-NEXT:    ret void
//
__device__ void test_ret_builtin_nondef_addrspace() {
  void *x = __builtin_amdgcn_dispatch_ptr();
}

// CHECK-LABEL: @_Z6endpgmv(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    call void @llvm.amdgcn.endpgm()
// CHECK-NEXT:    ret void
//
__global__ void endpgm() {
  __builtin_amdgcn_endpgm();
}

// Check the 64 bit argument is correctly passed to the intrinsic without truncation or assertion.

// CHECK-LABEL: @_Z14test_uicmp_i64Pyyy(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[OUT:%.*]] = alloca i64*, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ADDR:%.*]] = alloca i64*, align 8, addrspace(5)
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8, addrspace(5)
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ASCAST:%.*]] = addrspacecast i64* addrspace(5)* [[OUT]] to i64**
// CHECK-NEXT:    [[OUT_ADDR_ASCAST:%.*]] = addrspacecast i64* addrspace(5)* [[OUT_ADDR]] to i64**
// CHECK-NEXT:    [[A_ADDR_ASCAST:%.*]] = addrspacecast i64 addrspace(5)* [[A_ADDR]] to i64*
// CHECK-NEXT:    [[B_ADDR_ASCAST:%.*]] = addrspacecast i64 addrspace(5)* [[B_ADDR]] to i64*
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast i64 addrspace(1)* [[OUT_COERCE:%.*]] to i64*
// CHECK-NEXT:    store i64* [[TMP0]], i64** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    [[OUT1:%.*]] = load i64*, i64** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    store i64* [[OUT1]], i64** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store i64 [[A:%.*]], i64* [[A_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store i64 [[B:%.*]], i64* [[B_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* [[A_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, i64* [[B_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.amdgcn.icmp.i64.i64(i64 [[TMP1]], i64 [[TMP2]], i32 35)
// CHECK-NEXT:    [[TMP4:%.*]] = load i64*, i64** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store i64 [[TMP3]], i64* [[TMP4]], align 8
// CHECK-NEXT:    ret void
//
__global__ void test_uicmp_i64(unsigned long long *out, unsigned long long a, unsigned long long b)
{
  *out = __builtin_amdgcn_uicmpl(a, b, 30+5);
}

// Check the 64 bit return value is correctly returned without truncation or assertion.

// CHECK-LABEL: @_Z14test_s_memtimePy(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[OUT:%.*]] = alloca i64*, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ADDR:%.*]] = alloca i64*, align 8, addrspace(5)
// CHECK-NEXT:    [[OUT_ASCAST:%.*]] = addrspacecast i64* addrspace(5)* [[OUT]] to i64**
// CHECK-NEXT:    [[OUT_ADDR_ASCAST:%.*]] = addrspacecast i64* addrspace(5)* [[OUT_ADDR]] to i64**
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast i64 addrspace(1)* [[OUT_COERCE:%.*]] to i64*
// CHECK-NEXT:    store i64* [[TMP0]], i64** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    [[OUT1:%.*]] = load i64*, i64** [[OUT_ASCAST]], align 8
// CHECK-NEXT:    store i64* [[OUT1]], i64** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.amdgcn.s.memtime()
// CHECK-NEXT:    [[TMP2:%.*]] = load i64*, i64** [[OUT_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store i64 [[TMP1]], i64* [[TMP2]], align 8
// CHECK-NEXT:    ret void
//
__global__ void test_s_memtime(unsigned long long* out)
{
  *out = __builtin_amdgcn_s_memtime();
}

// Check a generic pointer can be passed as a shared pointer and a generic pointer.
__device__ void func(float *x);

// CHECK-LABEL: @_Z17test_ds_fmin_funcfPf(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SHARED:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[SHARED_ADDR:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[X:%.*]] = alloca float, align 4, addrspace(5)
// CHECK-NEXT:    [[SHARED_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[SHARED]] to float**
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[SRC_ADDR]] to float*
// CHECK-NEXT:    [[SHARED_ADDR_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[SHARED_ADDR]] to float**
// CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast float addrspace(5)* [[X]] to float*
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast float addrspace(1)* [[SHARED_COERCE:%.*]] to float*
// CHECK-NEXT:    store float* [[TMP0]], float** [[SHARED_ASCAST]], align 8
// CHECK-NEXT:    [[SHARED1:%.*]] = load float*, float** [[SHARED_ASCAST]], align 8
// CHECK-NEXT:    store float [[SRC:%.*]], float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    store float* [[SHARED1]], float** [[SHARED_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load float*, float** [[SHARED_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = addrspacecast float* [[TMP1]] to float addrspace(3)*
// CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[SRC_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP4:%.*]] = call contract float @llvm.amdgcn.ds.fmin.f32(float addrspace(3)* [[TMP2]], float [[TMP3]], i32 0, i32 0, i1 false)
// CHECK-NEXT:    store volatile float [[TMP4]], float* [[X_ASCAST]], align 4
// CHECK-NEXT:    [[TMP5:%.*]] = load float*, float** [[SHARED_ADDR_ASCAST]], align 8
// CHECK-NEXT:    call void @_Z4funcPf(float* [[TMP5]]) #[[ATTR8:[0-9]+]]
// CHECK-NEXT:    ret void
//
__global__ void test_ds_fmin_func(float src, float *__restrict shared) {
  volatile float x = __builtin_amdgcn_ds_fminf(shared, src, 0, 0, false);
  func(shared);
}

// CHECK-LABEL: @_Z14test_is_sharedPf(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[X:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[X_ADDR:%.*]] = alloca float*, align 8, addrspace(5)
// CHECK-NEXT:    [[RET:%.*]] = alloca i8, align 1, addrspace(5)
// CHECK-NEXT:    [[X_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[X]] to float**
// CHECK-NEXT:    [[X_ADDR_ASCAST:%.*]] = addrspacecast float* addrspace(5)* [[X_ADDR]] to float**
// CHECK-NEXT:    [[RET_ASCAST:%.*]] = addrspacecast i8 addrspace(5)* [[RET]] to i8*
// CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast float addrspace(1)* [[X_COERCE:%.*]] to float*
// CHECK-NEXT:    store float* [[TMP0]], float** [[X_ASCAST]], align 8
// CHECK-NEXT:    [[X1:%.*]] = load float*, float** [[X_ASCAST]], align 8
// CHECK-NEXT:    store float* [[X1]], float** [[X_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load float*, float** [[X_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast float* [[TMP1]] to i8*
// CHECK-NEXT:    [[TMP3:%.*]] = call i1 @llvm.amdgcn.is.shared(i8* [[TMP2]])
// CHECK-NEXT:    [[FROMBOOL:%.*]] = zext i1 [[TMP3]] to i8
// CHECK-NEXT:    store i8 [[FROMBOOL]], i8* [[RET_ASCAST]], align 1
// CHECK-NEXT:    ret void
//
__global__ void test_is_shared(float *x){
  bool ret = __builtin_amdgcn_is_shared(x);
}
