#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : doxygen.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run doxygen
    #
#-------------------------------------------------------------------------------

#*** MAIN BODY *****************************************************************
#--- CORE ------------------------------
echo "[information from $0] please wait for a while..."
doxygen doxygen.cfg > /dev/null
cd latex; make > /dev/null; cd - > /dev/null


#--- POST ------------------------------
echo "[information from $0] if \"error: Problems running dot: exit code=-1, command='dot'\" is reported, please install \"dot\" with:"
echo "[information from $0]    \"sudo apt-get install graphviz\""
