//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench] for [divide]
  //
//------------------------------------------------------------------------------

//*** SIM_TASK_INIT ************************************************************
//--- SIM_TASK_INIT_DIVIDE_CFG
  event    sim_event_init_divide_cfg ;

  initial begin
    SIM_TASK_INIT_DIVIDE_CFG ;
  end

  task SIM_TASK_INIT_DIVIDE_CFG ;
    // main body
    begin
      // loop
      forever begin
        // wait
        @( sim_event_init_divide_cfg );

        // set
        //...
      end
    end
  endtask


//*** SIM_TASK_CHKI ************************************************************
//--- SIM_TASK_CHKI_DIVIDE_DAT
  event    sim_event_chki_divide_dat_bgn ;
  event    sim_event_chki_divide_dat_end ;

  initial begin
    SIM_TASK_CHKI_DIVIDE_DAT ;
  end

  task SIM_TASK_CHKI_DIVIDE_DAT ;
    // variables
    integer    sim_fpt_a ;
    integer    sim_fpt_b ;
    integer    sim_tmp   ;

    // main body
    begin
      // core loop
      forever begin
        // wait
        @( sim_event_chki_divide_dat_bgn );

        // open files
        sim_fpt_a = $fopen( `SIM_CSTR_FILE_CHKI_DIVIDE_DAT_A ,"r" );
        sim_fpt_b = $fopen( `SIM_CSTR_FILE_CHKI_DIVIDE_DAT_B ,"r" );

        // set
        sim_tmp = 'd1 ;
        while( sim_tmp != -'sd1 ) begin
          @(negedge clk );
          val_i   = 'd1 ;
          sim_tmp = $fscanf( sim_fpt_a ,"%x", dat_a_i );
          sim_tmp = $fscanf( sim_fpt_b ,"%x", dat_b_i );
        end

        // reset
        val_i   = 'd0 ;
        dat_a_i = 'd0 ;
        dat_b_i = 'd0 ;

        // close files
        $fclose( sim_fpt_a );
        $fclose( sim_fpt_b );

        // return
        -> sim_event_chki_divide_dat_end ;
      end
    end
  endtask


//*** SIM_TASK_CHKO ************************************************************
//--- CHKO_DAT -------------------------
  `define DUT_EVAL_HIERARCHY_DIVIDE    dut
  `include "sub-testbench/sub-testbench_dat.vh"
