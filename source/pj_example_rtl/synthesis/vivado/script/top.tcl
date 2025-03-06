#-------------------------------------------------------------------------------
    #
    #  Filename       : top.tcl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : top
    #
#-------------------------------------------------------------------------------

#*** MAIN BODY *****************************************************************
#--- CREATE PROJECT --------------------
    create_project $SYN_TOP . -part $SYN_TAR


#--- SPECIFY SOURCEs -------------------
    # design
    set_property verilog_define { DUT_TOP=$SYN_TOP
                                  DUT_TOP_STR="$SYN_TOP"
                                  SIM_TOP=$SIM_TOP
                                  SIM_TOP_STR="$SIM_TOP"
                                  STP_LVL="$STP_LVL"
                                  SEED=$SEED
    } [get_filesets sources_1]

    set_property include_dirs { $ENV_CSTR_DIR_PRJ/include
    } [get_filesets sources_1]

    add_files -fileset sources_1 -scan_for_includes { $ENV_CSTR_DIR_PRJ/lib/behave
                                                      $ENV_CSTR_DIR_PRJ/src
    }

    # simulation
    set_property verilog_define { DUT_TOP=$SYN_TOP
                                  DUT_TOP_STR="$SYN_TOP"
                                  SIM_TOP=$SIM_TOP
                                  SIM_TOP_STR="$SIM_TOP"
                                  STP_LVL="$STP_LVL"
                                  SEED=$SEED
    } [get_filesets sim_1]

    set_property include_dirs { $ENV_CSTR_DIR_PRJ/include
                                $ENV_CSTR_DIR_PRJ/sim/rtl_$SYN_TOP
    } [get_filesets sim_1]

    add_files -fileset sim_1 -scan_for_includes { $ENV_CSTR_DIR_PRJ/lib/behave_sim
                                                  $ENV_CSTR_DIR_PRJ/sim/rtl_$SYN_TOP
    }

    # synthesis
    add_files -fileset constrs_1 ./cst.tcl


#--- SPECIFY PROPERTY ------------------
    # design
    set_property top $SYN_TOP [get_filesets sources_1]

    # simulation
    set_property top $SIM_TOP [get_filesets sim_1]

    # synthesis
    #set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
