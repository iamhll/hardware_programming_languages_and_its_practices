#-------------------------------------------------------------------------------
    #
    #  Filename       : setCst.tcl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : (timing) constraints
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************
    set DATA_PRD_CLK    WOULD_BE_OVERWRITTEN


#*** CLK ***********************************************************************
    create_clock -name clk     -period $DATA_PRD_CLK [get_ports clk]
    create_clock -name clk_vir -period $DATA_PRD_CLK


#*** PORT DELAY ****************************************************************
    set_input_delay  -clock [get_clocks clk_vir] -max [expr $DATA_PRD_CLK * 0.3] -add_delay [get_ports {*_i}]
    set_input_delay  -clock [get_clocks clk_vir] -min [expr $DATA_PRD_CLK * 0.0] -add_delay [get_ports {*_i}]
    set_output_delay -clock [get_clocks clk_vir] -max [expr $DATA_PRD_CLK * 0.3] -add_delay [get_ports {*_o}]
    set_output_delay -clock [get_clocks clk_vir] -min [expr $DATA_PRD_CLK * 0.0] -add_delay [get_ports {*_o}]


#*** FALSE PATH ****************************************************************


#*** OTHER SETTINGS ************************************************************
