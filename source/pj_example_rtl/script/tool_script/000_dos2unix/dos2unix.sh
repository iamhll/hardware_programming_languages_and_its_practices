#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : dos2unix.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : do dos2unix
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
            find "../$strDir" -name "*.$strTyp"    \
                | xargs dos2unix                   \
            >& /dev/null
        fi
    done
done
