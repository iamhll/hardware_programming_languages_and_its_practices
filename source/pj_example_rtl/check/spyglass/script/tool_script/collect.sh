#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : collect.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : collect flow results
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_ALL=(
    calc_add_knl
)
CSTR_DIR_DUMP=temp


#*** MAIN BODY *****************************************************************
rm -rf ./$CSTR_DIR_DUMP
mkdir    $CSTR_DIR_DUMP
for strDir in ${CSTR_DIR_ALL[*]}
do
    # collect
    mkdir -p                                    $CSTR_DIR_DUMP/sg_$strDir/session/rpt
    cp ../../sg_$strDir/session/rpt/*.rpt       $CSTR_DIR_DUMP/sg_$strDir/session/rpt
    cp ../../sg_$strDir/session/rpt/analyze.log $CSTR_DIR_DUMP/sg_$strDir/session/rpt
done
