#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runXkcalc.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : perform regression run on xkcalc (core)
    #
#-------------------------------------------------------------------------------

#*** FUNCTION ******************************************************************
echoParameter() {
    echo "CSTR_DIR_VECT        :    $CSTR_DIR_VECT"
    echo "CSTR_INFO_VECT_ALL   :    ${CSTR_INFO_VECT_ALL[*]}"
    echo "FLAG_EARLY_TERMINATE :    $FLAG_EARLY_TERMINATE"
}


#*** PARAMETER *****************************************************************
#--- GLOBAL ----------------------------
CSTR_DIR_VECT="../../../pj_example_c_model/data/XKCALC"               #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
#   name         frame number    frame size x    frame size y    frame size z
CSTR_INFO_VECT_ALL=(
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
FLAG_EARLY_TERMINATE=1                                                #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT


#--- LOCAL -----------------------------
CSTR_DUT="xkcalc"
CSTR_DIR_DUMP="dump"


#--- DERIVED ---------------------------
CSTR_LOG_RUN="$CSTR_DIR_DUMP/runs.log"
CSTR_LOG_JOB="$CSTR_DIR_DUMP/jobs.log"


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
# prepare directory
mkdir -p $CSTR_DIR_DUMP
rm -rf $CSTR_DIR_DUMP/*

# echo parameter
echoParameter $*
echo ""

# note down the current time
timeBgnAll=$(date +%s)


#--- CORE ------------------------------
#--- LOOP VECTOR ---
flgErrAll=0
numVect=${#CSTR_INFO_VECT_ALL[*]}
cntVect=0
while [ $cntVect -lt $numVect ]
do
    # extract parameters
    CSTR_VECT=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))
    NUMB_FRAME=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))
    SIZE_FRAME_X=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))
    SIZE_FRAME_Y=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))
    SIZE_FRAME_Z=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))

    # derive parameters
    CSTR_FILE_INP=$CSTR_DIR_VECT/$CSTR_VECT/$CSTR_VECT

    # log
    echo "processing $CSTR_VECT (N-X-Y-Z: ${NUMB_FRAME}-${SIZE_FRAME_X}-${SIZE_FRAME_Y}-${SIZE_FRAME_Z})..."

    # note down the current time
    timeBgnCur=$(date +%s)

    #--- LOOP SATURATION ---
    for flgSaturation in 0 1
    do
        # derive parameters
        CSTR_DIR_SUB=${CSTR_VECT}_flgSaturation${flgSaturation}
        CSTR_DIR_DUMP_FUL=$CSTR_DIR_DUMP/$CSTR_DIR_SUB
        CSTR_FILE_OUT=$CSTR_DIR_DUMP_FUL/$CSTR_DUT

        # make directory
        mkdir -p $CSTR_DIR_DUMP_FUL

        # log
        echo "    flgSaturation $flgSaturation launched ..."

        # run
        ./$CSTR_DUT                                      \
            --strFileCfg          $CSTR_DUT.cfg          \
            --strFileInp          $CSTR_FILE_INP.dat     \
            --strFileOut          $CSTR_FILE_OUT.dat     \
            --strPrefixDump       $CSTR_DIR_DUMP_FUL/    \
            --addFlgSaturation    $flgSaturation         \
            --subFlgSaturation    $flgSaturation         \
            --mulFlgSaturation    $flgSaturation         \
            --divFlgSaturation    $flgSaturation         \
            --numFrame            $NUMB_FRAME            \
            --sizFrameX           $SIZE_FRAME_X          \
            --sizFrameY           $SIZE_FRAME_Y          \
            --sizFrameZ           $SIZE_FRAME_Z          \
            --sizUnitZ            $SIZE_FRAME_Z          \
                                                         \
            --enmLoad             0                      \
            --sizUnitY            2                      \
            --sizUnitX            2                      \
                                                         \
            $*                                           \
        > $CSTR_FILE_OUT.log &
    done

    # wait
    numJob=1
    while [ $numJob -ne 0 ]
    do
        sleep 1
        timeEnd=$(date +%s)
        printf "    delta time: %d min %d s; run time: %d min %d s (jobs: %d)        \r"    \
            $(((timeEnd-timeBgnCur) / 60                        ))                          \
            $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
            $(((timeEnd-timeBgnAll) / 60                        ))                          \
            $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))                          \
            $(jobs | wc -l)
        jobs > $CSTR_LOG_JOB
        numJob=$(cat $CSTR_LOG_JOB | wc -l)
        grep 127 $CSTR_LOG_JOB
    done
    rm $CSTR_LOG_JOB
    timeEnd=$(date +%s)
    printf "    delta time: %d min %d s; run time: %d min %d s                   \n"    \
        $(((timeEnd-timeBgnCur) / 60                        ))                          \
        $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
        $(((timeEnd-timeBgnAll) / 60                        ))                          \
        $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))

    #--- LOOP SATURATION ---
    for flgSaturation in 0 1
    do
        # derive parameters
        CSTR_DIR_SUB=${CSTR_VECT}_flgSaturation${flgSaturation}
        CSTR_DIR_DUMP_FUL=$CSTR_DIR_DUMP/$CSTR_DIR_SUB
        CSTR_FILE_OUT=$CSTR_DIR_DUMP_FUL/$CSTR_DUT

        # check
        # get flgErr and set flgErrAll
        # for example
        # flgErr=$(diff -q XXX XXX)
        # if [ "$flgErr" != "" ]
        # then
        #     echo $flgErr
        #     flgErrAll=1
        # fi

        # calculate md5sum
        md5sum $CSTR_FILE_OUT.dat | tee -a $CSTR_LOG_RUN

        # collect result
        #...
    done

    # early termination
    if [ $FLAG_EARLY_TERMINATE -eq 1 -a $flgErrAll -eq 1 ]
    then
        break;
    fi

    # log
    echo ""
done


#--- POST ------------------------------
# echo error
if [ $flgErrAll -eq 1 ]
then
    echo ""
    echo "[error from $0] error exists!" >& 2
fi

# echo parameter
echoParameter $*
