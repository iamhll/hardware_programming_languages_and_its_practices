#-------------------------------------------------------------------------------
    #
    #  Filename       : cst.tcl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : (timing) constraints
    #
#-------------------------------------------------------------------------------

#*** CLK ***********************************************************************
    create_clock -name clk         -period 6.666 [get_ports {clk    }]
    create_clock -name clk_vir     -period 6.666
    create_clock -name clk_e_d     -period 6.666 [get_ports {clk_e_d}]
    create_clock -name clk_e_d_vir -period 6.666


#*** PORT DELAY ****************************************************************
    set_input_delay  -clock [get_clocks clk_vir] -max 2.000 -add_delay [get_ports {*_i}]
    set_input_delay  -clock [get_clocks clk_vir] -min 0.000 -add_delay [get_ports {*_i}]
    set_output_delay -clock [get_clocks clk_vir] -max 2.000 -add_delay [get_ports {*_o}]
    set_output_delay -clock [get_clocks clk_vir] -min 0.000 -add_delay [get_ports {*_o}]


#*** FALSE PATH ****************************************************************
    set_clock_groups -asynchronous -group {clk     clk_vir}        \
                                   -group {clk_e_d clk_e_d_vir}
