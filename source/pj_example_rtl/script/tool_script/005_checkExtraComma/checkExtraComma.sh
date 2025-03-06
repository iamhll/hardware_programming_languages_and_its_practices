#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkExtraComma.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check extra comma (top)
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    v
)
CSTR_DIR_ALL=(
    library
    simulation
    source
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
                ./tool_script/*/checkExtraCommaCore.pl $strItm
            done
        fi
    done
done
