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
    set CSTR_TOP        example
    set CSTR_DIR_CHK    .
    set CSTR_DIR_RPT    $CSTR_DIR_CHK/rpt
    set NUMB_CORE       8

    # "./" cannot be omitted
    source ./srcInc.tcl
    source ./srcRtl.tcl


#*** VERIFY SETTINGS ***********************************************************
    # warning/error knob
    set_mismatch_message_filter -warn                   FMR_ELAB-147
    set_mismatch_message_filter -warn                   FMR_ELAB-034

    # legacy settings
    set hdlin_unresolved_modules                        "black_box"
    set verification_clock_gate_hold_mode               any
    set verification_blackbox_match_mode                identity
    set verification_constant_prop_mode                 top
    set verification_failing_point_limit                100

    # recommended by fm
    set synopsys_auto_setup                             true
    set hdlin_ignore_parallel_case                      false
    set hdlin_ignore_full_case                          false
   # As suggested by Formality,
   # (Use of 'hdlin_error_on_mismatch_message' is deprecated,
   #  using 'set_mismatch_message_filter -warn' instead.
   # ), the following set is commented
   #set set hdlin_error_on_mismatch_message             false
    set hdlin_ignore_embedded_configuration             true
    set verification_set_undriven_signals               synthesis
    set verification_verify_directly_undriven_output    false

    # time out
    set verification_timeout_limit                      6:0:0


#*** PATH SETTING **************************************************************
#--- BEGIN OF GF_28 --------------------
    # !!! \ here must be added, otherwise formality cannot recongnize its contents.
    set search_path           "$CSTR_INC                                                        \
                                                  /home/huangleilei/PUBLIC/LIB/GF28SLP/CELL    \
                                                      /home/llhuang/PUBLIC/LIB/GF28SLP/CELL    \
                               /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/CELL    \
                              "
    set target_library        "/net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/CELL/sc9mc_cmos28slp_base_hvt_c30_ss_nominal_max_0p90v_m40c.db
                               /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/CELL/sc9mc_cmos28slp_base_lvt_c30_ss_nominal_max_0p90v_m40c.db
                               /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/CELL/sc9mc_cmos28slp_base_rvt_c30_ss_nominal_max_0p90v_m40c.db
                              "
    set ram_library           ""
   #set ram_library           "[ sh ls /net/dellr940d/export/ybfan2/llhuang/PUBLIC/LIB/GF28SLP/RAM/*/*_0p90v_m40c.db ]
   #                          "
    set link_library          "$target_library
                               $ram_library
                              "
    read_db -technology_lib    $link_library
#--- END OF GF_28 ----------------------


#*** SOURCE ********************************************************************
    # read reference
    # !!! the svf file under syn/dc_${CSTR_TOP}/session_2.000 is adopted.
    set_svf ../../../../synthesis/design_compiler/dc_${CSTR_TOP}/session_2.000/rlt/$CSTR_TOP.svf
    read_verilog -r $CSTR_RTL
    set_top r:/WORK/$CSTR_TOP
    current_design $CSTR_TOP

    # read implementation
    # !!! the netlist file under syn/dc_${CSTR_TOP}/session_2.000 is adopted.
    read_verilog -i ../../../../synthesis/design_compiler/dc_${CSTR_TOP}/session_2.000/rlt/$CSTR_TOP.v
    set_top i:/WORK/$CSTR_TOP
    current_design $CSTR_TOP

    # check
    report_setup_status > $CSTR_DIR_RPT/${CSTR_TOP}_report_setup_status.rpt


#*** RUN ***********************************************************************
    set_host_options -max_core $NUMB_CORE

   #match > $CSTR_DIR_RPT/${CSTR_TOP}_match.rpt
    match

   #verify > $CSTR_DIR_RPT/${CSTR_TOP}_verify.rpt
    verify

   # quit
   #exit
