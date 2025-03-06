#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkFileHeader.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check file header (top)
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    c
    m
    mk
    pl
    prj
    sgdc
    sh
    tcl
    v
    vh
)
CSTR_DIR_ALL=(
    check
    document
    include
    library
    reference_model
    script
    simulation
    source
    synthesis
)


#*** MAIN BODY *****************************************************************
for strDir in ${CSTR_DIR_ALL[*]}
do
    for strTyp in ${CSTR_TYP_ALL[*]}
    do
        if [ -d "../$strDir" ]
        then
            for strItm in $(find "../$strDir" -name "*.$strTyp")
            do
                ./tool_script/*/checkFileHeaderCore.pl $strItm
            done
        fi
    done
done
