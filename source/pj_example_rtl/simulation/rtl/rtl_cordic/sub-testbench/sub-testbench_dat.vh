//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench_dat.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench dat] for [example]
  //
//------------------------------------------------------------------------------

//--- SIM_TASK_CHKO_CORDIC_DAT
`ifdef SIM_KNOB_CHK_CORDIC_DAT
  initial begin
    SIM_TASK_CHKO_CORDIC_DAT ;
  end

  task SIM_TASK_CHKO_CORDIC_DAT ;
    // variables
    integer                   sim_fpt ;
    integer                   sim_tmp ;
    reg     [DATA_WD-1 :0]    sim_dat ;

    reg                       dut_val ;
    reg     [DATA_WD-1 :0]    dut_dat ;

    // main body
    begin
      if( `SIM_KNOB_CHK && `SIM_KNOB_CHK_CORDIC_DAT ) begin
        // log info
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t function check to cordic's dat is on!" );

        // open files
        sim_fpt = $fopen( `SIM_CSTR_FILE_CHKO_CORDIC_DAT_RESULT ,"r" );

        // core loop
        forever begin
          // wait
          @(posedge clk );

          // dut_val
          dut_val = val_i ;

          // if valid
          if( dut_val ) begin
            // dut_*
            dut_dat = `DUT_EVAL_HIERARCHY_CORDIC.dat_result_o ;

            // sim_*
            sim_tmp = $fscanf( sim_fpt ,"%x" ,sim_dat );

            // check
            if( dut_dat !== sim_dat ) begin
              $display("\n\t CORDIC ERROR: at %08d ns, dat_o should be %x, however is %x!\n"
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
