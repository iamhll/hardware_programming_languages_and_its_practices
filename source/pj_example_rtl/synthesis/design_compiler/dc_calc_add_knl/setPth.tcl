#-------------------------------------------------------------------------------
    #
    #  Filename       : setPth.tcl
    #  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    #  Description    : path group
    #
#-------------------------------------------------------------------------------

#*** PARAMETER *****************************************************************


#*** PATH GROUP ****************************************************************
    group_path -name clk -critical 0.2 -weight 5

    group_path -name INP -critical 0.0 -weight 1 -from [all_inputs]
    group_path -name OUT -critical 0.0 -weight 1                    -to [all_outputs]
    group_path -name COM -critical 0.0 -weight 1 -from [all_inputs] -to [all_outputs]
