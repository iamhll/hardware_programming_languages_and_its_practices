//------------------------------------------------------------------------------
  //
  //  Filename       : uart_reg.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : uart_reg
  //
//------------------------------------------------------------------------------

`include "define_uart.vh"

module uart_reg(
  // global
  clk                  ,
  rstn                 ,
  // reg_if
  reg_adr_i            ,
  reg_wr_val_i         ,
  reg_wr_dat_i         ,
  reg_rd_val_i         ,
  reg_rd_dat_o         ,
  // cfg_o
  cfg_num_div_clk_o    ,
  cfg_num_bit_o        ,
  cfg_enm_parity_o     ,
  cfg_siz_stop_o       ,
  // fdb_i
  fdb_dat_i            ,
  fdb_num_dat_i
);


//*** PARAMETER DECLARATION ****************************************************

  // local

  // derived


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                                      clk               ;
  input                                      rstn              ;

  // cfg_i
  input      [`UART_NUMB_REG_WD    -1: 0]    reg_adr_i         ;
  input                                      reg_wr_val_i      ;
  input      [`UART_DATA_REG_WD    -1: 0]    reg_wr_dat_i      ;
  input                                      reg_rd_val_i      ;
  output reg [`UART_DATA_REG_WD    -1: 0]    reg_rd_dat_o      ;

  // cfg_o
  output reg [`UART_NUMB_DIV_CLK_WD-1: 0]    cfg_num_div_clk_o ;
  output reg [`UART_NUMB_BIT_WD    -1: 0]    cfg_num_bit_o     ;
  output reg [`UART_ENUM_PARITY_WD -1: 0]    cfg_enm_parity_o  ;
  output reg [`UART_SIZE_STOP_WD   -1: 0]    cfg_siz_stop_o    ;

  // fdb_i
  input      [`UART_NUMB_BIT_MAX   -1: 0]    fdb_dat_i         ;
  input      [`UART_SIZE_FIFO_WD   -1: 0]    fdb_num_dat_i     ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************
//--- OUTPUT (CFG_O) -------------------
  // cfg_*_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      cfg_num_div_clk_o <= 'd0 ;
      cfg_num_bit_o     <= 'd0 ;
      cfg_enm_parity_o  <= 'd0 ;
      cfg_siz_stop_o    <= 'd0 ;
    end
    else begin
      if( reg_wr_val_i ) begin
        case( reg_adr_i )
          `UART_CFG_DATA_DIV_CLK :    cfg_num_div_clk_o <= reg_wr_dat_i ;
          `UART_CFG_NUMB_BIT     :    cfg_num_bit_o     <= reg_wr_dat_i ;
          `UART_CFG_ENUM_PARITY  :    cfg_enm_parity_o  <= reg_wr_dat_i ;
          `UART_CFG_SIZE_STOP    :    cfg_siz_stop_o    <= reg_wr_dat_i ;
        endcase
      end
    end
  end


//--- OUTPUT (CFG_O) -------------------
  // reg_rd_dat_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      reg_rd_dat_o <= 'd0 ;
    end
    else begin
      if( reg_rd_val_i ) begin
        case( reg_adr_i )
          `UART_CFG_DATA_DIV_CLK :    reg_rd_dat_o <= cfg_num_div_clk_o ;
          `UART_CFG_NUMB_BIT     :    reg_rd_dat_o <= cfg_num_bit_o     ;
          `UART_CFG_ENUM_PARITY  :    reg_rd_dat_o <= cfg_enm_parity_o  ;
          `UART_CFG_SIZE_STOP    :    reg_rd_dat_o <= cfg_siz_stop_o    ;
          `UART_FDB_DATA         :    reg_rd_dat_o <= fdb_dat_i         ;
          `UART_FDB_NUMB_DAT     :    reg_rd_dat_o <= fdb_num_dat_i     ;
        endcase
      end
    end
  end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
