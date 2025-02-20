#!/usr/bin/python3
#------------------------------------------------------------------------------
    #
    #  Filename       : getArgb1555FromRgb24Core.py
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate argb1555 files from rgb24 files (core)
    #
#-------------------------------------------------------------------------------

#*** IMPORT ********************************************************************
import sys
import numpy as np


#*** PARAMETER *****************************************************************
CSTR_USAGE = "[information from {:s}] usage: ./getArgb1555FromRgb24Core.py <input file> <frame number> <frame width> <frame height> <output file>\n".format(sys.argv[0])
try:
    CSTR_YUV_INP = sys.argv[1]
except:
    assert False, "\n\n[error from {:s}] failed to open input file!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    NUMB_FRAME = int(sys.argv[2])
except:
    assert False, "\n\n[error from {:s}] failed to get frame number!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_X = int(sys.argv[3])
except:
    assert False, "\n\n[error from {:s}] failed to get frame width!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_Y = int(sys.argv[4])
except:
    assert False, "\n\n[error from {:s}] failed to get frame height!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    CSTR_YUV_OUT = sys.argv[5]
except:
    assert False, "\n\n[error from {:s}] failed to get output file!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    fptInp = open(CSTR_YUV_INP, "rb")
except:
    assert False, "\n\n[error from {:s}] failed to open input file {:s}!\n".format(sys.argv[0], CSTR_YUV_INP) + CSTR_USAGE
try:
    fptOut = open(CSTR_YUV_OUT, "wb")
except:
    assert False, "\n\n[error from {:s}] failed to open output file {:s}!\n".format(sys.argv[0], CSTR_YUV_OUT) + CSTR_USAGE


#--- LOCAL -----------------------------
NUMB_CHANNEL = 3


#*** MAIN BODY *****************************************************************
#--- CORE ------------------------------
for idxFrame in range(int(NUMB_FRAME)):
    # read inp
    datInp = np.zeros(shape=(NUMB_CHANNEL,SIZE_FRAME_Y,SIZE_FRAME_X), dtype="uint16", order="C")
    for idxY in range(SIZE_FRAME_Y):
        for idxX in range(SIZE_FRAME_X):
            for idxC in range(NUMB_CHANNEL):
                datInp[idxC][idxY][idxX] = ord(fptInp.read(1))

    # write out
    datOut = np.zeros(shape=1, dtype="uint16", order="C")
    for idxY in range(SIZE_FRAME_Y):
        for idxX in range(SIZE_FRAME_X):
            datAlpha = 1 if (int(datInp[0][idxY][idxX]) + int(datInp[1][idxY][idxX]) + int(datInp[2][idxY][idxX])) / 3 > 128 else 0
            datR5bit = (datInp[0][idxY][idxX] & 0b11111000) >> 3
            datG5bit = (datInp[1][idxY][idxX] & 0b11111000) >> 3
            datB5bit = (datInp[2][idxY][idxX] & 0b11111000) >> 3
            datOut[0] = (datAlpha << 15) | (datR5bit << 10) | (datG5bit << 5) | datB5bit
            fptOut.write(datOut[0])


#--- POST ------------------------------
# close files
fptInp.close()
fptOut.close()
