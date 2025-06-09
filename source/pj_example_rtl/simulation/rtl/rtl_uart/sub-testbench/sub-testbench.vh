//------------------------------------------------------------------------------
  //
  //  Filename       : sub-testbench.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [sub-testbench] for [uart]
  //
//------------------------------------------------------------------------------

//*** SIM_TASK_INIT ************************************************************


//*** SIM_TASK_CHKI ************************************************************
//--- SIM_TASK_CHKI_UART_CFG
  event    sim_event_chki_uart_cfg_bgn ;
  event    sim_event_chki_uart_cfg_end ;

  initial begin
    SIM_TASK_CHKI_UART_CFG ;
  end

  task SIM_TASK_CHKI_UART_CFG ;
    // main body
    begin
      // loop
      forever begin
        // wait
        @( sim_event_chki_uart_cfg_bgn );

        // set
        APB_TX_WRITE( `UART_CFG_DATA_DIV_CLK , 'd100_000_000/'d2/'d115200 - 'd1 ,`SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_NUMB_BIT     , 'd7                              ,`SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_ENUM_PARITY  , `UART_ENUM_PARITY_ODD            ,`SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_SIZE_STOP    , 'd1                              ,`SIM_FLAG_DSP_REG );
        APB_RX_WRITE( `UART_CFG_DATA_DIV_CLK , 'd100_000_000/'d2/'d115200 - 'd1 ,`SIM_FLAG_DSP_REG );
        APB_RX_WRITE( `UART_CFG_NUMB_BIT     , 'd7                              ,`SIM_FLAG_DSP_REG );
        APB_RX_WRITE( `UART_CFG_ENUM_PARITY  , `UART_ENUM_PARITY_ODD            ,`SIM_FLAG_DSP_REG );
        APB_RX_WRITE( `UART_CFG_SIZE_STOP    , 'd1                              ,`SIM_FLAG_DSP_REG );

        // return
        -> sim_event_chki_uart_cfg_end ;
      end
    end
  endtask


//--- SIM_TASK_CHKI_UART_DAT
  event    sim_event_chki_uart_dat_bgn ;
  event    sim_event_chki_uart_dat_end ;

  initial begin
    SIM_TASK_CHKI_UART_DAT ;
  end

  task SIM_TASK_CHKI_UART_DAT ;
    // variables
    integer    sim_cnt ;
    integer    sim_tmp ;

    // main body
    begin
      // core loop
      forever begin
        // wait
        @( sim_event_chki_uart_dat_bgn );

        // set
        APB_TX_WRITE( `UART_CFG_DATA ,"H" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"e" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"l" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"l" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"o" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"," , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ," " , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"w" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"o" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"r" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"l" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"d" , `SIM_FLAG_DSP_REG );
        APB_TX_WRITE( `UART_CFG_DATA ,"!" , `SIM_FLAG_DSP_REG );

        // return
        -> sim_event_chki_uart_dat_end ;
      end
    end
  endtask


//*** SIM_TASK_CHKO ************************************************************
