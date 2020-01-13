#
# Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
#
# Support for DNORM intrinsic
#
# Date of Modification: 21st February 2019
#

BASE_DIR=$(HOMEQA)
SRC=$(BASE_DIR)/src
FC=flang
CC=clang
CXX=clang++
OBJX=o
EXESUFFIX=out
LD=$(FC)
OPT=-O
F2008=-std=f2008
FFLAGS=-I$(SRC) $(OPT) $(KIEE) $(EXTRA_FFLAGS) $(EXTRA_HFLAGS) $(F2008)
LDFLAGS=$(EXTRA_LDFLAGS)
LIBS=$(EXTRA_LIBS)
CFLAGS=$(EXTRA_CFLAGS)
TEST=
COMP_CHECK=python $(HOMEQA)/../tools/check_compilation.py

RM=rm -f
CP=cp -f
UNAME := $(shell uname -a)

INCLUDES=$(BASE_DIR)/inc

check: check.$(OBJX)

check.$(OBJX) : $(SRC)/check.c
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)

clean.run: clean.$(OBJX)
	a.out

clean:
	-$(RM) a.out *.$(OBJX) *.mod *.qdbg core

run.run: run.$(OBJX)
	a.out

include $(INCLUDES)/$(TEST).mk
