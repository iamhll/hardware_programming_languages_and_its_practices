#!/bin/bash
#-------------------------------------------------------------------------------
    #
    #  Filename       : regression.sh
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : run regression
    #
#-------------------------------------------------------------------------------

#*** SUB FUNCTION **************************************************************
    # showParameter
    showParameter() {
        echo "***********************************************************************************"
        echo "*"
        echo "*   ENV_FLAG_SHOW_CFG          (show configurations or not                         ) = $ENV_FLAG_SHOW_CFG      "
        echo "*   ENV_FLAG_BACKUP            (backup regression results or not                   ) = $ENV_FLAG_BACKUP        "
        echo "*   ENV_NUMB_JOB               (number of jobs running parallelly                  ) = $ENV_NUMB_JOB           "
        echo "*   EDA_CSTR_TOOL              (EDA tool (synopsys, cadence)                       ) = $EDA_CSTR_TOOL          "
        echo "*   T_V_CSTR_DIR               (directory of test vectors                          ) = $T_V_CSTR_DIR           "
        echo "*   T_V_CSTR_PATTERN           (name/pattern of the targeted test vectors          ) = $T_V_CSTR_PATTERN       "
        echo "*   SIM_KNOB_DBG               (enable debug codes or not                          ) = $SIM_KNOB_DBG           "
        echo "*   SIM_CSTR_LEVEL_STOP        (stop all/current/no case(s) when any error reported) = $SIM_CSTR_LEVEL_STOP    "
        echo "*   SIM_DATA_SEED              (random seed                                        ) = $SIM_DATA_SEED          "
        echo "*   SIM_KNOB_WAVEFORM          (dump waveform or not                               ) = $SIM_KNOB_WAVEFORM      "
        echo "*   SIM_DATA_WAVEFORM_TIME     (time to dump shm                                   ) = $SIM_DATA_WAVEFORM_TIME "
        echo "*   SIM_CSTR_WAVEFORM_LEVEL    (dump level of shm                                  ) = $SIM_CSTR_WAVEFORM_LEVEL"
        echo "*   COV_FLAG                   (collect coverage or not                            ) = $COV_FLAG               "
        echo "*   COV_CSTR_TOP               (module to do coverage collection                   ) = $COV_CSTR_TOP           "
        echo "*"
        echo "***********************************************************************************"
    }

    # queryWaiveCondition
    queryWaiveCondition() {
        # do nothing
        flgSkp="None"
    }


#*** MAIN BODY *****************************************************************
#--- PREV ------------------------------
    # note down start time
    timeRegrBgn=$(date +%s)

    # arguement
    {
        ENV_FLAG_SHOW_CFG=$1
        ENV_FLAG_BACKUP=$2
        ENV_NUMB_JOB=$3
        EDA_CSTR_TOOL=$4
        T_V_CSTR_DIR=$5
        T_V_CSTR_PATTERN=$6
        SIM_KNOB_DBG=$7
        SIM_CSTR_LEVEL_STOP=$8
        SIM_DATA_SEED=$9
        SIM_KNOB_WAVEFORM=${10}
        SIM_DATA_WAVEFORM_TIME=${11}
        SIM_CSTR_WAVEFORM_LEVEL=${12}
        COV_FLAG=${13}
        COV_CSTR_TOP=${14}

        showParameter
    }

    # parameter
    SIM_CSTR_LOG="simul_data/run.log"
    SIM_CSTR_DIR_CHECK="check_data"
    SIM_CSTR_DIR_SIMUL="simul_data"
    SIM_CSTR_MARKER_ERROR="ERROR"
    REGR_CSTR_LOG_ERROR="error.log"
    REGR_CSTR_LOG_SKIP="skip.log"
    REGR_CSTR_DIR_SIMUL="simul_data_regr"

    # make directory
    mkdir -p $SIM_CSTR_DIR_CHECK
    mkdir -p $SIM_CSTR_DIR_SIMUL
    mkdir -p $REGR_CSTR_DIR_SIMUL
    strDirTb=$(basename `pwd`)
    for idx in $(seq 0 $((ENV_NUMB_JOB - 1)))
    do
        rm -rf  ../${strDirTb}_${idx}
        cp -r . ../${strDirTb}_${idx}
    done

    # find all test cases
    strDirTvAll=$(ls -v -d $T_V_CSTR_DIR/$T_V_CSTR_PATTERN)
    numTv=$(      ls -v -l $T_V_CSTR_DIR/$T_V_CSTR_PATTERN/dut_setting.vh | wc -l)

    # reset counter
    numRun=0
    numSkp=0
    numErr=0
    idxRun=0


#--- CORE ------------------------------
    # main loop
    for strDirTv in $strDirTvAll
    do
        # if it is a directory
        if [ -d $strDirTv ]
        then
            # note down start time
            timeTvBgn=$(date +%s)

            # log info of the current test case
            echo "discovered test case: [$strDirTv]"

            # update current number
            numRun=$((numRun + 1))

            # change directory
            cd ../${strDirTb}_${idxRun}

            # note down short_name
            strTvInShort=${strDirTv#$T_V_CSTR_DIR\/}
            strTvInShort=${strTvInShort/\//_}
            strTvInShortAll[$idxRun]=$strTvInShort

            # link dv files
            echo "  linking dv files ..."
            rm -rf ./$SIM_CSTR_DIR_CHECK/*
            strFileTvAll=$(ls -d $strDirTv/*)
            for strFileTv in $strFileTvAll
            do
                ln -f    $strFileTv $SIM_CSTR_DIR_CHECK/${strFileTv##*/}
                #ln -f -s $strFileTv $SIM_CSTR_DIR_CHECK/${strFileTv##*/}
            done

            # show configuration
            if [ $ENV_FLAG_SHOW_CFG -eq 1 ]
            then
                # do nothing here
                echo "" > /dev/null
            fi

            # queryWaiveCondition
            queryWaiveCondition

            # run
            if [ "$flgSkp" != "None" ]
            then
                # update skip number
                numSkp=$((numSkp + 1))

                # log skip info
                echo "  this case is skipped (skip reason: $flgSkp)!"
                echo "$strDirTv is skipped (skip reason: $flgSkp)!" >> ../$strDirTb/$REGR_CSTR_LOG_SKIP
            else
                # !!! a recompilation could be forced by touch dut_setting.vh,
                # !!! but one has to have the authority to do so.
                # !!! as a result, i directly use "make clean" here.
                #touch $SIM_CSTR_DIR_CHECK/dut_setting.vh
                make clean > /dev/null

                # run simulation
                echo "  running simulation... (enter q after press ctrl+c to exit)"
                if [ $COV_FLAG -eq 1 ]
                then
                    make cov                                                \
                        EDA_CSTR_TOOL=$EDA_CSTR_TOOL                        \
                        SIM_KNOB_DBG=$SIM_KNOB_DBG                          \
                        SIM_CSTR_LEVEL_STOP=$SIM_CSTR_LEVEL_STOP            \
                        SIM_DATA_SEED=$SIM_DATA_SEED                        \
                        SIM_KNOB_WAVEFORM=$SIM_KNOB_WAVEFORM                \
                        SIM_DATA_WAVEFORM_TIME=$SIM_DATA_WAVEFORM_TIME      \
                        SIM_CSTR_WAVEFORM_LEVEL=$SIM_CSTR_WAVEFORM_LEVEL    \
                        COV_CSTR_TOP=$COV_CSTR_TOP                          \
                    > /dev/null &
                else
                    make sim                                                \
                        EDA_CSTR_TOOL=$EDA_CSTR_TOOL                        \
                        SIM_KNOB_DBG=$SIM_KNOB_DBG                          \
                        SIM_CSTR_LEVEL_STOP=$SIM_CSTR_LEVEL_STOP            \
                        SIM_DATA_SEED=$SIM_DATA_SEED                        \
                        SIM_KNOB_WAVEFORM=$SIM_KNOB_WAVEFORM                \
                        SIM_DATA_WAVEFORM_TIME=$SIM_DATA_WAVEFORM_TIME      \
                        SIM_CSTR_WAVEFORM_LEVEL=$SIM_CSTR_WAVEFORM_LEVEL    \
                    > /dev/null &
                fi
            fi

            # block when parallel number reaches ENV_NUMB_JOB-1 or current number reaches total case number
            if [ $idxRun -eq $((ENV_NUMB_JOB - 1)) ] || [ $numRun -eq $numTv ]
            then
                # update run time
                while [ $(jobs | wc -l) -ne 0 ]
                do
                    timeEnd=$(date +%s)
                    printf "  delta time: %d min %d s; run time: %d min %d s (R/S/E/A=%d/%d/%d/%d)    \r"    \
                        $(((timeEnd-timeTvBgn  ) / 60                         ))                             \
                        $(((timeEnd-timeTvBgn  ) - (timeEnd-timeTvBgn  )/60*60))                             \
                        $(((timeEnd-timeRegrBgn) / 60                         ))                             \
                        $(((timeEnd-timeRegrBgn) - (timeEnd-timeRegrBgn)/60*60))                             \
                        $numRun                                                                              \
                        $numSkp                                                                              \
                        $numErr                                                                              \
                        $numTv
                    jobs > /dev/null    # I don't know why, but this line must be added
                    sleep 1
                done
                printf "                                                                            \r"

                # check result
                for idx in $(seq 0 $idxRun)
                do
                    # change direcory
                    cd ../${strDirTb}_${idx}
                    strTvInShort=${strTvInShortAll[$idx]}

                    # early terminate (fatal)
                    if [ $(cat $SIM_CSTR_LOG | grep '*E' | wc -l) -gt 0 ]
                    then
                        cat $SIM_CSTR_LOG | grep '*E'
                        exit
                    fi

                    # update error number
                    if [ $(cat $SIM_CSTR_LOG | grep $SIM_CSTR_MARKER_ERROR | wc -l) -gt 0 ]
                    then
                        numErr=$((numErr + 1))
                    fi

                    # log error info if exists
                    cat $SIM_CSTR_LOG                           \
                        | sed -n "/$SIM_CSTR_MARKER_ERROR/p"    \
                        | sed -n "s/^/$strTvInShort -> /p"      \
                        | tee -a ../$strDirTb/$REGR_CSTR_LOG_ERROR

                    # save simulation results
                    if [ $ENV_FLAG_BACKUP -eq 1 ]
                    then
                        echo "  saving simulation results..."
                        mv $SIM_CSTR_DIR_SIMUL ../$strDirTb/$REGR_CSTR_DIR_SIMUL/$DIR_SIMUL_${strTvInShort}
                        cp $SIM_CSTR_TOP.v     ../$strDirTb/$REGR_CSTR_DIR_SIMUL/$DIR_SIMUL_${strTvInShort}
                        mkdir -p $SIM_CSTR_DIR_SIMUL
                    fi
                done

                # note down run time
                timeEnd=$(date +%s)
                printf "  delta time: %d min %d s; run time: %d min %d s (R/S/E/A=%d/%d/%d/%d)    \n"    \
                    $(((timeEnd-timeTvBgn  ) / 60                         ))                             \
                    $(((timeEnd-timeTvBgn  ) - (timeEnd-timeTvBgn  )/60*60))                             \
                    $(((timeEnd-timeRegrBgn) / 60                         ))                             \
                    $(((timeEnd-timeRegrBgn) - (timeEnd-timeRegrBgn)/60*60))                             \
                    $numRun                                                                              \
                    $numSkp                                                                              \
                    $numErr                                                                              \
                    $numTv
                echo

                # early terminate (error)
                if [ $SIM_CSTR_LEVEL_STOP == "all" ]
                then
                    if [ $numErr -gt 0 ]
                        then
                        break
                    fi
                fi
            fi

            # update parallel counter
            if [ "$flgSkp" == "None" ]
            then
                idxRun=$(((idxRun + 1) % ENV_NUMB_JOB))
            fi
        fi
    done


#--- POST ------------------------------
    # display info
    {
        timeEnd=$(date +%s)

        showParameter

        echo "*"
        echo "*   REGRESSION FINISHED AT $(date)"
        if [ $numErr -gt 0 ]
        then
            echo "*                                                                                  "
            echo "*                                                         *********                "
            echo "*                                                      **           **             "
            echo "*         *                   *                      *               **            "
            echo "*          *                 *                     *                   *           "
            echo "*           *               *                     *                  ** *          "
            echo "*            *             *                     *         ***      *  * *         "
            echo "*             *           *                      *        *   *     *  * *         "
            echo "*              *         *                       *        *   *     *  *  *        "
            echo "*               *       *                        *        *   *      **   *        "
            echo "*                *     *                         *         ***            * ***    "
            echo "*                 *   *                           *                       *    *   "
            echo "*                  * *                            *     ***      *****     *   *   "
            echo "*                   *                             *    *   *    *    *     * **    "
            echo "*                  * *                            *   *    *     ****      **      "
            echo "*                 *   *                          *         *               *       "
            echo "*                *     *                        **       **                *       "
            echo "*               *       *                     **        *                  *       "
            echo "*              *         *                   *                             *       "
            echo "*             *           *                   *                            *       "
            echo "*            *             *                **                             *       "
            echo "*           *               *              *                               *       "
            echo "*          *                 *             *   **                          *       "
            echo "*         *                   *             ***  *                ***  **          "
            echo "*                                                *   * **    *    H L L            "
            echo "*                                                ***    ****   ***                 "
            echo "*                                                                                  "
        else
            echo "*                                                                                                            "
            echo "*                                                        ..***.....    .*.***..*.                            "
            echo "*                                                     .**.        *   *.          ..                         "
            echo "*                                   *               .*.           * .*              ..                       "
            echo "*                                  *               *.      *.     ***                 ..                     "
            echo "*                                 *                *       *  ..  **                   .*                    "
            echo "*                                *                 .*      *  ** .*           .*.......***.                  "
            echo "*                               *                    *     .. .  *.        .*.   .....    .                  "
            echo "*                              *              .*....***.   .* .          .**.**...   ..*.                    "
            echo "*                             *            .*.        ..*   * ..       .**..            .*                   "
            echo "*                            *            **             .  .* .  .                       *.                 "
            echo "*                           *            *.                  ...  .*    .       ..**.....  ..                "
            echo "*                          *           *                    *...***..    ..   .*.        **.*.               "
            echo "*                         *           *           .......        .....     .**          .*  **               "
            echo "*                        *           *        .**....**.           ...       ..        .*    *.              "
            echo "*       *               *            *      .*.    .*.              .         *       **..***.               "
            echo "*        *             *             *    ..      .*        .                 *      ***.                    "
            echo "*         *           *              *  .*.     ..         *                  *                              "
            echo "*          *         *               ..*.      ..        ... *                ..                             "
            echo "*           *       *                 .       ..      ..       **.            *          ..***HLL****.       "
            echo "*            *     *                         .*    .*.         ..**         *.      ..****..         .*.     "
            echo "*             *   *                          *   .*.           * *. *.      *    .*****.                     "
            echo "*              * *                           .  .*.            . .    ..   *   *..**.                        "
            echo "*               *                            *.*               ...      .***.*..*.                           "
            echo "*                                            *.               . *       **. *.                               "
            echo "*                                                            . *      *. .*                                  "
            echo "*                                                                                                            "
        fi
        echo "*     run time:        $(((timeEnd-timeRegrBgn) / 60)) min $(((timeEnd-timeRegrBgn) - (timeEnd-timeRegrBgn)/60*60)) s"
        echo "*     run/skp/err/all: $numRun / >>> $numSkp <<< / >>> $numErr <<< / $numTv"
        echo "*"
        echo "***********************************************************************************"
    }

    # remove run directories
    if [ $ENV_NUMB_JOB -ne 1 ]
    then
        for idx in $(seq 0 $((ENV_NUMB_JOB - 1)))
        do
            rm -rf ../${strDirTb}_${idx}
        done
    fi
