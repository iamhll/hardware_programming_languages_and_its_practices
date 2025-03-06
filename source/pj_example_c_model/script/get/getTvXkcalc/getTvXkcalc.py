#!/usr/bin/python3
#-------------------------------------------------------------------------------
    #
    #  Filename       : getTvXkcalc.py
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate test vectors for xkcalc (core)
    #
#-------------------------------------------------------------------------------

#*** IMPORT ********************************************************************
import sys
import random


#*** PARAMETER *****************************************************************
CSTR_USAGE = "[information from {:s}] usage: ./getTvXkcalc.py <frame number> <frame size z> <frame size y> <frame size x>".format(sys.argv[0])
try:
    NUMB_FRAME = int(sys.argv[1])
except:
    assert False, "\n\n[error from {:s}] failed to get frame number!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_X = int(sys.argv[2])
except:
    assert False, "\n\n[error from {:s}] failed to get frame size x!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_Y = int(sys.argv[3])
except:
    assert False, "\n\n[error from {:s}] failed to get frame size y!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_Z = int(sys.argv[4])
except:
    assert False, "\n\n[error from {:s}] failed to get frame size z!\n".format(sys.argv[0]) + CSTR_USAGE


#*** MAIN BODY *****************************************************************
random.seed(0)
for idxFrame in range(NUMB_FRAME):
    for idxZ in range(SIZE_FRAME_Z):
        for idxY in range(SIZE_FRAME_Y):
            for idxX in range(SIZE_FRAME_X):
                if (idxX == SIZE_FRAME_X - 1):
                    print("{:04x}\n".format(random.randint(0,0xffff)), end="")
                else:
                    print("{:04x} " .format(random.randint(0,0xffff)), end="")
