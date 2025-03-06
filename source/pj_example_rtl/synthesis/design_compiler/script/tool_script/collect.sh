#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : collect.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : collect synthesis results
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
sed -i 's/#exit/exit/' ../top.tcl
for strDir in ${CSTR_DIR_ALL[*]}
do
    # generate
    cd ../../dc_$strDir
    make syn DATA_PRD_CLK=2.000
    make syn DATA_PRD_CLK=10.000
    make syn_view
    cd -
    # collect
    mkdir -p                                                                        $CSTR_DIR_DUMP/dc_$strDir/session_2.000/log
    cp ../../dc_$strDir/session_2.000/log/syn.log                                   $CSTR_DIR_DUMP/dc_$strDir/session_2.000/log
    mkdir -p                                                                        $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_check_design.rpt                $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_check_timing.rpt                $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_link.rpt                        $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_report_area_hierarchy.rpt       $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_report_clock_gating_ungated.rpt $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_report_power.rpt                $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    cp ../../dc_$strDir/session_2.000/rpt/${strDir}_report_timing.rpt               $CSTR_DIR_DUMP/dc_$strDir/session_2.000/rpt
    mkdir -p                                                                        $CSTR_DIR_DUMP/dc_$strDir/session_10.000/rpt
    cp ../../dc_$strDir/session_10.000/rpt/${strDir}_report_area_hierarchy.rpt      $CSTR_DIR_DUMP/dc_$strDir/session_10.000/rpt
done
sed -i 's/exit/#exit/' ../top.tcl
