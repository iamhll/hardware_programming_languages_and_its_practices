#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : lib2db.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : convert lib files to db files
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
    # usage
    CSTR_USAGE="[information from lib2db.sh] usage: ./lib2db.sh (dc|lc) <lib directory> [<corner>]"

    # sanity check
    if [ $# -ne 2 -a $# -ne 3 ]
    then
        echo "[error from lib2db.sh] wrong parameter number $#"
        echo $CSTR_USAGE
        exit 1
    fi
    if [ $1 != "dc" -a $1 != "lc" ]
    then
        echo "[error from lib2db.sh] wrong convertion tool $1, should be dc (Design Compiler) or lc (Library Compiler)"
        echo $CSTR_USAGE
        exit 1
    fi

    # location of libs
    CSTR_TOOL=$1
    CSTR_DIR=$2
    if [ $# -eq 3 ]
    then
        CSTR_CONNER=$3
    else
        CSTR_CONNER=ss_0p90v_0p90v_m40c
    fi

    # name of temperary tcl
    CSTR_TCL=lib2db.tcl.$$


#*** MAIN BODY *****************************************************************
    # generate script
    rm -f $CSTR_TCL
    if [ $CSTR_TOOL == "dc" ]
    then
        echo "enable_write_lib_mode" > $CSTR_TCL
    fi
    for datItm in $(ls $CSTR_DIR)
    do
        if [ -d $CSTR_DIR/$datItm ]
        then
            if [ -f $CSTR_DIR/$datItm/${datItm}_${CSTR_CONNER}.lib ]
            then
                echo "read_lib $CSTR_DIR/$datItm/${datItm}_${CSTR_CONNER}.lib" >> $CSTR_TCL
                echo "write_lib -format db ${datItm}_${CSTR_CONNER} -output $CSTR_DIR/$datItm/${datItm}_${CSTR_CONNER}.db" >> $CSTR_TCL
            else
                echo "$datItm/${datItm}_${CSTR_CONNER}.lib does not exist!"
            fi
        else
            echo "$datItm is not a directory!"
        fi
    done

    # convert
    if [ $CSTR_TOOL == "dc" ]
    then
        dc_shell-xg-t -f $CSTR_TCL | tee -i lib2db.log
    else
        lc_shell      -f $CSTR_TCL | tee -i lib2db.log
    fi

    # remove the temperary tcl
    rm $CSTR_TCL
