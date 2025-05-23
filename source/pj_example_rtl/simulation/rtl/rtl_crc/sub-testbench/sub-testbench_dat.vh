//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench_dat.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench dat] for [crc]
  //
//------------------------------------------------------------------------------

//--- SIM_TASK_CHKO_CRC_DAT
`ifdef SIM_KNOB_CHK_CRC_DAT
  initial begin
    SIM_TASK_CHKO_CRC_DAT ;
  end

  task SIM_TASK_CHKO_CRC_DAT ;
    // variables
    integer                       sim_fpt ;
    integer                       sim_tmp ;
    reg     [DATA_OUT_WD-1 :0]    sim_dat ;

    reg                           dut_val ;
    reg     [DATA_OUT_WD-1 :0]    dut_dat ;

    // main body
    begin
      if( `SIM_KNOB_CHK && `SIM_KNOB_CHK_CRC_DAT ) begin
        // log info
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t function check to crc's dat is on!" );

        // open files
        sim_fpt = $fopen( `SIM_CSTR_FILE_CHKO_CRC_DAT ,"r" );

        // core loop
        forever begin
          // wait
          @(negedge clk );

          // dut_val
          dut_val = `DUT_EVAL_HIERARCHY_CRC.val_o ;

          // if valid
          if( dut_val ) begin
            // dut_*
            dut_dat = `DUT_EVAL_HIERARCHY_CRC.dat_o ;

            // sim_*
            sim_tmp = $fscanf( sim_fpt ,"%x" ,sim_dat );

            // check
            if( dut_dat !== sim_dat ) begin
              $display("\n\t CRC ERROR: at %08d ns, dat_o should be %x, however is %x!\n"
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
