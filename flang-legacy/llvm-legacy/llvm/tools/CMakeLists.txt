# This file will recurse into all subdirectories that contain CMakeLists.txt
# Setting variables that match the pattern LLVM_TOOL_{NAME}_BUILD to Off will
# prevent traversing into a directory.
#
# The only tools that need to be explicitly added are ones that have explicit
# ordering requirements.

# Iterates all the subdirectories to create CMake options to enable/disable
# traversing each directory.
#create_llvm_tool_options()

# Projects supported via LLVM_EXTERNAL_*_SOURCE_DIR need to be explicitly
# specified.
add_llvm_external_project(clang)
