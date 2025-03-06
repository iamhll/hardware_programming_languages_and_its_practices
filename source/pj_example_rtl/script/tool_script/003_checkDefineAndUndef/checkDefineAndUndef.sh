#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkDefineAndUndef.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check define and undefine
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    v
)
CSTR_DIR_ALL=(
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
                # define
                CSTR_GREP=$(egrep '`include "define.*\.vh"' $strItm)
                NUMB_GREP=$(egrep '`include "define.*\.vh"' $strItm | wc -l)
                if [ $NUMB_GREP -ne 1 ]
                then
                    printf "    please check the include of \"define\" in $strItm\n"
                    continue;
                else
                    CSTR_LEVEL_DEFINE=${CSTR_GREP#*define}
                    if [ $CSTR_LEVEL_DEFINE == '.vh"' ]
                    then
                        continue;
                    fi
                fi
                # undef
                CSTR_GREP=$(egrep '`include "undef.*\.vh"' $strItm)
                NUMB_GREP=$(egrep '`include "undef.*\.vh"' $strItm | wc -l)
                if [ $NUMB_GREP -ne 1 ]
                then
                    printf "    please check the include of \"undef\" in $strItm\n"
                    continue;
                else
                    CSTR_LEVEL_UNDEF=${CSTR_GREP#*undef}
                fi
                # define and undef
                if [ "$CSTR_LEVEL_UNDEF" != "$CSTR_LEVEL_DEFINE" ]
                then
                    printf "    please check the include of \"define\" and \"undef\" in $strItm\n"
                fi
            done
        fi
    done
done
