#!/usr/bin/python3
#------------------------------------------------------------------------------
    #
    #  Filename       : getPsnr.py
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : calculate PSNR
    #
#-------------------------------------------------------------------------------

#*** IMPORT ********************************************************************
import sys
import numpy as np


#*** PARAMETER *****************************************************************
#--- GLOBAL ----------------------------
CSTR_USAGE = "\n[information from {:s}] usage: ./getPsnr.py <reference yuv>, <yuv to be tested>, <verbose flag>, <frame number>, <frame width>, <frame height>\n".format(sys.argv[0])
assert len(sys.argv) == 7, "\n\n[error from {:s}] incorrect parameter number!".format(sys.argv[0]) + CSTR_USAGE
try:
    CSTR_YUV_REF = sys.argv[1]
    fptRef = open(CSTR_YUV_REF, "rb")
except:
    assert False, "\n\n[error from {:s}] failed to open reference file {:s}!".format(sys.argv[0], CSTR_YUV_REF) + CSTR_USAGE
try:
    CSTR_YUV_DUT = sys.argv[2]
    fptDut = open(CSTR_YUV_DUT, "rb")
except:
    assert False, "\n\n[error from {:s}] failed to open dut file {:s}!".format(sys.argv[0], CSTR_YUV_DUT) + CSTR_USAGE
try:
    FLAG_VERBOSE = int(sys.argv[3])
except:
    assert False, "\n\n[error from {:s}] failed to get verbose flag!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    NUMB_FRAME = int(sys.argv[4])
except:
    assert False, "\n\n[error from {:s}] failed to get frame number!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_X = int(sys.argv[5])
except:
    assert False, "\n\n[error from {:s}] failed to get frame width!\n".format(sys.argv[0]) + CSTR_USAGE
try:
    SIZE_FRAME_Y = int(sys.argv[6])
except:
    assert False, "\n\n[error from {:s}] failed to get frame height!\n".format(sys.argv[0]) + CSTR_USAGE


#--- LOCAL -----------------------------
NUMB_CHANNEL      = 3
DATA_SHIFT_CHROMA = 1


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
if FLAG_VERBOSE:
    print("frame {:>7s} {:>7s} {:>7s}".format("y", "u", "v"))


#--- CORE ------------------------------
# for each frame
datPsnrAll = np.zeros(shape=(NUMB_FRAME,NUMB_CHANNEL))
for idxFrame in range(int(NUMB_FRAME)):

    # for each channel
    datPsnr = np.zeros(shape=NUMB_CHANNEL)
    for idxC in range(NUMB_CHANNEL):
        # prepare variables
        datShift = 0 if idxC == 0 else 1
        sizFrame = (SIZE_FRAME_Y >> datShift) * (SIZE_FRAME_X >> datShift)

        # read
        datRef = np.fromfile(fptRef, dtype="uint8", count=sizFrame)
        datDut = np.fromfile(fptDut, dtype="uint8", count=sizFrame)

        # calculate datPsnr
        for idx in range(sizFrame):
            datPsnr[idxC] += (float(datDut[idx]) - float(datRef[idx])) ** 2
        datPsnr[idxC] /= sizFrame
        datPsnr[idxC] = 20 * np.log10(255 / np.sqrt(datPsnr[idxC]))
        datPsnrAll[idxFrame,:] = datPsnr

    if FLAG_VERBOSE:
        print("{:05d}    {:>7.3f} {:>7.3f} {:>7.3f}".format(idxFrame, datPsnr[0], datPsnr[1], datPsnr[2]))

# calculate datPsnrMean
datPsnrMean = np.mean(datPsnrAll, axis=0)
if FLAG_VERBOSE:
    print("")
    print("mean     {:>7.3f} {:>7.3f} {:>7.3f}".format(datPsnrMean[0], datPsnrMean[1], datPsnrMean[2]))
else:
    print("{:.3f} {:.3f} {:.3f}".format(datPsnrMean[0], datPsnrMean[1], datPsnrMean[2]))


#--- POST ------------------------------
# close files
fptRef.close()
fptDut.close()
