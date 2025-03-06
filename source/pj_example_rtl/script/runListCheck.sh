#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : runListCheck.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : a script-based check list
    #
#-------------------------------------------------------------------------------

#*** SUB FUNCTION **************************************************************
    # run
    run() {
        timeBgn=$(date +%s)
        echo "running $1..." | tee -a dump/check.log
        chmod a+x ./tool_script/???_$1/$1.sh
        ./tool_script/???_$1/$1.sh >> dump/check.log
        timeEnd=$(date +%s)
        printf "    elapsed %d s\n" $((timeEnd - timeBgn))
    }


#*** MAIN BODY *****************************************************************
    # item
    mkdir -p dump; rm -f dump/check.log
    run "checkFileHeader"
    run "checkDefineAndUndef"
    run "checkModuleDeclaration"
    run "checkExtraComma"
    run "checkParamInputOutputRegAndWireDeclaration"
    run "checkAssignment"
    run "checkBitOperation"
    run "checkExpressionInSquareBracket"
    run "checkDigitPrefix"
    run "checkUnreferencedVariable"
    run "checkLineLength"
