/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/*
 * Copyright (c) 2021 Advanced Micro Devices, Inc. All rights reserved.
 *
 */

/*
 * This provides a similar interface to LLVM to emit debug logs on console - DEBUG_LOG(),
 * or a file - DEBUG_LOG_FD(). Wherever these macros are used, there must be a DEBUG_ONLY
 * string defined in that source file (.c/.cpp) which "categorizes" the logs.
 */

#ifndef DEBUG_H_
#define DEBUG_H_

#include <stdbool.h>

#ifdef DEBUG

  /**
   * \brief Defines if debug logging is enabled or not (fetched from flang1exe/main.c).
   */
  extern bool debug_log_enable;

  /**
   * \brief Contains all -debug-only command line argument strings (fetched from flang1exe/main.c).
   */
  extern char *debug_log_strs;

  /**
   * \brief Initializes the debug log system.
   *
   * \param enable_debug Enable or disable the debug log system.
   * \param debug_strs Specific strings (types) to enable for debugging (NULLable).
   */
  void debug_log_init(bool enable_debug, const char *debug_strs);
  /**
   * \brief Deinitializes the debug log system.
   *
   */
  void debug_log_deinit();

  /**
   * \brief Writes debug information on given file descriptor IFF debug_enable is true
            or debug_strs contains the type string.
   *
   * \param fd The file descriptor to write debug information to.
   * \param only_str String, defining debug category (type).
   */
  #define DEBUG_LOG_CORE(fd, only_str, ...)                                                       \
    if (debug_log_enable || (debug_log_strs != NULL && strstr(debug_log_strs, only_str) != NULL)) \
      do { fprintf(fd, __VA_ARGS__); } while (false)                                              \

  /**
   * \brief Initializes the debug log system.
   *
   * \param enable_debug Enable or disable the debug log system.
   * \param debug_strs Specific strings (types) to enable for debugging (NULLable).
   */
  #define DEBUG_LOG_INIT(enable_debug, debug_strs) debug_log_init(enable_debug, debug_strs)

  /**
   * \brief Deinitializes the debug log system.
   *
   */
  #define DEBUG_LOG_DEINIT() debug_log_deinit()

#else // DEBUG

  /**
   * \brief Writes debug information on given file descriptor IFF debug_enable is true
            or debug_strs contains the type string.
   *
   * \param fd The file descriptor to write debug information to.
   * \param type String, defining debug category (type).
   */
  #define DEBUG_LOG_CORE(fd, type, ...) do {} while (false)

  /**
   * \brief Initializes the debug log system.
   *
   * \param enable_debug Enable or disable the debug log system.
   * \param debug_strs Specific strings (types) to enable for debugging (NULLable).
   */
  #define DEBUG_LOG_INIT(enable_debug, debug_strs) do {} while (false)

  /**
   * \brief Deinitializes the debug log system.
   *
   */
  #define DEBUG_LOG_DEINIT() do {} while (false)

#endif // DEBUG

/**
 * \brief Writes debug information on given file descriptor IFF debugging is enabled.
 *
 * \param fd The file descriptor to write debug information to.
 * \param type String, defining debug category (type).
 */
#define DEBUG_LOG_FD(fd, ...) DEBUG_LOG_CORE(fd, DEBUG_ONLY, __VA_ARGS__)

/**
 * \brief Used to output debug information. Uses DEBUG_ONLY, writes on stderr by default.
 *
 * \param variadic information to print - in printf set of functions' format.
 */
#define DEBUG_LOG(...) DEBUG_LOG_FD(stderr, __VA_ARGS__)

#endif // DEBUG_H_
