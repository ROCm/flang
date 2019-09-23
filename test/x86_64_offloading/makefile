#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# x86_64 offloading regression test-suite
#

BASE_DIR=$(HOMEQA)
SRC=$(BASE_DIR)/src
SRC2=$(BASE_DIR)/src/src  # For regression_cpu
FC=flang
CC=clang
CXX=clang++
OBJX=o
EXESUFFIX=out
LD=$(FC)
OPT=-O
OMP_FLAGS=-fopenmp -fopenmp-targets=x86_64-pc-linux-gnu
FFLAGS=-I$(SRC) $(OPT) $(KIEE) $(EXTRA_FFLAGS) $(EXTRA_HFLAGS) $(OMP_FLAGS)
LDFLAGS=$(EXTRA_LDFLAGS) -fuse-ld=ld
LIBS=$(EXTRA_LIBS)
CFLAGS=$(EXTRA_CFLAGS) $(OMP_FLAGS)
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
