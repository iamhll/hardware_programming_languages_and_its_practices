#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : deleteTrailingBlank.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : delete blank end
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    c
    f
    lst
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
                egrep -q '\s+$' $strItm
                if [ $? -eq 0 ]
                then
                    echo "    processing $strItm"
                    sed -i "s/\s\+$//" $strItm
                fi
            done
        fi
    done
done
