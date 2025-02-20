#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : run.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2022-11-18
    #  Description    : perform single run on xkmsc
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
CSTR_DIR_PRJ=../../..
CSTR_USAGE="[information from $0] usage: ./run.sh [-B <building parameters>] [-R <running parameters>]"


#*** MAIN BODY *****************************************************************
# clean
rm -f xkmsc
rm -f out.yuv

# get building parameters B and running parameters R
while getopts ":B:R:" opt
do
    case $opt in
    B)
        B=$OPTARG
    ;;
    R)
        R=$OPTARG
    ;;
    ?)
        echo "[error from $0] wrong parameter [$*]!" >& 2;
        echo $CSTR_USAGE >& 2
        exit 1
    ;;
    esac
done

# build
./build.sh $B
if [ $? -ne 0 ]
then
    echo "[error from $0] build failed!" >& 2;
    exit 1;
fi

# compile
make -j8
if [ $? -ne 0 ]
then
    echo "[error from $0] compile failed!" >& 2;
    exit 1;
fi

# run
./xkmsc -c $CSTR_DIR_PRJ/script/run/runXkmsc/xkmsc.cfg $R | tee run.log
if [ $? -ne 0 ]
then
    echo "[error from $0] run failed!" >& 2;
    exit 1;
fi

# calculate md5sum
md5sum out.yuv | tee -a run.log

# return
exit 0;
