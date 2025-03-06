#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : getTvXkcalc.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate test vectors for xkcalc
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_OUT="../../../data/XKCALC"                                   #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
#   name         frame number    frame size x    frame size y    frame size z
CSTR_INFO_ITEM_ALL=(
    "test_00"    3               16              32              8    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_01"    4               87              63              1    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_02"    7               48              13              4    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_03"    2               9               87              2    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_04"    1               51              45              6    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_05"    8               7               8               3    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_06"    10              27              35              7    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_07"    5               51              65              8    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_08"    9               48              36              7    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
    "test_09"    4               13              3               5    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
)


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
# prepare directory
mkdir -p $CSTR_DIR_OUT
rm -rf $CSTR_DIR_OUT/*

# note down the current time
timeBgnAll=$(date +%s)


#--- CORE ------------------------------
numItem=${#CSTR_INFO_ITEM_ALL[*]}
cntItem=0
while [ $cntItem -lt $numItem ]
do
    # extract parameters
    CSTR_ITEM=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    NUMB_FRAME=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    SIZE_FRAME_X=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    SIZE_FRAME_Y=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    SIZE_FRAME_Z=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))

    # derive parameters
    CSTR_DIR_OUT_FUL=$CSTR_DIR_OUT/$CSTR_ITEM
    CSTR_FILE_OUT=$CSTR_DIR_OUT_FUL/$CSTR_ITEM

    # make directory
    mkdir -p $CSTR_DIR_OUT_FUL

    # log
    echo "generating $CSTR_ITEM (N-X-Y-Z: ${NUMB_FRAME}-${SIZE_FRAME_X}-${SIZE_FRAME_Y}-${SIZE_FRAME_Z})..."

    # note down the current time
    timeBgnCur=$(date +%s)

    # run
    ./getTvXkcalc.py $NUMB_FRAME $SIZE_FRAME_X $SIZE_FRAME_Y $SIZE_FRAME_Z > $CSTR_FILE_OUT.dat

    # log
    timeEnd=$(date +%s)
    printf "    delta time: %d min %d s; run time: %d min %d s                   \n"    \
        $(((timeEnd-timeBgnCur) / 60                        ))                          \
        $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
        $(((timeEnd-timeBgnAll) / 60                        ))                          \
        $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))
    echo ""
done
