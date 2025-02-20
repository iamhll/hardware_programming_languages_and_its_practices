#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : get.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run serveral "GETs"
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_INFO_ITEM_ALL=(
    "getArgb1555FromYuv420p"
    "getAyuv1555FromYuv420p"
    "getIndx2FromYuv420p"
    "getIndx4FromYuv420p"
)


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
# note down the current time
timeBgnAll=$(date +%s)


#--- CORE ------------------------------
cntItem=0
numItem=${#CSTR_INFO_ITEM_ALL[*]}
while [ $cntItem -lt $numItem ]
do
    # extract parameters
    CSTR_ITEM=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))

    # log
    echo "run $CSTR_ITEM..."

    # note down the current time
    timeBgnCur=$(date +%s)

    # run
    cd ../$CSTR_ITEM ; ./$CSTR_ITEM.sh > /dev/null ; cd - > /dev/null

    # log
    timeEnd=$(date +%s)
    printf "    delta time: %d min %d s; run time: %d min %d s                   \n"    \
        $(((timeEnd-timeBgnCur) / 60                        ))                          \
        $(((timeEnd-timeBgnCur) - (timeEnd-timeBgnCur)/60*60))                          \
        $(((timeEnd-timeBgnAll) / 60                        ))                          \
        $(((timeEnd-timeBgnAll) - (timeEnd-timeBgnAll)/60*60))
    echo ""
done
