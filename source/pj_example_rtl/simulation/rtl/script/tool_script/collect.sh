#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : collect.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : collect simulation results
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_ALL=(
    calc_add_knl
)
CSTR_DIR_DUMP=dump


#*** MAIN BODY *****************************************************************
rm -rf ./$CSTR_DIR_DUMP
mkdir    $CSTR_DIR_DUMP
for strDir in ${CSTR_DIR_ALL[*]}
do
    # generate
    cd ../../rtl_$strDir
    make clean_all
    make com_view EDA_CSTR_TOOL="cds"
    make com_view EDA_CSTR_TOOL="syn"
    make chk_view EDA_CSTR_TOOL="syn"
    make sim      EDA_CSTR_TOOL="cds"
    make sim      EDA_CSTR_TOOL="syn"
    cd -
    # collect
    mkdir -p                                          $CSTR_DIR_DUMP/rtl_$strDir/simul_data
    cp ../../rtl_$strDir/simul_data/com_ncverilog.log $CSTR_DIR_DUMP/rtl_$strDir/simul_data
    cp ../../rtl_$strDir/simul_data/com_vlogan.log    $CSTR_DIR_DUMP/rtl_$strDir/simul_data
    cp ../../rtl_$strDir/simul_data/chk_verdi.log     $CSTR_DIR_DUMP/rtl_$strDir/simul_data
    cp ../../rtl_$strDir/simul_data/sim_ncverilog.log $CSTR_DIR_DUMP/rtl_$strDir/simul_data
    cp ../../rtl_$strDir/simul_data/sim_vcs.log       $CSTR_DIR_DUMP/rtl_$strDir/simul_data
done
