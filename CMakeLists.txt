#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# 
# Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
# Notified per clause 4(b) of the license.
#
# Last Modified: May 2020
#

cmake_minimum_required(VERSION 2.8)
cmake_policy(SET CMP0057 NEW)

if(${ENABLE_DEVEL_PACKAGE})
  set(DEVEL_PACKAGE "devel/")
endif()
if(${ENABLE_RUN_PACKAGE})
  set(RUN_PACKAGE "runtime/")
endif()

# In order to bootstrap the runtime library we need to skip
# CMake's Fortran tests
SET(CMAKE_Fortran_COMPILER_WORKS 1)

if( NOT DEFINED TARGET_ARCHITECTURE )
  execute_process(COMMAND uname -m OUTPUT_STRIP_TRAILING_WHITESPACE
                  OUTPUT_VARIABLE TARGET_ARCHITECTURE)
endif()

if( NOT DEFINED TARGET_OS )
  execute_process(COMMAND uname -s OUTPUT_STRIP_TRAILING_WHITESPACE
                  OUTPUT_VARIABLE TARGET_OS)
endif()

if( ${TARGET_OS} STREQUAL "Linux" )
  set(OS "LINUX")
  set(OSNAME "Linux")
  if( ${TARGET_ARCHITECTURE} STREQUAL "x86_64" )
    set(ARCHNAME x86-64)
    set(ARCH X86)
    set(WRDSZ 64)
  elseif( ${TARGET_ARCHITECTURE} STREQUAL "aarch64" )
    set(ARCHNAME aarch64)
    set(ARCH ARM)
    set(WRDSZ 64)
  elseif( ${TARGET_ARCHITECTURE} STREQUAL "ppc64le" )
    set(ARCHNAME ppc64le)
    set(ARCH POWER)
    set(WRDSZ 64)
  else()
    message("Unsupported architecture: ${TARGET_ARCHITECTURE}" )
    return()
  endif()
else()
  message("Unsupported OS: ${TARGET_OS}" )
  return()
endif()

# The cmake documentation states that these are set.  They are not so we 
# set them here
set(CMAKE_HOST_SYSTEM_NAME ${TARGET_OS})
set(CMAKE_HOST_SYSTEM_PROCESSOR ${TARGET_ARCHITECTURE})

# If we are not building as a part of LLVM, build Flang as an
# standalone project, using LLVM as an external library:
if( CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR )
  project(Flang)
  # Set default libdir to be "lib" for ROCm, distros will override this anyway:
  set(CMAKE_INSTALL_LIBDIR "lib" CACHE STRING "Library install directory")
  include(GNUInstallDirs)
  # Rely on llvm-config.
  set(CONFIG_OUTPUT)

  if (NOT DEFINED LLVM_CONFIG)
    find_program(LLVM_CONFIG "llvm-config")
  endif()

  if(LLVM_CONFIG)
    message(STATUS "Found LLVM_CONFIG as ${LLVM_CONFIG}")
    set(CONFIG_COMMAND ${LLVM_CONFIG}
      "--assertion-mode"
      "--bindir"
      "--libdir"
      "--includedir"
      "--prefix")
    execute_process(
      COMMAND ${CONFIG_COMMAND}
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE CONFIG_OUTPUT
    )
    if(NOT HAD_ERROR)
      string(REGEX REPLACE
        "[ \t]*[\r\n]+[ \t]*" ";"
        CONFIG_OUTPUT ${CONFIG_OUTPUT})
    else()
      string(REPLACE ";" " " CONFIG_COMMAND_STR "${CONFIG_COMMAND}")
      message(STATUS "${CONFIG_COMMAND_STR}")
      message(FATAL_ERROR "llvm-config failed with status ${HAD_ERROR}")
    endif()
  else()
    message(FATAL_ERROR "llvm-config not found -- ${LLVM_CONFIG}")
  endif()

  list(GET CONFIG_OUTPUT 0 ENABLE_ASSERTIONS)
  list(GET CONFIG_OUTPUT 1 TOOLS_BINARY_DIR)
  list(GET CONFIG_OUTPUT 2 LIBRARY_DIR)
  list(GET CONFIG_OUTPUT 3 INCLUDE_DIR)
  list(GET CONFIG_OUTPUT 4 LLVM_OBJ_ROOT)
  list(GET CONFIG_OUTPUT 5 MAIN_SRC_DIR)

  if(NOT MSVC_IDE)
    set(LLVM_ENABLE_ASSERTIONS ${ENABLE_ASSERTIONS}
      CACHE BOOL "Enable assertions")
    # Assertions should follow llvm-config's.
    mark_as_advanced(LLVM_ENABLE_ASSERTIONS)
  endif()

  set(LLVM_TOOLS_BINARY_DIR ${TOOLS_BINARY_DIR} CACHE PATH "Path to llvm/bin")
  set(LLVM_LIBRARY_DIR ${LIBRARY_DIR} CACHE PATH "Path to llvm/lib")
  set(LLVM_MAIN_INCLUDE_DIR ${INCLUDE_DIR} CACHE PATH "Path to llvm/include")
  set(LLVM_BINARY_DIR ${LLVM_OBJ_ROOT} CACHE PATH "Path to LLVM build tree")
  set(LLVM_MAIN_SRC_DIR ${MAIN_SRC_DIR} CACHE PATH "Path to LLVM source tree")

  set(LLVM_CMAKE_PATH "${LLVM_BINARY_DIR}/lib/cmake/llvm"
     CACHE PATH "Path to LLVM cmake modules")
  set(LLVMCONFIG_FILE "${LLVM_CMAKE_PATH}/LLVMConfig.cmake")
  if(EXISTS ${LLVMCONFIG_FILE})
    list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_PATH}")
    include(${LLVMCONFIG_FILE})
  else()
    # try where it was before LLVM 3.9
    set(LLVM_CMAKE_PATH "${LLVM_BINARY_DIR}/share/llvm/cmake")
    set(LLVMCONFIG_FILE "${LLVM_CMAKE_PATH}/LLVMConfig.cmake")
    if(EXISTS ${LLVMCONFIG_FILE})
      list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_PATH}")
      include(${LLVMCONFIG_FILE})
    else()
      message(FATAL_ERROR "Not found: ${LLVMCONFIG_FILE}")
    endif()
  endif()

  # They are used as destination of target generators.
  set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/bin)
  set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/lib)

  option(LLVM_INSTALL_TOOLCHAIN_ONLY
    "Only include toolchain files in the 'install' target." OFF)

  option(LLVM_INSTALL_RUNTIME
     "Build and install the flang runtime. Do this last" OFF)

  option(LLVM_FORCE_USE_OLD_HOST_TOOLCHAIN
    "Set to ON to force using an old, unsupported host toolchain." OFF)

  include(AddLLVM)
  include(HandleLLVMOptions)

  set(PACKAGE_VERSION "${LLVM_PACKAGE_VERSION}")

  if (NOT DEFINED LLVM_INCLUDE_TESTS)
    set(LLVM_INCLUDE_TESTS ON)
  endif()

  include_directories("${LLVM_BINARY_DIR}/include" "${LLVM_MAIN_INCLUDE_DIR}")
  link_directories("${LLVM_LIBRARY_DIR}")

  set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
  set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
  set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
  if(LLVM_INCLUDE_TESTS)
    set(Python_ADDITIONAL_VERSIONS 2.7)
    include(FindPythonInterp)
    if(NOT PYTHONINTERP_FOUND)
      message(FATAL_ERROR
"Unable to find Python interpreter, required for builds and testing.

Please install Python or specify the PYTHON_EXECUTABLE CMake variable.")
    endif()

    if( ${PYTHON_VERSION_STRING} VERSION_LESS 2.7 )
      message(FATAL_ERROR "Python 2.7 or newer is required")
    endif()

    # Check prebuilt llvm/utils.
    if(EXISTS ${LLVM_TOOLS_BINARY_DIR}/FileCheck${CMAKE_EXECUTABLE_SUFFIX}
        AND EXISTS ${LLVM_TOOLS_BINARY_DIR}/count${CMAKE_EXECUTABLE_SUFFIX}
        AND EXISTS ${LLVM_TOOLS_BINARY_DIR}/not${CMAKE_EXECUTABLE_SUFFIX})
      set(LLVM_UTILS_PROVIDED ON)
    endif()

   if (NOT LLVM_INSTALL_RUNTIME)

    if(EXISTS ${LLVM_MAIN_SRC_DIR}/utils/lit/lit.py)
      set(LLVM_LIT ${LLVM_MAIN_SRC_DIR}/utils/lit/lit.py)
      if(NOT LLVM_UTILS_PROVIDED)
        add_subdirectory(${LLVM_MAIN_SRC_DIR}/utils/FileCheck utils/FileCheck)
        add_subdirectory(${LLVM_MAIN_SRC_DIR}/utils/count utils/count)
        add_subdirectory(${LLVM_MAIN_SRC_DIR}/utils/not utils/not)
        set(LLVM_UTILS_PROVIDED ON)
        set(FLANG_TEST_DEPS FileCheck count not)
      endif()
     endif()
      #set(UNITTEST_DIR ${LLVM_MAIN_SRC_DIR}/utils/unittest)
      #if(EXISTS ${UNITTEST_DIR}/googletest/include/gtest/gtest.h
      #    AND NOT EXISTS ${LLVM_LIBRARY_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX}
      #    AND EXISTS ${UNITTEST_DIR}/CMakeLists.txt)
      #  add_subdirectory(${UNITTEST_DIR} utils/unittest)
      #endif()
    else()
      # Seek installed Lit.
      find_program(LLVM_LIT "lit.py" ${LLVM_MAIN_SRC_DIR}/utils/lit
        DOC "Path to lit.py")
    endif()

    if(LLVM_LIT)
      # Define the default arguments to use with 'lit', and an option for the user
      # to override.
      set(LIT_ARGS_DEFAULT "-sv")
      if (MSVC OR XCODE)
        set(LIT_ARGS_DEFAULT "${LIT_ARGS_DEFAULT} --no-progress-bar")
      endif()
      set(LLVM_LIT_ARGS "${LIT_ARGS_DEFAULT}" CACHE STRING "Default options for lit")

      # On Win32 hosts, provide an option to specify the path to the GnuWin32 tools.
      if( WIN32 AND NOT CYGWIN )
        set(LLVM_LIT_TOOLS_DIR "" CACHE PATH "Path to GnuWin32 tools")
      endif()
    else()
      set(LLVM_INCLUDE_TESTS OFF)
    endif()
  endif()

  set( FLANG_BUILT_STANDALONE 1 )
  set(BACKEND_PACKAGE_STRING "LLVM ${LLVM_PACKAGE_VERSION}")
else()
  set(BACKEND_PACKAGE_STRING "${PACKAGE_STRING}")
endif()

set(FLANG_RESOURCE_DIR "" CACHE STRING
  "Relative directory from the Flang binary to its resource files.")

set(C_INCLUDE_DIRS "" CACHE STRING
  "Colon separated list of directories flang will search for headers.")

set(GCC_INSTALL_PREFIX "" CACHE PATH "Directory where gcc is installed." )
set(DEFAULT_SYSROOT "" CACHE PATH
  "Default <path> to all compiler invocations for --sysroot=<path>." )

set(FLANG_VENDOR "" CACHE STRING
  "Vendor-specific text for showing with version information.")

if( FLANG_VENDOR )
  add_definitions( -DFLANG_VENDOR="${FLANG_VENDOR} " )
endif()

set(FLANG_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(FLANG_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})

set(FLANG_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

if( CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR AND NOT MSVC_IDE )
  message(FATAL_ERROR "In-source builds are not allowed. CMake would overwrite "
"the makefiles distributed with LLVM. Please create a directory and run cmake "
"from there, passing the path to this source directory as the last argument. "
"This process created the file `CMakeCache.txt' and the directory "
"`CMakeFiles'. Please delete them.")
endif()

#if( NOT CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR )
#  file(GLOB_RECURSE
#    tablegenned_files_on_include_dir
#    "${FLANG_SOURCE_DIR}/include/flang/*.inc")
#  if( tablegenned_files_on_include_dir )
#    message(FATAL_ERROR "Apparently there is a previous in-source build, "
#"probably as the result of running `configure' and `make' on "
#"${FLANG_SOURCE_DIR}. This may cause problems. The suspicious files are:\n"
#"${tablegenned_files_on_include_dir}\nPlease clean the source directory.")
#  endif()
#endif()

# Compute the Flang version from the LLVM version.
string(REGEX MATCH "[0-9]+\\.[0-9]+(\\.[0-9]+)?" FLANG_VERSION
  ${PACKAGE_VERSION})
message(STATUS "Flang version: ${FLANG_VERSION}")

string(REGEX REPLACE "([0-9]+)\\.[0-9]+(\\.[0-9]+)?" "\\1" FLANG_VERSION_MAJOR
  ${FLANG_VERSION})
string(REGEX REPLACE "[0-9]+\\.([0-9]+)(\\.[0-9]+)?" "\\1" FLANG_VERSION_MINOR
  ${FLANG_VERSION})
if (${FLANG_VERSION} MATCHES "[0-9]+\\.[0-9]+\\.[0-9]+")
  set(FLANG_HAS_VERSION_PATCHLEVEL 1)
  string(REGEX REPLACE "[0-9]+\\.[0-9]+\\.([0-9]+)" "\\1" FLANG_VERSION_PATCHLEVEL
    ${FLANG_VERSION})
else()
  set(FLANG_HAS_VERSION_PATCHLEVEL 0)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcommon -Wno-implicit-function-declaration -Wno-implicit-int -Wno-int-conversion -Wno-enum-constexpr-conversion -Wno-incompatible-function-pointer-types -w")

# Add appropriate flags for GCC
if (LLVM_COMPILER_IS_GCC_COMPATIBLE)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fno-common -Woverloaded-virtual -Wcast-qual -fno-strict-aliasing -pedantic -Wno-long-long -Wall -W -Wno-unused-parameter -Wwrite-strings -DOMP_OFFLOAD_LLVM -Wno-implicit-function-declaration -Wno-implicit-int -Wno-enum-constexpr-conversion -Wno-incompatible-function-pointer-types -w")
  option(WITH_WERROR "Compile with '-Werror' C compiler flag" ON)
  if (WITH_WERROR)
	  # set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")
  endif ()
endif ()

if (APPLE)
  set(CMAKE_MODULE_LINKER_FLAGS "-Wl,-flat_namespace -Wl,-undefined -Wl,suppress")
endif ()

find_library(LIBQUADMATH_LOC quadmath NAMES libquadmath.so libquadmath.so.0 REQUIRED)

macro(add_flang_library name)
  llvm_process_sources(srcs ${ARGN})
  if (MODULE)
    set(libkind MODULE)
  elseif (SHARED_LIBRARY)
    set(libkind SHARED)
  else()
    set(libkind)
  endif()
  add_library( ${name} ${libkind} ${srcs} )
  llvm_update_compile_flags(${name} ${srcs})
  if( LLVM_COMMON_DEPENDS )
    add_dependencies( ${name} ${LLVM_COMMON_DEPENDS} )
  endif( LLVM_COMMON_DEPENDS )

  llvm_config( ${name} ${LLVM_LINK_COMPONENTS} )
  target_link_libraries( ${name} ${LLVM_COMMON_LIBS} ${LIBQUADMATH_LOC})
#  link_system_libs( ${name} )  # getd of cmake warning messages

  install(TARGETS ${name}
    LIBRARY DESTINATION ${RUN_PACKAGE}${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${RUN_PACKAGE}${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${DEVEL_PACKAGE}${CMAKE_INSTALL_BINDIR})
  set_target_properties(${name} PROPERTIES FOLDER "Flang libraries")
endmacro(add_flang_library)

macro(add_flang_executable name)
  add_llvm_executable( ${name} ${ARGN} )
  set_target_properties(${name} PROPERTIES FOLDER "Flang executables")
endmacro(add_flang_executable)

include_directories(BEFORE
  ${CMAKE_CURRENT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  )

# Direct module files to build include directory
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)

if (FLANG_BUILD_RUNTIME)
# Install Fortran module files
install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
  DESTINATION ${DEVEL_PACKAGE}${CMAKE_INSTALL_INCLUDEDIR}
  )
endif()

# Install Fortran OpenMP include file
# Copy omp_lib.h file, not the symlink
get_filename_component(OMP_LIB_H_PATH ${CMAKE_CURRENT_SOURCE_DIR}/include/omp_lib.h REALPATH)
install(FILES ${OMP_LIB_H_PATH}
  DESTINATION ${DEVEL_PACKAGE}${CMAKE_INSTALL_INCLUDEDIR}
  )

add_definitions( -D_GNU_SOURCE )

# Flang version information
set(FLANG_EXECUTABLE_VERSION
     "${FLANG_VERSION_MAJOR}.${FLANG_VERSION_MINOR}" CACHE STRING
    "Version number that will be placed into the flang executable, in the form XX.YY")
set(LIBFLANG_LIBRARY_VERSION
     "${FLANG_VERSION_MAJOR}.${FLANG_VERSION_MINOR}" CACHE STRING
    "Version number that will be placed into the libflang library , in the form XX.YY")
mark_as_advanced(FLANG_EXECUTABLE_VERSION LIBFLANG_LIBRARY_VERSION)

option(FLANG_LLVM_EXTENSIONS "enable the Flang LLVM extensions" OFF)

if ( FLANG_EXECUTABLE_VERSION )
  add_definitions( -DFLANG_VERSION="${FLANG_EXECUTABLE_VERSION} " )
  add_definitions( -DFLANG_VERSION_MAJOR="${FLANG_VERSION_MAJOR} " )
  add_definitions( -DFLANG_VERSION_MINOR="${FLANG_VERSION_MINOR} " )
endif()
execute_process(COMMAND git log -1 --format=format:%H WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} OUTPUT_VARIABLE FLANG_SHA RESULT_VARIABLE rc)

if(NOT rc EQUAL "0")
  add_definitions( -DFLANG_SHA="Classic-Flang Sha NULL ")
  message("Warning: Unable to get Classic-Flang Sha. Return Code: ${rc} Classic-Flang Sha: NULL!!!")
else()
  string(STRIP ${FLANG_SHA} FLANG_SHA)
  message(STATUS "MY_VAR=${FLANG_SHA}")
  add_definitions( -DFLANG_SHA="Classic-Flang Sha ${FLANG_SHA} ")
endif()

option(FLANG_INCLUDE_TESTS
       "Generate build targets for the Flang unit tests."
       ${LLVM_INCLUDE_TESTS})
# Not needed (yet?); other flang uses it to invoke tablegen for generating doc/errmsg(?) files
#add_subdirectory(include)

# All targets below may depend on all tablegen'd files
get_property(FLANG_TABLEGEN_TARGETS GLOBAL PROPERTY FLANG_TABLEGEN_TARGETS)
list(APPEND LLVM_COMMON_DEPENDS ${FLANG_TABLEGEN_TARGETS})

set(FLANG_LIB_DIR ${CMAKE_CURRENT_BINARY_DIR}/lib)
set(FLANG_RTE_LIB_DIR ${CMAKE_CURRENT_BINARY_DIR}/lib)
add_definitions( -DPGFLANG )

if (LLVM_INSTALL_RUNTIME)
   add_subdirectory(runtime)
else()
   add_subdirectory(lib)
   add_subdirectory(utils)
   add_subdirectory(tools)
   #add_subdirectory(test)
endif()

#option(FLANG_BUILD_EXAMPLES "Build FLANG example programs by default." OFF)
#if (FLANG_BUILD_EXAMPLES)
#  set(ENABLE_FLANG_EXAMPLES "1")
#else()
#  set(ENABLE_FLANG_EXAMPLES "0")
#endif()
#add_subdirectory(examples)

option(FLANG_OPENMP_GPU_NVIDIA "Enable OpenMP Accelerator Offload." OFF)
if (FLANG_OPENMP_GPU_NVIDIA)
  add_definitions("-DOMP_OFFLOAD_LLVM")
endif()

# AOCC Begin
option(FLANG_OPENMP_GPU_AMD "Enable OpenMP AMD Accelerator Offload." OFF)
if (FLANG_OPENMP_GPU_AMD)
  add_definitions("-DOMP_OFFLOAD_AMD")
endif()

if (FLANG_OPENMP_GPU_NVIDIA OR FLANG_OPENMP_GPU_AMD)
  set(OMP_OFFLOADING_BUILD 1)
endif()
# AOCC End

if( FLANG_INCLUDE_TESTS )
#  if(EXISTS ${LLVM_MAIN_SRC_DIR}/utils/unittest/googletest/include/gtest/gtest.h)
#    add_subdirectory(unittests)
#    list(APPEND FLANG_TEST_DEPS FlangUnitTests)
#    list(APPEND FLANG_TEST_PARAMS
#      flang_unit_site_config=${CMAKE_CURRENT_BINARY_DIR}/test/Unit/lit.site.cfg
#      )
#  endif()
  add_subdirectory(test)

  if(FLANG_BUILT_STANDALONE)
    # Add a global check rule now that all subdirectories have been traversed
    # and we know the total set of lit testsuites.
    get_property(LLVM_LIT_TESTSUITES GLOBAL PROPERTY LLVM_LIT_TESTSUITES)
    get_property(LLVM_LIT_PARAMS GLOBAL PROPERTY LLVM_LIT_PARAMS)
    get_property(LLVM_LIT_DEPENDS GLOBAL PROPERTY LLVM_LIT_DEPENDS)
    get_property(LLVM_LIT_EXTRA_ARGS GLOBAL PROPERTY LLVM_LIT_EXTRA_ARGS)
    add_lit_target(check-all
      "Running all regression tests"
      ${LLVM_LIT_TESTSUITES}
      PARAMS ${LLVM_LIT_PARAMS}
      DEPENDS ${LLVM_LIT_DEPENDS}
      ARGS ${LLVM_LIT_EXTRA_ARGS}
      )
  endif()
#  add_subdirectory(utils/perf-training)
endif()

option(FLANG_INCLUDE_DOCS "Generate build targets for the Flang docs."
  ${LLVM_INCLUDE_DOCS})
if (FLANG_INCLUDE_DOCS)
  add_subdirectory(docs)
endif()

# Local Variables:
# mode: cmake
# End:
