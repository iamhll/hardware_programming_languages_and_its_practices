#!/usr/bin/perl
#-------------------------------------------------------------------------------
    #
    #  Filename       : lst2qxf.pl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : convert file lists to quartus setting files
    #
#-------------------------------------------------------------------------------

#*** OPTION ********************************************************************
    #use 5.010;
    use strict;
    use POSIX;


#*** VARIABLES *****************************************************************
    my $CSTR_SRC = $ARGV[0];
    my $CSTR_DST = $ARGV[1];
    my %strInc;
    my %strRtl;


#*** SUB FUNCTION **************************************************************
#--- GET INCLUDE -----------------------
    sub getStrInc {
        # log
        my $fptOut = $_[0];
        my $strInp = $_[1];
        #print "processing $strInp\n";

        # main loop
        open my $fptInp, "< $strInp";
        while (<$fptInp>) {
            chomp;
            s#\$ENV_CSTR_DIR_PRJ#$ENV{ENV_CSTR_DIR_PRJ}#;
            # include
            if (/\+incdir\+\s*(.*)/) {
                if (!exists($strInc{$1})) {
                    print $fptOut "set_global_assignment -name SEARCH_PATH \"$1\"\n";
                    $strInc{$1} = 1;
                }
            }
            # -f
            elsif (/^\s*-f\s*(.*)$/) {
                getStrInc($fptOut, $1);
            }
        }
        close $fptInp;
    }


#--- GET RTL ---------------------------
    sub getStrRtl {
        # log
        my $fptOut = $_[0];
        my $strInp = $_[1];
        #print "processing $strInp\n";

        # main loop
        open my $fptInp, "< $strInp";
        while (<$fptInp>) {
            chomp;
            s#\$ENV_CSTR_DIR_PRJ#$ENV{ENV_CSTR_DIR_PRJ}#;
            # comments
            if (/^\s*\/\//) {
            }
            # -f
            elsif (/^\s*-f\s*(.*)$/) {
                getStrRtl($fptOut, $1);
            }
            # include
            elsif (/incdir/) {
            }
            # blank line
            elsif (/^\s*$/) {
            }
            # memory model
            elsif (/gf_22/) {
            }
            elsif (/gf_28/) {
            }
            elsif (/hl_40/) {
            }
            # design file
            else {
                if (!exists($strRtl{$_})) {
                    print $fptOut "set_global_assignment -name VERILOG_FILE \"$_\"\n";
                    $strRtl{$_} = 1;
                }
            }
        }
        close $fptInp;
    }


#*** MAIN BODY *****************************************************************
#--- QPF -------------------------------
    # open
    open my $fptOut, "> $CSTR_DST.qpf";

    # common
    print $fptOut "QUARTUS_VERSION = \"18.0\"\n";
    print $fptOut "DATE = \"00:00:00  JAN 01, 2020\"\n";
    print $fptOut "PROJECT_REVISION = \"$CSTR_DST\"\n";

    # close
    close $fptOut;


#--- QSF -------------------------------
    # open
    open my $fptOut, "> $CSTR_DST.qsf";

    # common
    print $fptOut "set_global_assignment -name FAMILY \"Arria 10\"\n";
    print $fptOut "set_global_assignment -name DEVICE 10AX115U4F45I3VG\n";
    print $fptOut "set_global_assignment -name TOP_LEVEL_ENTITY $CSTR_DST\n";
    print $fptOut "set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.0.0\n";
    print $fptOut "set_global_assignment -name PROJECT_CREATION_TIME_DATE \"00:00:00  JAN 01, 2020\"\n";
    print $fptOut "set_global_assignment -name LAST_QUARTUS_VERSION \"18.0.0 Standard Edition\"\n";
    print $fptOut "set_global_assignment -name MIN_CORE_JUNCTION_TEMP \"-40\"\n";
    print $fptOut "set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100\n";
    print $fptOut "set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 2\n";
    print $fptOut "set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files\n";
    print $fptOut "set_global_assignment -name NUM_PARALLEL_PROCESSORS 4\n";
    print $fptOut "set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top\n";
    print $fptOut "set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT -section_id Top\n";
    print $fptOut "set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top\n";
    print $fptOut "set_global_assignment -name POWER_PRESET_COOLING_SOLUTION \"23 MM HEAT SINK WITH 200 LFPM AIRFLOW\"\n";
    print $fptOut "set_global_assignment -name POWER_BOARD_THERMAL_MODEL \"NONE (CONSERVATIVE)\"\n";
    print $fptOut "set_global_assignment -name EDA_SIMULATION_TOOL \"Custom Verilog HDL\"\n";
    print $fptOut "set_global_assignment -name EDA_TIME_SCALE \"1 ps\" -section_id eda_simulation\n";
    print $fptOut "set_global_assignment -name EDA_OUTPUT_DATA_FORMAT \"VERILOG HDL\" -section_id eda_simulation\n";
    print $fptOut "\n";
    #print $fptOut "set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top\n";
    #print $fptOut "\n";

    # include
    getStrInc($fptOut, $CSTR_SRC);
    print $fptOut "\n";

    # design
    getStrRtl($fptOut, $CSTR_SRC);
    print $fptOut "\n";

    # sdc
    print $fptOut "set_global_assignment -name SDC_FILE setCst.tcl\n";

    # close
    close $fptOut;
