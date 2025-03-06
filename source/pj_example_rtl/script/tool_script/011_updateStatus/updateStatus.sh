#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : updateStatus.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : update status
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_TYP_ALL=(
    c
    lst
    m
    mk
    pl
    prj
    sgdc
    sh
    template
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
mkdir -p dump
echo "running checkFileHeader..." > dump/status.log
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
                egrep -q 'skip checkFileHeader' $strItm
                if [ $? -ne 0 -a "$flgWrittenByMe" != "" ]
                then
                    egrep -q '^[ #/]+Status         : ' $strItm
                    if [ $? -eq 0 ]
                    then
                        egrep '^[ #/]+Status         : ' $strItm | sed "s#.*: \(.*\)#    \1\t$strItm#" >> dump/status.log
                    else
                        printf "    no status\t$strItm\n" >> dump/status.log
                    fi
                fi
            done
        fi
    done
done
