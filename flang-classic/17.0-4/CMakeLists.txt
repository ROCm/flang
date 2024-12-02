cmake_minimum_required(VERSION 3.13.4)

# If we are not building as a part of LLVM, which is usual for flang-classic,
# build flang-classic as a standalone project, using LLVM as an external library:
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  project(flang-classic)
  set(FLANG_CLASSIC_STANDALONE TRUE)
  if ("${CMAKE_VERSION}" VERSION_LESS "3.20.0")
    message(WARNING
      "Your CMake version is ${CMAKE_VERSION}. Starting with LLVM 17.0.0, the "
      "minimum version of CMake required to build LLVM will become 3.20.0, and "
      "using an older CMake will become an error. Please upgrade your CMake to "
      "at least 3.20.0 now to avoid issues in the future!")
  endif()
endif()

add_executable(flang-classic
    flang-classic.cpp
)


target_include_directories(flang-classic
   PUBLIC
   ${CMAKE_SOURCE_DIR}/llvm-classic/llvm/include
   ${CMAKE_SOURCE_DIR}/llvm-classic/clang/include
   ${CMAKE_BINARY_DIR}/llvm-classic/tools/clang/include
   ${CMAKE_BINARY_DIR}/llvm-classic/include
)

target_link_libraries(flang-classic
  PRIVATE 
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAggressiveInstCombine.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUAsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUCodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUDesc.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUDisassembler.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUInfo.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUTargetMCA.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAMDGPUUtils.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAnalysis.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMBinaryFormat.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMBitReader.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMBitstreamReader.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMCFGuard.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMCodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMCore.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebugInfoCodeView.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebuginfod.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebugInfoDWARF.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebugInfoGSYM.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebugInfoMSF.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDebugInfoPDB.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMDemangle.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMFrontendOpenACC.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMFrontendOpenMP.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMGlobalISel.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMInstCombine.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMipo.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMIRReader.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMMC.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMMCDisassembler.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMMCParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMMIRParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMObjCARCOpts.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMObject.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMOption.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMPasses.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMProfileData.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMRemarks.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMScalarOpts.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMSelectionDAG.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMSupport.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMTarget.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMTextAPI.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMTransformUtils.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMVectorize.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMWindowsDriver.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMWindowsManifest.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMX86AsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMX86CodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMX86Desc.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMX86Info.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMAsmPrinter.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMTargetParser.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libLLVMCodeGenTypes.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangBasic.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangDriver.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangEdit.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangFrontend.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangLex.a
      ${CMAKE_BINARY_DIR}/llvm-classic/lib/libclangSerialization.a
  pthread
  dl
  tinfo
  z
)
install(TARGETS flang-classic DESTINATION "${CMAKE_INSTALL_BINDIR}")
