//------------------------------------------------------------------------------
  //
  //  Filename       : crc.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : crc
  //
//------------------------------------------------------------------------------

`include "define.vh"

module crc(
  // global
  clk                 ,
  rstn                ,
  // cfg_i
  cfg_siz_poly_i      ,
  cfg_dat_poly_i      ,
  cfg_dat_init_i      ,
  cfg_dat_xorout_i    ,
  cfg_flg_refin_i     ,
  cfg_flg_refout_i    ,
  // val_i
  val_i               ,
  flg_fst_i           ,
  flg_lst_i           ,
  dat_i               ,
  // val_o
  val_o               ,
  dat_o
);


//*** PARAMETER DECLARATION ****************************************************

  // local
  localparam   DATA_INP_WD        = 'd8            ;
  localparam   DATA_OUT_WD        = 'd32           ;

  // derived
  localparam   SIZE_OUT_WD        = `FUNC_LOG2( DATA_OUT_WD );


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                            clk              ;
  input                            rstn             ;

  // cfg_i
  input      [SIZE_OUT_WD-1 :0]    cfg_siz_poly_i   ;
  input      [DATA_OUT_WD-1 :0]    cfg_dat_poly_i   ;
  input      [DATA_OUT_WD-1 :0]    cfg_dat_init_i   ;
  input      [DATA_OUT_WD-1 :0]    cfg_dat_xorout_i ;
  input                            cfg_flg_refin_i  ;
  input                            cfg_flg_refout_i ;

  // val_i
  input                            val_i            ;
  input                            flg_fst_i        ;
  input                            flg_lst_i        ;
  input      [DATA_INP_WD-1 :0]    dat_i            ;

  // val_o
  output reg                       val_o            ;
  output     [DATA_OUT_WD-1 :0]    dat_o            ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
