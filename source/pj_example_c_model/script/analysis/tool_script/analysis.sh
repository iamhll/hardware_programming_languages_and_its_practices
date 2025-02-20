#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : get.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run serveral "ANAs"
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_PRJ=../../../
#   directory                     clear flag    c model command                                                                                                                                                    script command
CSTR_INFO_ITEM_ALL=(
   #"anaDatCstPuFulDBstInIME"     1             "./run.sh -R '--numFrame 2 --strPrefixDump ../../../script/analysis/anaDatCstPuFulDBstInIME/load/ --imeEnmDump 2' -E 2"                                            "octave anaDatCstPuFulDBstInIME.m"
   #"anaDatCstPuInterFulInFME"    1             "./run.sh -R '--numFrame 2 --strPrefixDump ../../../script/analysis/anaDatCstPuInterFulInFME/load/ --fmeEnmDump 2' -E 2"                                           "octave anaDatCstPuInterFulInFME.m"
   #"anaDatCstPuIntraFulInRMD"    1             "./run.sh -R '--numFrame 1 --strPrefixDump ../../../script/analysis/anaDatCstPuIntraFulInRMD/load/ --rmdEnmDump 2' -E 2"                                           "octave anaDatCstPuIntraFulInRMD.m"
   #"anaDatCstSadrInRMDnFME"      1             "./run.sh -R '--numFrame 2 --r_cFlg_3 1 --r_cFlg_4 1 --strPrefixDump ../../../script/analysis/anaDatCstSadrInRMDnFME/load/ --rmdEnmDump 2 --fmeEnmDump 2' -E 2"    "octave anaDatCstSadrInRMDnFME.m"
   #"anaDatFmvPuFulInFME"         1             "./run.sh -R '--numFrame 2 --strPrefixDump ../../../script/analysis/anaDatFmvPuFulInFME/load/ --fmeEnmDump 2' -E 2"                                                "octave anaDatFmvPuFulInFME.m"
   #"anaLogXkcdc"                 0             ""                                                                                                                                                                 "octave anaLogXkcdc.m"
   #"anaSizBitInRfc"              1             "./run.sh -R '--numFrame 2 --itfFlgRfc 1 --strPrefixDump ../../../script/analysis/anaSizBitInRfc/load/ --itfEnmDump 2' -E 2"                                       ""
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
    CSTR_DIR=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    FLAG_CLR=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    CSTR_CMD_CMODEL=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))
    CSTR_CMD_SCRIPT=${CSTR_INFO_ITEM_ALL[$cntItem]}; cntItem=$((cntItem + 1))

    # log
    echo "run $CSTR_DIR..."

    # note down the current time
    timeBgnCur=$(date +%s)

    # clear load
    if [ $FLAG_CLR -eq 1 ]
    then
        cd ../$CSTR_DIR ; rm -f load/* ; cd - > /dev/null ;
    fi

    # run c model
    if [ "$CSTR_CMD_CMODEL" != "" ]
    then
        cd $CSTR_DIR_PRJ/build/linux/xkcdc ; eval $CSTR_CMD_CMODEL > /dev/null ; cd - > /dev/null ;
    fi

    # clear dump
    cd ../$CSTR_DIR ; rm -f dump/* ; cd - > /dev/null ;

    # run script
    if [ "$CSTR_CMD_SCRIPT" != "" ]
    then
        cd ../$CSTR_DIR ; $CSTR_CMD_SCRIPT > /dev/null ; cd - > /dev/null ;
    fi

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
echo "[information from $0] please run anaScaler.ipynb manually"
