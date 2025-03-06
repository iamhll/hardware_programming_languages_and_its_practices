#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runListUpdate.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : a script-based update list
    #
#-------------------------------------------------------------------------------

#*** TOOL **********************************************************************
# run
    run() {
        CSTR_SCRIPT=$1
        CSTR_MODE=$2
        CSTR_PARAM=$3
        CSTR_SCRIPT_IN_SHORT=${CSTR_SCRIPT##*/}
        CSTR_SCRIPT_IN_SHORT=${CSTR_SCRIPT_IN_SHORT%%.*}
        if [ "$CSTR_MODE" == "skip" ]
        then
            echo "    SKIPPING $CSTR_SCRIPT_IN_SHORT..."
        else
            echo "    running $CSTR_SCRIPT_IN_SHORT..."
            chmod a+x $CSTR_SCRIPT
            if [ "$CSTR_MODE" == "quiet" ]
            then
                ./$CSTR_SCRIPT $CSTR_PARAM > /dev/null
            else
                ./$CSTR_SCRIPT $CSTR_PARAM
            fi
        fi
    }


#*** MAIN BODY *****************************************************************
# update auto-generated codes
    echo "updating codes..."
    cd ../include/script
        run "define2undef.sh" "r"
    cd - > /dev/null

# reformat
    echo "reformating..."
    cd .
        run "tool_script/???_dos2unix/dos2unix.sh"                       "r"
        run "tool_script/???_deleteTrailingBlank/deleteTrailingBlank.sh" "r"
    cd - > /dev/null

# grep markers
    mkdir -p dump
    echo "grepping markers..."
    echo "    grep TODO..."; grep "[/#%].*TODO" ../check ../include ../library ../reference_model ../script/tool_script ../simulation ../source ../synthesis -rn > dump/todo.log
    echo "    grep NOTE..."; grep "[/#%].*NOTE" ../check ../include ../library ../reference_model ../script/tool_script ../simulation ../source ../synthesis -rn > dump/note.log
    echo "    grep ??? ..."; grep "[/#%]\s*???" ../check ../include ../library ../reference_model ../script/tool_script ../simulation ../source ../synthesis -rn > dump/question.log
    echo "    grep !!! ..."; grep "[/#%].*!!!"  ../check ../include ../library ../reference_model ../script/tool_script ../simulation ../source ../synthesis -rn > dump/emphasis.log

# grep status
    echo "grepping status..."
    cd .
        run "tool_script/???_updateStatus/updateStatus.sh"    "r"
    cd - > /dev/null

# remove empty directories
    cd ../
        echo "removing empty directories..."
        dirEmpty=$(find . -type d -empty)
        while [ "$dirEmpty" != "" ]
        do
            for dirCur in $dirEmpty
            do
                echo "  $dirCur"
            done
            echo "  ---"
            rm -rf $dirEmpty
            dirEmpty=$(find . -type d -empty)
        done
    cd - > /dev/null
