//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench_dat.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench dat] for [calc_add_knl]
  //
//------------------------------------------------------------------------------

//--- SIM_TASK_CHKO_CALC_ADD_KNL_DAT
`ifdef SIM_KNOB_CHK_CALC_ADD_KNL_DAT
  initial begin
    SIM_TASK_CHKO_CALC_ADD_KNL_DAT ;
  end

  task SIM_TASK_CHKO_CALC_ADD_KNL_DAT ;
    // variables
    integer                   sim_fpt ;
    integer                   sim_tmp ;
    reg     [DATA_WD-1 :0]    sim_dat ;

    reg                       dut_val ;
    reg     [DATA_WD-1 :0]    dut_dat ;

    // main body
    begin
      if( `SIM_KNOB_CHK && `SIM_KNOB_CHK_CALC_ADD_KNL_DAT ) begin
        // log info
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t function check to calc_add_knl's dat is on!" );

        // open files
        sim_fpt = $fopen( `SIM_CSTR_FILE_CHKO_CALC_ADD_KNL_DAT ,"r" );

        // core loop
        forever begin
          // wait
          @(negedge clk );

          // dut_val
          dut_val = `DUT_EVAL_HIERARCHY_CALC_ADD_KNL.val_o ;

          // if valid
          if( dut_val ) begin
            // dut_*
            dut_dat = `DUT_EVAL_HIERARCHY_CALC_ADD_KNL.dat_o ;

            // sim_*
            sim_tmp = $fscanf( sim_fpt ,"%x" ,sim_dat );

            // check
            if( dut_dat !== sim_dat ) begin
              $display("\n\t CALC_ADD_KNL ERROR: at %08d ns, dat_o should be %x, however is %x!\n"
                ,$time
                ,sim_dat
                ,dut_dat
              );
              if( `SIM_CSTR_LEVEL_STOP != "none" ) begin
                #( 1000 * `SIM_DATA_PRD_CLK );
                $finish ;
              end
            end
          end
        end
      end
    end
  endtask
`endif
