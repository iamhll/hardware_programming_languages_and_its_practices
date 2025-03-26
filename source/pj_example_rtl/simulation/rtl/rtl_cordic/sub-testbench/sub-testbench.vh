//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench] for [cordic]
  //
//------------------------------------------------------------------------------

//*** SIM_TASK_INIT ************************************************************
//--- SIM_TASK_INIT_CORDIC_CFG
  event    sim_event_init_cordic_cfg ;

  initial begin
    SIM_TASK_INIT_CORDIC_CFG ;
  end

  task SIM_TASK_INIT_CORDIC_CFG ;
    // main body
    begin
      // loop
      forever begin
        // wait
        @( sim_event_init_cordic_cfg );

        // set
        //...
      end
    end
  endtask


//*** SIM_TASK_CHKI ************************************************************
//--- SIM_TASK_CHKI_CORDIC_DAT
  event    sim_event_chki_cordic_dat_bgn ;
  event    sim_event_chki_cordic_dat_end ;

  initial begin
    SIM_TASK_CHKI_CORDIC_DAT ;
  end

  task SIM_TASK_CHKI_CORDIC_DAT ;
    // variables
    integer    sim_fpt ;
    integer    sim_tmp ;

    // main body
    begin
      // core loop
      forever begin
        // wait
        @( sim_event_chki_cordic_dat_bgn );

        // open files
        sim_fpt = $fopen( `SIM_CSTR_FILE_CHKI_CORDIC_DAT_THETA ,"r" );

        // set
        sim_tmp = 'd1 ;
        while( sim_tmp != -'sd1 ) begin
          @(negedge clk );
          val_i   = 'd1 ;
          sim_tmp = $fscanf( sim_fpt ,"%x", dat_theta_i );
        end

        // reset
        val_i       = 'd0 ;
        dat_theta_i = 'd0 ;

        // close files
        $fclose( sim_fpt );

        // return
        -> sim_event_chki_cordic_dat_end ;
      end
    end
  endtask


//*** SIM_TASK_CHKO ************************************************************
//--- CHKO_DAT -------------------------
  `define DUT_EVAL_HIERARCHY_CORDIC    dut
  `include "sub-testbench/sub-testbench_dat.vh"
