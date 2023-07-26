cmake_minimum_required(VERSION 3.13.4)

# If we are not building as a part of LLVM, which is usual for flang-legacy,
# build flang-legacy as a standalone project, using LLVM as an external library:
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  project(flang-legacy)
  set(FLANG_LEGACY_STANDALONE TRUE)
  if ("${CMAKE_VERSION}" VERSION_LESS "3.20.0")
    message(WARNING
      "Your CMake version is ${CMAKE_VERSION}. Starting with LLVM 17.0.0, the "
      "minimum version of CMake required to build LLVM will become 3.20.0, and "
      "using an older CMake will become an error. Please upgrade your CMake to "
      "at least 3.20.0 now to avoid issues in the future!")
  endif()
endif()

add_executable(flang-legacy
    flang-legacy.cpp
)


target_include_directories(flang-legacy
   PUBLIC
   ${CMAKE_SOURCE_DIR}/llvm-legacy/llvm/include
   ${CMAKE_SOURCE_DIR}/llvm-legacy/clang/include
   ${CMAKE_BINARY_DIR}/llvm-legacy/tools/clang/include
   ${CMAKE_BINARY_DIR}/llvm-legacy/include
)

target_link_libraries(flang-legacy
  PRIVATE 
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAggressiveInstCombine.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUAsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUCodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUDesc.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUDisassembler.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUInfo.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUTargetMCA.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAMDGPUUtils.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAnalysis.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMBinaryFormat.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMBitReader.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMBitstreamReader.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMCFGuard.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMCodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMCore.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebugInfoCodeView.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebuginfod.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebugInfoDWARF.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebugInfoGSYM.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebugInfoMSF.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDebugInfoPDB.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMDemangle.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMFrontendOpenACC.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMFrontendOpenMP.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMGlobalISel.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMInstCombine.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMipo.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMIRReader.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMMC.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMMCDisassembler.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMMCParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMMIRParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMObjCARCOpts.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMObject.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMOption.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMPasses.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMProfileData.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMRemarks.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMScalarOpts.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMSelectionDAG.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMSupport.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMTarget.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMTextAPI.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMTransformUtils.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMVectorize.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMWindowsDriver.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMWindowsManifest.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMX86AsmParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMX86CodeGen.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMX86Desc.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMX86Info.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMAsmPrinter.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMTargetParser.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libLLVMCodeGenTypes.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangBasic.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangDriver.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangEdit.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangFrontend.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangLex.a
      ${CMAKE_BINARY_DIR}/llvm-legacy/lib/libclangSerialization.a
  pthread
  dl
  tinfo
  z
)
install(TARGETS flang-legacy DESTINATION "${CMAKE_INSTALL_BINDIR}")
