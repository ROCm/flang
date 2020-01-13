
/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/* clang-format off */

/*
 * Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
 *
 * Support for execute command line intrinsic
 *
 */

/*===----------------------------------------------------------------------===!
 * exec_cmd_line.c - Implements F2008 exececute_command_line intrinsic.  
 *
 * COMMAND shall be a default character scalar. It is an INTENT (IN) argument.
 * Its value is the command line to be executed. 
 * The interpretation is processor dependent.
 *
 * WAIT (optional) shall be a default logical scalar. 
 * It is an INTENT (IN) argument. If WAIT is present with the
 * value false, and the processor supports asynchronous execution of the command,
 * the command is executed asynchronously; otherwise it is executed synchronously.
 *
 * EXITSTAT (optional) shall be a default integer scalar. 
 * It is an INTENT (INOUT) argument. 
 * If the command is executed synchronously, it is assigned the value of the
 * processor-dependent exit status. Otherwise, the value of EXITSTAT is unchanged.
 *
 * CMDSTAT (optional) shall be a default integer scalar.
 * It is an INTENT (OUT) argument. It is assigned the value −1 if the processor
 * does not support command line execution, a processor-dependent positive
 * value if an error condition occurs, or the value −2 if no error condition occurs
 * but WAIT is present with the value false and the processor does not support 
 * asynchronous execution. Otherwise it is assigned the value 0.
 *
 * CMDMSG (optional) shall be a default character scalar. 
 * It is an INTENT (INOUT) argument. If an error condition occurs, it is assigned
 * a processor-dependent explanatory message. Otherwise, it is unchanged.
 *===----------------------------------------------------------------------===*/

#include <stdlib.h>
#include <stdbool.h>
#include "ent3f.h"
#include "type.h"

extern char *__fstr2cstr();
extern void __cstr_free();
extern void __fort_ftnstrcpy(char *dst, /*  destination string, blank-filled */
                             int len,   /*  length of destination space */
                             char *src); /* null terminated source string */ 

static void store_int_kind(void *, __INT_T *, int);


void ENTF90(EXECUTE_COMMAND_LINE, execute_command_line)
           (DCHAR(command), __LOG_T wait,
            __INT_T *exitstat, __INT_T *cmdstat,
            DCHAR(cmdmsg),
            __INT_T *int_kind DCLEN64(command) DCLEN64(cmdmsg))
{
  int synch = 1;
  int exit_st = 0;
  int cmd_st = 0;

  char *cmd;
  int proc_id;
  char *err_msg = "Error executing command";

#if defined(TARGET_WIN)
  /* This feature not yet supported on Windows */
  if (ISPRESENT(cmdstat)) {
    cmd_st = -1;
    store_int_kind(cmdstat, int_kind, cmd_st);
  }    
  return;
#endif

  cmd = __fstr2cstr(CADR(command), CLEN(command));
 
  if (ISPRESENT(wait)) {
    if (!(I8(__fort_varying_log)(wait, int_kind)))
      synch = 0;
  }

  if (synch) {
    /* Execute command synchronously */
    exit_st = system(cmd);
  } else {
    proc_id = fork();
    if (proc_id < 0) {
      /* Error while forking process */
      cmd_st = 1;
    } else {
      if (proc_id == 0) { 
        /* Execute command only in the child process */
        exit_st = system(cmd);
        exit(0);
      }
    }
  }
 
  if (ISPRESENT(exitstat))
    store_int_kind(exitstat, int_kind, exit_st);

  if (ISPRESENT(cmdstat)) {
    store_int_kind(cmdstat, int_kind, cmd_st);

    /* TODO: Refine the emission of proper error message */
    if (ISPRESENTC(cmdmsg) && (cmd_st > 0))
      __fort_ftnstrcpy(CADR(cmdmsg), CLEN(cmdmsg), err_msg);
  }

  __cstr_free(cmd);
  return;
}

/*
 * helper function to store an int/logical value into a varying int/logical
 */
static void
store_int_kind(void *b, __INT_T *int_kind, int v)
{
  switch (*int_kind) {
  case 1:
    *(__INT1_T *)b = (__INT1_T)v;
    break;
  case 2:
    *(__INT2_T *)b = (__INT2_T)v;
    break;
  case 4:
    *(__INT4_T *)b = (__INT4_T)v;
    break;
  case 8:
    *(__INT8_T *)b = (__INT8_T)v;
    break;
  }
}
