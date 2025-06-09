//------------------------------------------------------------------------------
  //
  //  Filename       : uart_tx_with_apb.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : uart_tx_with_apb
  //
//------------------------------------------------------------------------------

`include "define_uart.vh"

module uart_tx_with_apb(
  // global
  clk          ,
  rstn         ,
  // apb_if
  paddr_i      ,
  psel_i       ,
  penable_i    ,
  pwrite_i     ,
  prdata_o     ,
  pwdata_i     ,
  // dat_o
  uart_tx_o
);


//*** PARAMETER DECLARATION ****************************************************


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                                  clk                ;
  input                                  rstn               ;

  // apb_if
  input  [`APB_ADDR_WD         -1: 0]    paddr_i            ;
  input                                  psel_i             ;
  input                                  penable_i          ;
  input                                  pwrite_i           ;
  output [`APB_DATA_WD         -1: 0]    prdata_o           ;
  input  [`APB_DATA_WD         -1: 0]    pwdata_i           ;

  // dat_o
  output                                 uart_tx_o          ;


//*** WIRE/REG DECLARATION *****************************************************

  // APB
  wire   [`UART_NUMB_REG_WD    -1: 0]    APB_reg_adr_o_w    ;
  wire                                   APB_reg_wr_val_o_w ;
  wire   [`UART_DATA_REG_WD    -1: 0]    APB_reg_wr_dat_o_w ;
  wire                                   APB_reg_rd_val_o_w ;
  wire   [`UART_DATA_REG_WD    -1: 0]    APB_reg_rd_dat_i_w ;

  // REG
  wire   [`UART_NUMB_REG_WD    -1: 0]    REG_reg_adr_i_w    ;
  wire                                   REG_reg_wr_val_i_w ;
  wire   [`UART_DATA_REG_WD    -1: 0]    REG_reg_wr_dat_i_w ;
  wire                                   REG_reg_rd_val_i_w ;
  wire   [`UART_DATA_REG_WD    -1: 0]    REG_reg_rd_dat_o_w ;

  wire   [`UART_NUMB_DIV_CLK_WD-1: 0]    cfg_num_div_clk_i  ;
  wire   [`UART_NUMB_BIT_WD    -1: 0]    cfg_num_bit_i      ;
  wire   [`UART_ENUM_PARITY_WD -1: 0]    cfg_enm_parity_i   ;
  wire   [`UART_SIZE_STOP_WD   -1: 0]    cfg_siz_stop_i     ;
  wire   [`UART_SIZE_FIFO_WD   -1: 0]    fdb_num_dat_o      ;

  // uart
  wire                                   UART_val_i_w       ;
  wire   [`UART_NUMB_BIT_MAX   -1 :0]    UART_dat_i_w       ;
  wire                                   UART_ready_o_w     ;

  // fifo
  wire                                   FIFO_wr_val_i      ;
  wire   [`UART_NUMB_BIT_MAX   -1 :0]    FIFO_wr_dat_i      ;
  wire                                   FIFO_wr_ful_o      ;
  wire                                   FIFO_rd_rdy_o      ;
  wire                                   FIFO_rd_ack_i      ;
  wire   [`UART_NUMB_BIT_MAX   -1 :0]    FIFO_rd_dat_o      ;
  wire   [`UART_SIZE_FIFO_WD+1 -1 :0]    FIFO_wd_usd_o      ;


//*** MAIN BODY ****************************************************************
//--- APB2REG --------------------------
  // APB_reg_*_i_w
  assign APB_reg_rd_dat_i_w = REG_reg_rd_dat_o_w ;

  // apb2reg
  apb2reg apb2reg(
    // global
    .clk             (     clk               ),
    .rstn            (     rstn              ),
    // apb_if
    .paddr_i         (     paddr_i           ),
    .psel_i          (     psel_i            ),
    .penable_i       (     penable_i         ),
    .pwrite_i        (     pwrite_i          ),
    .prdata_o        (     prdata_o          ),
    .pwdata_i        (     pwdata_i          ),
    // reg_if
    .reg_adr_o       ( APB_reg_adr_o_w       ),
    .reg_wr_val_o    ( APB_reg_wr_val_o_w    ),
    .reg_wr_dat_o    ( APB_reg_wr_dat_o_w    ),
    .reg_rd_val_o    ( APB_reg_rd_val_o_w    ),
    .reg_rd_dat_i    ( APB_reg_rd_dat_i_w    )
  );


//--- UART_REG -------------------------
  // REG_reg_*_i_w
  assign REG_reg_adr_i_w    = APB_reg_adr_o_w    ;
  assign REG_reg_wr_val_i_w = APB_reg_wr_val_o_w ;
  assign REG_reg_wr_dat_i_w = APB_reg_wr_dat_o_w ;
  assign REG_reg_rd_val_i_w = APB_reg_rd_val_o_w ;

  // fdb_*_o
  assign fdb_num_dat_o = FIFO_wd_usd_o + !UART_ready_o_w ;

  // cfg_*_o
  uart_reg uart_reg(
    // global
    .clk                  (     clk                  ),
    .rstn                 (     rstn                 ),
    // reg_if
    .reg_adr_i            ( REG_reg_adr_i_w          ),
    .reg_wr_val_i         ( REG_reg_wr_val_i_w       ),
    .reg_wr_dat_i         ( REG_reg_wr_dat_i_w       ),
    .reg_rd_val_i         ( REG_reg_rd_val_i_w       ),
    .reg_rd_dat_o         ( REG_reg_rd_dat_o_w       ),
    // cfg_o
    .cfg_num_div_clk_o    (     cfg_num_div_clk_i    ),
    .cfg_num_bit_o        (     cfg_num_bit_i        ),
    .cfg_enm_parity_o     (     cfg_enm_parity_i     ),
    .cfg_siz_stop_o       (     cfg_siz_stop_i       ),
    // fdb_i
    .fdb_dat_i            (     8'b0                 ),
    .fdb_num_dat_i        (     fdb_num_dat_o        )
  );


//--- UART_RX --------------------------
  // UART_*_i_w
  assign UART_val_i_w = FIFO_rd_rdy_o && FIFO_rd_ack_i ;
  assign UART_dat_i_w = FIFO_rd_dat_o ;

  // UART_dat_o
  uart_tx uart_tx(
    // global
    .clk                  (      clk                  ),
    .rstn                 (      rstn                 ),
    // cfg_i
    .cfg_num_div_clk_i    (      cfg_num_div_clk_i    ),
    .cfg_num_bit_i        (      cfg_num_bit_i        ),
    .cfg_enm_parity_i     (      cfg_enm_parity_i     ),
    .cfg_siz_stop_i       (      cfg_siz_stop_i       ),
    // dat_i
    .val_i                ( UART_val_i_w              ),
    .dat_i                ( UART_dat_i_w              ),
    // dat_o
    .uart_tx_o            (      uart_tx_o            ),
    // status_o
    .ready_o              ( UART_ready_o_w            )
  );


//--- FIFO -----------------------------
  // FIFO_write
  assign FIFO_wr_val_i = REG_reg_wr_val_i_w && (REG_reg_adr_i_w==`UART_CFG_DATA) ;
  assign FIFO_wr_dat_i = REG_reg_wr_dat_i_w ;

  // FIFO_read
  assign FIFO_rd_ack_i = UART_ready_o_w ;

  // FIFO_read
  fifo_sc_ew_ack_reg_based #(
    .SIZE        ( `UART_SIZE_FIFO       ),
    .DATA_WD     ( `UART_NUMB_BIT_MAX    )
  ) fifo(
    // global
    .clk         (       clk             ),
    .rstn        (       rstn            ),
    // write
    .wr_val_i    (  FIFO_wr_val_i        ),
    .wr_dat_i    (  FIFO_wr_dat_i        ),
    .wr_ful_o    (  FIFO_wr_ful_o        ),
    // read
    .rd_rdy_o    (  FIFO_rd_rdy_o        ),
    .rd_ack_i    (  FIFO_rd_ack_i        ),
    .rd_dat_o    (  FIFO_rd_dat_o        ),
    // common
    .wd_usd_o    (  FIFO_wd_usd_o        )
  );


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
