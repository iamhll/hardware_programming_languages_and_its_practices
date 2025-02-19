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
sed -i 's/#exit/exit/' ../top.tcl
for strDir in ${CSTR_DIR_ALL[*]}
do
    # generate
    cd ../../fm_$strDir
    make chk
    cd -
    # collect
    mkdir -p                                $CSTR_DIR_DUMP/fm_$strDir/session/log
    cp ../../fm_$strDir/session/log/chk.log $CSTR_DIR_DUMP/fm_$strDir/session/log
done
sed -i 's/exit/#exit/' ../top.tcl
