# Returns the host triple.
# Invokes config.guess
# 
# Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
# Notified per clause 4(b) of the license.
#
# Last Modified: May 2020
#

function( get_host_triple var )
  if( MSVC )
    if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
      set( value "x86_64-pc-win32" )
    else()
      set( value "i686-pc-win32" )
    endif()
  elseif( MINGW AND NOT MSYS )
    if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
      set( value "x86_64-w64-mingw32" )
    else()
      set( value "i686-pc-mingw32" )
    endif()
  else( MSVC )
#
# AOCC: removing usage of config.guess and hardcoding target-triple
#    
#    set(config_guess ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.guess)
#    execute_process(COMMAND sh ${config_guess}
#      RESULT_VARIABLE TT_RV
#      OUTPUT_VARIABLE TT_OUT
#      OUTPUT_STRIP_TRAILING_WHITESPACE)
#    if( NOT TT_RV EQUAL 0 )
#      message(FATAL_ERROR "Failed to execute ${config_guess}")
#    endif( NOT TT_RV EQUAL 0 )
    set( value "x86_64-unknown-linux-gnu")
  endif( MSVC )
  set( ${var} ${value} PARENT_SCOPE )
endfunction( get_host_triple var )
