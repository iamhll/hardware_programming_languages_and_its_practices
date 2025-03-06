#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runXkmsc.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : perform regression run on xkmsc (core)
    #
#-------------------------------------------------------------------------------

#*** FUNCTION ******************************************************************
echoParameter() {
    echo "CSTR_DIR_VECT        :    $CSTR_DIR_VECT"
    echo "CSTR_INFO_VECT_ALL   :    ${CSTR_INFO_VECT_ALL[*]}"
    echo "FLAG_EARLY_TERMINATE :    $FLAG_EARLY_TERMINATE"
    echo "FLAG_FFMPEG          :    $FLAG_FFMPEG"
    echo "ENUM_METHOD_FFMPEG   :    $ENUM_METHOD_FFMPEG"
    echo "DATA_SCALER          :    $DATA_SCALER"
    echo "other flag           :    $*"
}


#*** PARAMETER *****************************************************************
#--- GLOBAL ----------------------------
CSTR_DIR_VECT=${CSTR_DIR_VECT:-"/mnt/e/DOWNLOAD/SEQUENCE/HM"}                  #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
#   name                 frame number    frame width    frame height    fps
#   0                    1               2              3               4
CSTR_INFO_VECT_ALL_DEFAULT=(
    "BasketballPass"     8               416            240             50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQSquare"           8               416            240             60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BlowingBubbles"     8               416            240             50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"RaceHorses"         8               416            240             30    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BasketballDrill"    8               832            480             50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQMall"             8               832            480             60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"PartyScene"         8               832            480             50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"RaceHorsesC"        8               832            480             30    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"FourPeople"         8               1280           720             60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Johnny"             8               1280           720             60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"KristenAndSara"     8               1280           720             60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Kimono"             8               1920           1080            24    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"ParkScene"          8               1920           1080            24    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Cactus"             8               1920           1080            50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BasketballDrive"    8               1920           1080            50    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQTerrace"          8               1920           1080            60    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Traffic"            8               2560           1600            30    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"PeopleOnStreet"     8               2560           1600            30    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
)
if [ "$CSTR_INFO_VECT_ALL" ]
then
    CSTR_INFO_VECT_ALL=($CSTR_INFO_VECT_ALL)
else
    CSTR_INFO_VECT_ALL=(${CSTR_INFO_VECT_ALL_DEFAULT[*]})
fi
FLAG_EARLY_TERMINATE=1                                                         #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
FLAG_FFMPEG=0                          # enable flag for ffmpeg                #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
#ENUM_METHOD_FFMPEG=fast_bilinear      # fast bilinear                         #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
ENUM_METHOD_FFMPEG=bilinear            # bilinear
#ENUM_METHOD_FFMPEG=bicubic            # bicubic
#ENUM_METHOD_FFMPEG=experimental       # experimental
#ENUM_METHOD_FFMPEG=neighbor           # nearest neighbor
#ENUM_METHOD_FFMPEG=area               # averaging area
#ENUM_METHOD_FFMPEG=bicublin           # luma bicubic, chroma bilinear
#ENUM_METHOD_FFMPEG=gauss              # Gaussian
#ENUM_METHOD_FFMPEG=sinc               # sinc
#ENUM_METHOD_FFMPEG=lanczos            # Lanczos
#ENUM_METHOD_FFMPEG=spline             # natural bicubic spline
#ENUM_METHOD_FFMPEG=print_info         # print info
#ENUM_METHOD_FFMPEG=accurate_rnd       # accurate rounding
#ENUM_METHOD_FFMPEG=full_chroma_int    # full chroma interpolation
#ENUM_METHOD_FFMPEG=full_chroma_inp    # full chroma input
#ENUM_METHOD_FFMPEG=bitexact           #
#ENUM_METHOD_FFMPEG=error_diffusion    # error diffusion dither
DATA_SCALER=${DATA_SCALER:-1.317}      # scaler data                           #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT


#--- LOCAL -----------------------------
CSTR_DUT="xkmsc"
CSTR_DIR_DUMP="dump"


#--- DERIVED ---------------------------
CSTR_LOG_RUN="$CSTR_DIR_DUMP/runs.log"
CSTR_LOG_JOB="$CSTR_DIR_DUMP/jobs.log"
CSTR_LOG_RLT="$CSTR_DIR_DUMP/results.log"


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
# prepare directory
mkdir -p $CSTR_DIR_DUMP
rm -rf $CSTR_DIR_DUMP/*

# echo parameter
echoParameter $*
echo ""

# result header
echoParameter $* >  $CSTR_LOG_RUN
echo ""          >> $CSTR_LOG_RUN
echoParameter $* >  $CSTR_LOG_RLT
echo ""          >> $CSTR_LOG_RLT
printf "%-7s\t%-7s\t%-7s\t%s\n" "PSNR Y" "PSNR U" "PSNR V" "VECTOR(frameNumberxframeWidthxframeHeight)" >> $CSTR_LOG_RLT

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
    SIZE_FRAME_SCALED_X=$(echo "scale = 0; $SIZE_FRAME_X * $DATA_SCALER / 16 * 16" | bc)
    SIZE_FRAME_SCALED_Y=$(echo "scale = 0; $SIZE_FRAME_Y * $DATA_SCALER / 16 * 16" | bc)
    # unused information
    DATA_FPS=${CSTR_INFO_VECT_ALL[$cntVect]}; cntVect=$((cntVect + 1))

    #--- LOOP DIRECTION ---
    for DIRECTION in "forward" "backward"
    do
        # derive parameters
        CSTR_DIR_SUB=${CSTR_VECT}_${DIRECTION}
        CSTR_DIR_DUMP_FUL=$CSTR_DIR_DUMP/$CSTR_DIR_SUB
        CSTR_FILE_OUT=$CSTR_DIR_DUMP_FUL/$CSTR_DUT
        if [ $DIRECTION == "forward" ]
        then
            CSTR_FILE_IN=$CSTR_DIR_VECT/$CSTR_VECT/$CSTR_VECT.yuv
            SIZE_FRAME_IN_X=$SIZE_FRAME_X
            SIZE_FRAME_IN_Y=$SIZE_FRAME_Y
            SIZE_FRAME_OUT_X=$SIZE_FRAME_SCALED_X
            SIZE_FRAME_OUT_Y=$SIZE_FRAME_SCALED_Y
        else
            CSTR_FILE_IN=$CSTR_DIR_DUMP/${CSTR_VECT}_forward/$CSTR_DUT.yuv
            SIZE_FRAME_IN_X=$SIZE_FRAME_SCALED_X
            SIZE_FRAME_IN_Y=$SIZE_FRAME_SCALED_Y
            SIZE_FRAME_OUT_X=$SIZE_FRAME_X
            SIZE_FRAME_OUT_Y=$SIZE_FRAME_Y
        fi

        # make directory
        mkdir -p $CSTR_DIR_DUMP_FUL

        # log
        echo "processing $CSTR_FILE_IN (N-W-H: ${NUMB_FRAME}-${SIZE_FRAME_IN_X}-${SIZE_FRAME_IN_Y})..."

        # note down the current time
        timeBgnCur=$(date +%s)

        # run
        if [ $FLAG_FFMPEG -eq 1 ]
        then
            ffmpeg -v 0 -y                                                                     \
               -s ${SIZE_FRAME_IN_X}x${SIZE_FRAME_IN_Y}   -pix_fmt yuv420p -i $CSTR_FILE_IN    \
               -vframes $NUMB_FRAME -sws_flags $ENUM_METHOD_FFMPEG                             \
               -s ${SIZE_FRAME_OUT_X}x${SIZE_FRAME_OUT_Y} -pix_fmt yuv420p    $CSTR_FILE_OUT.yuv
        else
            ./$CSTR_DUT                                                  \
                --strFileCfg         $CSTR_DUT.cfg                       \
                --strFileIn          $CSTR_FILE_IN                       \
                --strFileOut         $CSTR_DIR_DUMP_FUL/$CSTR_DUT.yuv    \
                --strFileLog         $CSTR_DIR_DUMP_FUL/$CSTR_DUT.log    \
                --strPrefixDump      $CSTR_DIR_DUMP_FUL/                 \
                --numFrame           $NUMB_FRAME                         \
                --sizFrameX          $SIZE_FRAME_IN_X                    \
                --sizFrameY          $SIZE_FRAME_IN_Y                    \
                --sclSizFrameX       $SIZE_FRAME_OUT_X                   \
                --sclSizFrameY       $SIZE_FRAME_OUT_Y                   \
                --osdStrFile0        $CSTR_FILE_OSD_0                    \
                --osdStrFile1        $CSTR_FILE_OSD_1                    \
                --osdStrFile2        $CSTR_FILE_OSD_2                    \
                --osdStrFile3        $CSTR_FILE_OSD_3                    \
                --osdStrFile4        $CSTR_FILE_OSD_4                    \
                --osdStrFile5        $CSTR_FILE_OSD_5                    \
                --osdStrFile6        $CSTR_FILE_OSD_6                    \
                --osdStrFile7        $CSTR_FILE_OSD_7                    \
                $*                                                       \
            > /dev/null
        fi

        timeEnd=$(date +%s)
        printf "    delta time: %d min %d s; run time: %d min %d s                   \n"    \
            $(((timeEnd-timeBgnCur) / 60                        ))                          \
            $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
            $(((timeEnd-timeBgnAll) / 60                        ))                          \
            $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))

        # check
        if [ "$DATA_SCALER" == "1" -a $DIRECTION == "backward" ]
        then
            flgErr=$(diff -q $CSTR_DIR_DUMP/${CSTR_VECT}_forward/$CSTR_DUT.yuv $CSTR_FILE_OUT.yuv)
            if [ "$flgErr" != "" ]
            then
                echo $flgErr
                flgErrAll=1
            fi
        fi

        # calculate md5sum
        md5sum $CSTR_FILE_OUT.yuv | tee -a $CSTR_LOG_RUN

        # collect result
        if [ $DIRECTION == "backward" ]
        then
            #strPsnr=$(./script/getPsnr.py                         \
            #          $CSTR_DIR_VECT/$CSTR_VECT/$CSTR_VECT.yuv    \
            #          $CSTR_FILE_OUT.yuv                          \
            #          0                                           \
            #          $NUMB_FRAME                                 \
            #          $SIZE_FRAME_X                               \
            #          $SIZE_FRAME_Y
            #)
            strPsnr=$(octave-cli --path script    \
                                 --eval "getPsnrCore(
                                            '$CSTR_DIR_VECT/$CSTR_VECT/$CSTR_VECT.yuv',
                                            '$CSTR_FILE_OUT.yuv',
                                            0,
                                            $NUMB_FRAME,
                                            $SIZE_FRAME_X,
                                            $SIZE_FRAME_Y
                                         )
                                        "
            )
            printf "%-7s\t%-7s\t%-7s\t%s\n" $strPsnr "${CSTR_VECT}(${NUMB_FRAME}x${SIZE_FRAME_X}x${SIZE_FRAME_Y})" >> $CSTR_LOG_RLT
        fi

        # early termination
        if [ $FLAG_EARLY_TERMINATE -eq 1 -a $flgErrAll -eq 1 ]
        then
            break;
        fi

        # log
        echo ""
    done
done


#--- POST ------------------------------
# echo error
if [ $flgErrAll -eq 1 ]
then
    echo ""
    echo "[error from $0] out yuv and inp yuv mismatches when scaler equals to 1!" >& 2
fi

# echo parameter
echoParameter $*
