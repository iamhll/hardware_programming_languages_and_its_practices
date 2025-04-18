//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench] for [crc]
  //
//------------------------------------------------------------------------------

//*** SIM_TASK_INIT ************************************************************
//--- SIM_TASK_INIT_CRC_CFG
  event    sim_event_init_crc_cfg ;

  initial begin
    SIM_TASK_INIT_CRC_CFG ;
  end

  task SIM_TASK_INIT_CRC_CFG ;
    // main body
    begin
      // loop
      forever begin
        // wait
        @( sim_event_init_crc_cfg );

        // set
        cfg_siz_poly_i   = `CRC_SIZE_POLY   ;
        cfg_dat_poly_i   = `CRC_DATA_POLY   ;
        cfg_dat_init_i   = `CRC_DATA_INIT   ;
        cfg_dat_xorout_i = `CRC_DATA_XOROUT ;
        cfg_flg_refin_i  = `CRC_FLAG_REFIN  ;
        cfg_flg_refout_i = `CRC_FLAG_REFOUT ;
      end
    end
  endtask


//*** SIM_TASK_CHKI ************************************************************
//--- SIM_TASK_CHKI_CRC_DAT
  event    sim_event_chki_crc_dat_bgn ;
  event    sim_event_chki_crc_dat_end ;

  initial begin
    SIM_TASK_CHKI_CRC_DAT ;
  end

  task SIM_TASK_CHKI_CRC_DAT ;
    // variables
    integer    sim_cnt ;
    integer    sim_fpt ;
    integer    sim_tmp ;

    // main body
    begin
      // core loop
      forever begin
        // wait
        @( sim_event_chki_crc_dat_bgn );

        // open files
        sim_fpt = $fopen( `SIM_CSTR_FILE_CHKI_CRC_DAT ,"r" );

        // set
        @(negedge clk );
        for( sim_cnt = 'd0 ;sim_cnt < `CRC_NUMB_INP ;sim_cnt = sim_cnt+'d1 ) begin
          val_i     = 'd1 ;
          flg_fst_i = sim_cnt == 'd0 ;
          flg_lst_i = sim_cnt == `CRC_NUMB_INP-'d1 ;
          sim_tmp   = $fscanf( sim_fpt ,"%x", dat_i );
          @(negedge clk );
        end

        // reset
        val_i     = 'd0 ;
        flg_fst_i = 'd0 ;
        flg_lst_i = 'd0 ;
        dat_i     = $random( sim_dat_seed );

        // close files
        $fclose( sim_fpt );

        // return
        -> sim_event_chki_crc_dat_end ;
      end
    end
  endtask


//*** SIM_TASK_CHKO ************************************************************
//--- CHKO_DAT -------------------------
  `define DUT_EVAL_HIERARCHY_CRC    dut
  `include "sub-testbench/sub-testbench_dat.vh"
