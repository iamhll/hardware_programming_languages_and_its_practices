#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runListPack.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : a script-based pack list
    #
#-------------------------------------------------------------------------------


#*** MAIN BODY *****************************************************************
    cd ../
        TAR=database.tar
       #printf "update $TAR..."; rm -rf ./$TAR ; time tar -czf $TAR check document include library reference_model script simulation "source" synthesis
       #printf "update $TAR..."; rm -rf ./$TAR ; time tar -czf $TAR reference_model
       #printf "update $TAR..."; rm -rf ./$TAR ; time tar -czf $TAR check include library script simulation/rtl/rtl_calc_add_knl simulation/rtl/script "source" synthesis
        printf "update $TAR..."; rm -rf ./$TAR ; time tar -czf $TAR check                                       \
                                                                    include                                     \
                                                                    library                                     \
                                                                    script                                      \
                                                                    simulation/*/*/sub-testbench                \
                                                                    simulation/*/*/check_data/dut_setting.vh    \
                                                                    simulation/*/*/makefile                     \
                                                                    simulation/*/*/*.f                          \
                                                                    simulation/*/*/*.v                          \
                                                                    simulation/*/script                         \
                                                                   "source"                                     \
                                                                    synthesis
    cd - > /dev/null
    echo ""
