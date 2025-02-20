#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : getArgb1555FromYuv420p.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : generate argb1555 files from yuv420p files
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_INP=${CSTR_DIR_INP:-"../../../data/HM"}      #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
CSTR_DIR_OUT=${CSTR_DIR_OUT:-"${CSTR_DIR_INP}_ARGB1555"}         #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
#   name                 frame number    frame size x    frame size y
CSTR_INFO_ITEM_ALL_DEFAULT=(
    "BasketballPass"     20              416             240     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQSquare"           20              416             240     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BlowingBubbles"     20              416             240     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"RaceHorses"         20              416             240     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BasketballDrill"    20              832             480     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQMall"             20              832             480     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"PartyScene"         20              832             480     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"RaceHorsesC"        20              832             480     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"FourPeople"         20              1280            720     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Johnny"             20              1280            720     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"KristenAndSara"     20              1280            720     #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Kimono"             20              1920            1080    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"ParkScene"          20              1920            1080    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Cactus"             20              1920            1080    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BasketballDrive"    20              1920            1080    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"BQTerrace"          20              1920            1080    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"Traffic"            20              2560            1600    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
   #"PeopleOnStreet"     20              2560            1600    #REVERT_THIS_ITEM_BEFORE_YOU_COMMIT
)
if [ "$CSTR_INFO_ITEM_ALL" ]
then
    CSTR_INFO_ITEM_ALL=($CSTR_INFO_ITEM_ALL)
else
    CSTR_INFO_ITEM_ALL=(${CSTR_INFO_ITEM_ALL_DEFAULT[*]})
fi


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

    # derive parameters
    CSTR_DIR_INP_FUL=$CSTR_DIR_INP/$CSTR_ITEM
    CSTR_DIR_OUT_FUL=$CSTR_DIR_OUT/$CSTR_ITEM
    CSTR_FILE_INP=$CSTR_DIR_INP_FUL/$CSTR_ITEM
    CSTR_FILE_OUT=$CSTR_DIR_OUT_FUL/$CSTR_ITEM

    # make directory
    mkdir -p $CSTR_DIR_OUT_FUL

    # log
    echo "processing $CSTR_FILE_INP (N-W-H: ${NUMB_FRAME}-${SIZE_FRAME_X}-${SIZE_FRAME_Y})..."

    # note down the current time
    timeBgnCur=$(date +%s)

    # run
    ffmpeg -v 0 -y                                                                   \
        -s ${SIZE_FRAME_X}x${SIZE_FRAME_Y} -pix_fmt yuv420p -i $CSTR_FILE_INP.yuv    \
        -vframes $NUMB_FRAME                                                         \
        -s ${SIZE_FRAME_X}x${SIZE_FRAME_Y} -pix_fmt rgb24      tmp.yuv
    ./getArgb1555FromRgb24Core.py tmp.yuv $NUMB_FRAME $SIZE_FRAME_X $SIZE_FRAME_Y $CSTR_FILE_OUT.yuv

    # log
    timeEnd=$(date +%s)
    printf "    delta time: %d min %d s; run time: %d min %d s                   \n"    \
        $(((timeEnd-timeBgnCur) / 60                        ))                          \
        $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
        $(((timeEnd-timeBgnAll) / 60                        ))                          \
        $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))
    echo ""
done


#--- POST ------------------------------
rm tmp.yuv
