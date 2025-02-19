//------------------------------------------------------------------------------
  //
  //  Filename       : apb2reg.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : apb2reg
  //
//------------------------------------------------------------------------------

`include "define_uart.vh"

module apb2reg(
  // global
  clk             ,
  rstn            ,
  // apb_if
  paddr_i         ,
  psel_i          ,
  penable_i       ,
  pwrite_i        ,
  prdata_o        ,
  pwdata_i        ,
  // reg_if
  reg_adr_o       ,
  reg_wr_val_o    ,
  reg_wr_dat_o    ,
  reg_rd_val_o    ,
  reg_rd_dat_i
);


//*** PARAMETER DECLARATION ****************************************************


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                              clk          ;
  input                              rstn         ;

  // apb_if
  input  [`APB_ADDR_WD     -1: 0]    paddr_i      ;
  input                              psel_i       ;
  input                              penable_i    ;
  input                              pwrite_i     ;
  output [`APB_DATA_WD     -1: 0]    prdata_o     ;
  input  [`APB_DATA_WD     -1: 0]    pwdata_i     ;

  // reg_if
  output [`UART_NUMB_REG_WD-1: 0]    reg_adr_o    ;
  output                             reg_wr_val_o ;
  output [`UART_DATA_REG_WD-1: 0]    reg_wr_dat_o ;
  output                             reg_rd_val_o ;
  input  [`UART_DATA_REG_WD-1: 0]    reg_rd_dat_i ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************
  // output
  assign reg_adr_o    = paddr_i >> 'd2 ;
  assign reg_wr_val_o = psel_i & !penable_i &  pwrite_i ;
  assign reg_wr_dat_o = pwdata_i ;
  assign reg_rd_val_o = psel_i & !penable_i & !pwrite_i ;
  assign prdata_o     = reg_rd_dat_i ;


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
