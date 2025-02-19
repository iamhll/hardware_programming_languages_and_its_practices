#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runListUpdate.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : update list
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
# CSTR_DIR_PRJ
    CSTR_DIR_PRJ=../../..

# strDirAll
    strDirAll=(
        "build"
        "document"
        "script"
        "source"
    )

# strTypAll
    strTypAll=(
        "bat"
        "c"
        "cpp"
        "csv"
        "h"
        "hpp"
        "m"
        "mk"
        "pl"
        "py"
        "rst"
        "sh"
        "tcl"
        "txt"
    )

# strWaiveAll
    strWaiveAll=(
        "$CSTR_DIR_PRJ/.vscode"
        "$CSTR_DIR_PRJ/build/linux/*/cmake*"
        "$CSTR_DIR_PRJ/build/linux/*/CMake*"
        "$CSTR_DIR_PRJ/build/linux/*/Makefile"
        "$CSTR_DIR_PRJ/build/windows/*/.vs"
        "$CSTR_DIR_PRJ/build/windows/*/CMake*"
        "$CSTR_DIR_PRJ/build/windows/*/Win32"
        "$CSTR_DIR_PRJ/build/windows/*/*.cmake"
        "$CSTR_DIR_PRJ/build/windows/*/*.dir"
        "$CSTR_DIR_PRJ/build/windows/*/*.sln"
        "$CSTR_DIR_PRJ/build/windows/*/*.vcxproj*"
        "$CSTR_DIR_PRJ/build/windows/*/*/*.ilk"
        "$CSTR_DIR_PRJ/build/windows/*/*/*.pdb"
        "$CSTR_DIR_PRJ/document/*/*/build/"
        "$CSTR_DIR_PRJ/document/doxygen/*/html/"
        "$CSTR_DIR_PRJ/document/doxygen/*/latex/"
        "$CSTR_DIR_PRJ/document/doxygen/*/*/*/html"
        "$CSTR_DIR_PRJ/document/doxygen/*/*/*/latex"
        "$CSTR_DIR_PRJ/script/run/*/session*/"
        "$CSTR_DIR_PRJ/script/run/runChipsMedia/chipsMedia/"
        "$CSTR_DIR_PRJ/script/run/runHM/HM/"
        "$CSTR_DIR_PRJ/script/run/runVeriSilicon/veriSilicon/"
        "$CSTR_DIR_PRJ/script/run/runX265/x265/"
        "$CSTR_DIR_PRJ/script/run/runListUpdate/runListUpdate.sh"
        "$CSTR_DIR_PRJ/source/xkcdc/unit/entropy_encoding/HM/"
        "$CSTR_DIR_PRJ/source/xkcdc/unit/entropy_decoding/HM/"
        "$CSTR_DIR_PRJ/script/analysis/anaScalerFromXiongmai"
    )


#*** TOOL **********************************************************************
# getList
    getList() {
        rm -f dump/strItmFull.log
        rm -f dump/strItmSelected.log
        numItm=1
        for strDir in ${strDirAll[*]}
        do
            if [ -d "$CSTR_DIR_PRJ/$strDir" ]
            then
                for strTyp in ${strTypAll[*]}
                do
                    for strItm in $(find "$CSTR_DIR_PRJ/$strDir" -name "*.$strTyp")
                    do
                        echo $strItm >> dump/strItmFull.log
                    done
                done
            fi
        done
        cp dump/strItmFull.log dump/strItmSelected.log
        for strWaive in ${strWaiveAll[*]}
        do
            cat dump/strItmSelected.log | egrep -v $strWaive > dump/strItmSelected.log.bak
            mv dump/strItmSelected.log.bak dump/strItmSelected.log
        done
        OLDIFS=$IFS
        IFS=$'\n'
        strItmAll=($(cat dump/strItmSelected.log))
        IFS=$OLDIFS
    }

# reformat
    reformat() {
        for strItm in ${strItmAll[*]}
        do
            dos2unix $strItm >& /dev/null
            sed -i 's/\s\+$//' $strItm >& /dev/null
        done
    }

# grepMarker
    grepMarker() {
        rm -f $strLog
        for strItm in ${strItmAll[*]}
        do
            grep $strMarker -Hn $strItm >> $strLog
        done
    }

# grepStatus
    grepStatus() {
        rm -f $strLog
        for strItm in ${strItmAll[*]}
        do
            egrep -q 'skip checkStatus' $strItm
            if [ $? -ne 0 ]
            then
                egrep -q '^[ #/%.:]+Status         : ' $strItm
                if [ $? -eq 0 ]
                then
                    egrep '^[ #/%.:]+Status         : ' $strItm    \
                        | sed "s#.*: \(.*\)#\1\t$strItm#"          \
                    >> $strLog
                else
                    printf "no status\t$strItm\n" >> $strLog
                fi
            fi
        done
    }


#*** MAIN BODY *****************************************************************
# prepare list
    echo "prepare list ..."
    getList

# update auto-generated codes
    echo "updating cfg package..."
    cd $CSTR_DIR_PRJ/source/xkmsc/top/configuration
        ./msc_cfg.pl > /dev/null
    cd - > /dev/null

# reformat
    echo "reformating..."
    reformat

# grep markers
    echo "grepping markers..."
    echo "    TODO..."; strMarker="[/#%].*TODO"; strLog="dump/todo.log"    ; grepMarker
    echo "    NOTE..."; strMarker="[/#%].*NOTE"; strLog="dump/note.log"    ; grepMarker
    echo "    ??? ..."; strMarker="[/#%].*???" ; strLog="dump/question.log"; grepMarker
    echo "    !!! ..."; strMarker="[/#%].*!!!" ; strLog="dump/emphasis.log"; grepMarker

# grep status
    echo "grepping status..."; strLog="dump/status.log"; grepStatus

# remove empty directories
    echo "removing empty directories..."
    cd $CSTR_DIR_PRJ
    strDirEmpty=$(find . -type d -empty)
    while [ "$strDirEmpty" != "" ]
    do
       echo "$strDirEmpty"
       rmdir $strDirEmpty
       strDirEmpty=$(find . -type d -empty)
    done
    cd - > /dev/null
