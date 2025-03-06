#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : checkExpressionInSquareBracket.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : check expression in squre brackets (top)
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    v
    vh
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
                #flgWrittenByMe=$(egrep "Author.*(Huang Leilei|Liu Chang|Liu Xun|Hou Bingjing)" $strItm)
                flgWrittenByMe=1
                if [ "$flgWrittenByMe" != "" ]
                then
                    ./tool_script/*/checkExpressionInSquareBracketCore.pl $strItm
                fi
            done
        fi
    done
done
