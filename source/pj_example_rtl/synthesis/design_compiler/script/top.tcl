#-------------------------------------------------------------------------------
    #
    #  Filename       : top.tcl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : top
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
    set CSTR_TOP               example
    set CSTR_DIR_SYN           .
    set CSTR_DIR_RPT           $CSTR_DIR_SYN/rpt
    set CSTR_DIR_RLT           $CSTR_DIR_SYN/rlt
    set FLAG_STRUCTURE         true
    set FLAG_FLATTEN           false
    set NUMB_CORE              8
    set NUMB_PATH_RPT          100
    set DATA_AREA_MAX          0
    set DATA_RANGE_CRITICAL    0.2

    # "./" cannot be omitted
    source ./setInc.tcl
    source ./setRtl.tcl


#*** PATH SETTING **************************************************************
#--- BEGIN OF TSMC_65 ------------------
   #set search_path       "$CSTR_INC
   #                       /eda/lib/tsmc65/std/tcbn65gplus_200a/AN61001_20100919/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65gplus_200a
   #                       /eda/lib/tsmc65/std/tcbn65gpluslvt_200a/AN61001_20100921/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65gpluslvt_200a
   #                       /eda/lib/tsmc65/io/tpfn65gpgv2od3_200c/AN61001_20101122/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpfn65gpgv2od3_200c
   #                      "
   #set target_library    "tcbn65gplustc_ccs.db
   #                       tcbn65gpluslvttc_ccs.db
   #                      "
   #set pad_library       "tpfn65gpgv2od3tc.db
   #                      "
   #set ram_library       ""
   #set rom_library       ""
#--- END OF TSMC_65 --------------------

#--- BEGIN OF GF_28 --------------------
    set search_path       "$CSTR_INC
                                              /home/huangleilei/PUBLIC/LIB/GF28SLP/CELL
                                                  /home/llhuang/PUBLIC/LIB/GF28SLP/CELL
                           /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/CELL
                          "
    set target_library    "sc9mc_cmos28slp_base_hvt_c30_ss_nominal_max_0p90v_m40c.db    \
                           sc9mc_cmos28slp_base_lvt_c30_ss_nominal_max_0p90v_m40c.db    \
                           sc9mc_cmos28slp_base_rvt_c30_ss_nominal_max_0p90v_m40c.db    \
                          "
    set pad_library       ""
    set ram_library       ""
   #set ram_library       "[ sh ls                    /home/huangleilei/PUBLIC/LIB/GF28SLP/RAM/*/*_0p90v_m40c.db ]"
   #set ram_library       "[ sh ls                        /home/llhuang/PUBLIC/LIB/GF28SLP/RAM/*/*_0p90v_m40c.db ]"
   #set ram_library       "[ sh ls /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/RAM/*/*_0p90v_m40c.db ]"
    set rom_library       ""
#--- END OF GF_28 ----------------------

    set link_library    "*
                         standard.sldb
                         dw_foundation.sldb
                         $target_library
                         $pad_library
                         $ram_library
                         $rom_library
                        "


#*** SOURCE ********************************************************************
    # read
    set_svf $CSTR_DIR_RLT/$CSTR_TOP.svf
    set_app_var hdlin_enable_hier_map true
    define_design_lib work -path work
    analyze -format verilog -lib work $CSTR_RTL
    elaborate $CSTR_TOP -arch "verilog" -lib work
    current_design $CSTR_TOP
    set_verification_top

    # check
    uniquify
    link         > $CSTR_DIR_RPT/${CSTR_TOP}_link.rpt
    check_design > $CSTR_DIR_RPT/${CSTR_TOP}_check_design.rpt


#*** CONSTRAINT ****************************************************************
    # read ("-e" show the content; "-v" show the result)
    source -e -v ./setCst.tcl
    source -e -v ./setPth.tcl

    # check
    check_timing > $CSTR_DIR_RPT/${CSTR_TOP}_check_timing.rpt


#*** COMPILE SETTING ***********************************************************
    # area
    set_max_area $DATA_AREA_MAX

    # structure and flatten
    set_structure $FLAG_STRUCTURE
    set_flatten   $FLAG_FLATTEN

    # no feedthrough
    set verilogout_no_tri true
    set_fix_multiple_port_nets -all -buffer_constants

    # us dw arithmetic, which is out of date
    #set dw_prefer_mc_inside true

    # critical range
    set_critical_range $DATA_RANGE_CRITICAL [get_designs *]


#*** COMPILE *******************************************************************
    # use multi-core
    set_host_options -max_core $NUMB_CORE

    # compile
    compile_ultra -scan -gate_clock -no_autoungroup -no_boundary_optimization -no_seq_output_inversion


#*** REPORT ********************************************************************
    # define name rules and change the names
    define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$"   -replacement_char "_" -type cell
    define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$"   -replacement_char "_" -type net
    define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$[]" -replacement_char "_" -type port
    change_names -rules "IS_rule" -hierarchy

    # dump result
   #write -hierarchy                 -output $CSTR_DIR_RLT/$CSTR_TOP.db
   #write -format ddc -hierarchy     -output $CSTR_DIR_RLT/$CSTR_TOP.ddc
    write -hierarchy -format verilog -output $CSTR_DIR_RLT/$CSTR_TOP.v
   #write_sdc                                $CSTR_DIR_RLT/$CSTR_TOP.sdc
    write_sdf                                $CSTR_DIR_RLT/$CSTR_TOP.sdf

    # dump reports
    report_constraints -all_violators -verbose > $CSTR_DIR_RPT/${CSTR_TOP}_report_constraints_all_violators.rpt
    report_timing -max $NUMB_PATH_RPT          > $CSTR_DIR_RPT/${CSTR_TOP}_report_timing.rpt
    report_area -hierarchy                     > $CSTR_DIR_RPT/${CSTR_TOP}_report_area_hierarchy.rpt
    report_power                               > $CSTR_DIR_RPT/${CSTR_TOP}_report_power.rpt
    report_clock_gating -ungated               > $CSTR_DIR_RPT/${CSTR_TOP}_report_clock_gating_ungated.rpt

    # quit
    # thus DC will no longer occupy the SVF file
    set_svf off
    #exit
