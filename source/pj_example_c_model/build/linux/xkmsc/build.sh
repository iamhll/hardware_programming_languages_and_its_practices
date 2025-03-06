#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : build.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : create a linux building environment for xkmsc
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_PRJ=../../../
CSTR_USAGE="[information from $0] usage: ./build.sh [<building parameters>]"


#*** MAIN BODY *****************************************************************
cmake $CSTR_DIR_PRJ/source/xkmsc/top $*
exit 0
