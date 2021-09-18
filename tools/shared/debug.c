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
 * This provides a similar interface to LLVM to emit debug logs on console - DEBUG(),
 * or a file - DEBUG_LOG_FD(). Wherever these macros are used, there must be a DEBUG_ONLY
 * string defined in that source file (.c/.cpp) which "categorizes" the logs.
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "debug.h"

bool debug_log_enable;
char *debug_log_strs;

void debug_log_init(bool enable_debug, const char *debug_strs)
{
  debug_log_enable = enable_debug;
  debug_log_strs = debug_strs == NULL ? NULL : strdup(debug_strs);
}

void debug_log_deinit()
{
  if (debug_log_strs == NULL) return;
  free(debug_log_strs);
}
