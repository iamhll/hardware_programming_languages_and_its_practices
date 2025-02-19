//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench] for [fifo]
  //
//------------------------------------------------------------------------------

//*** SIM_TASK_INIT ************************************************************
//--- SIM_TASK_INIT_FIFO_CFG
  event    sim_event_init_fifo_cfg ;

  initial begin
    SIM_TASK_INIT_FIFO_CFG ;
  end

  task SIM_TASK_INIT_FIFO_CFG ;
    // main body
    begin
      // loop
      forever begin
        // wait
        @( sim_event_init_fifo_cfg );

        // set
        //...
      end
    end
  endtask


//*** SIM_TASK_CHKI ************************************************************
//--- SIM_TASK_CHKI_FIFO_DAT
  event    sim_event_chki_fifo_dat_bgn ;
  event    sim_event_chki_fifo_dat_end ;

  initial begin
    SIM_TASK_CHKI_FIFO_DAT ;
  end

  task SIM_TASK_CHKI_FIFO_DAT ;
    // variables
    integer    sim_cnt ;
    integer    sim_typ ;

    // main body
    begin
      // core loop
      forever begin
        // wait
        @( sim_event_chki_fifo_dat_bgn );

        // set
        sim_cnt = {$random(sim_dat_seed)} % 4096 + 1;
        sim_typ = {$random(sim_dat_seed)} % 3;
        repeat( sim_cnt ) begin
          @(negedge clk );
          wr_val_i = 'd0 ;
        //wr_dat_i = $random( sim_dat_seed );
          while( wr_ful_o ) begin
            @(negedge clk );
          end
          wr_val_i = 'd1 ;
          wr_dat_i = $random( sim_dat_seed );
          case( sim_typ )
          //'d0 :    do nothing ;
            'd1 :    if( {$random(sim_dat_seed)} % 100 == 'd0 ) begin
                       repeat( {$random(sim_dat_seed)} % 100 ) begin
                         @(negedge clk );
                         wr_val_i = 'd0 ;
                       //wr_dat_i = $random( sim_dat_seed );
                       end
                     end
            'd2 :    repeat( {$random(sim_dat_seed)} % 100 ) begin
                       @(negedge clk );
                       wr_val_i = 'd0 ;
                     //wr_dat_i = $random( sim_dat_seed );
                     end
          endcase
        end

        // reset
        @(negedge clk );
        wr_val_i = 'd0 ;
        wr_dat_i = 'd0 ;

        // return
        -> sim_event_chki_fifo_dat_end ;
      end
    end
  endtask
