//------------------------------------------------------------------------------
  //
  //  Filename       : cordic.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : cordic
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

  // input
  wire       [DATA_INP_WD-1 :0]    true_dat_i       ;

  // for loop
  reg        [DATA_OUT_WD-1 :0]    dat_crc_r        ;
  reg        [DATA_OUT_WD-1 :0]    dat_crc_next_w[DATA_INP_WD-1:0] ;
  wire       [DATA_OUT_WD-1 :0]    dat_crc_curr_w   ;
  wire       [DATA_OUT_WD-1 :0]    dat_crc_prev_w   ;

  // output
  wire       [DATA_OUT_WD-1 :0]    dat_out_1_w      ;
  wire       [DATA_OUT_WD-1 :0]    dat_out_0_w      ;

  // index
  genvar                           gvIdx            ;
//integer                          lpIdx            ;


//*** MAIN BODY ****************************************************************
//--- INPUT ----------------------------
  // true_dat_i
  generate
  for( gvIdx = 'd0 ;gvIdx < DATA_INP_WD ;gvIdx = gvIdx + 'd1 ) begin : inp
    assign true_dat_i[gvIdx] = cfg_flg_refin_i
                             ? dat_i[DATA_INP_WD-'d1-gvIdx]
                             : dat_i[gvIdx]
    ;
  end
  endgenerate
  //always @(*) begin
  //  if( cfg_flg_refin_i ) begin
  //    for( lpIdx = 'd0 ;lpIdx < DATA_INP_WD ;lpIdx = lpIdx + 'd1 ) begin
  //      true_dat_i[lpIdx] = dat_i[DATA_INP_WD-'d1-lpIdx] ;
  //    end
  //  end
  //  else begin
  //      true_dat_i        = dat_i ;
  //  end
  //end


//--- FOR LOOP -------------------------
  // dat_crc_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      dat_crc_r <= 'd0 ;
    end
    else begin
      if( val_i ) begin
        dat_crc_r <= dat_crc_next_w[DATA_INP_WD-1] ;
      end
    end
  end

  // dat_crc_next_w
  generate
  for( gvIdx = 'd0 ;gvIdx < DATA_INP_WD ;gvIdx = gvIdx + 'd1 ) begin : loop
    if( gvIdx == 'd0 ) begin
      always @(*) begin
        if( dat_crc_curr_w[DATA_OUT_WD-1] ) begin
          dat_crc_next_w[gvIdx] = (dat_crc_curr_w<<'d1) ^ (cfg_dat_poly_i<<(DATA_OUT_WD-'d1-cfg_siz_poly_i)) ;
        end
        else begin
          dat_crc_next_w[gvIdx] = (dat_crc_curr_w<<'d1) ;
        end
      end
    end
    else begin
      always @(*) begin
        if( dat_crc_next_w[gvIdx-1][DATA_OUT_WD-1] ) begin
          dat_crc_next_w[gvIdx] = (dat_crc_next_w[gvIdx-1]<<'d1) ^ (cfg_dat_poly_i<<(DATA_OUT_WD-'d1-cfg_siz_poly_i)) ;
        end
        else begin
          dat_crc_next_w[gvIdx] = (dat_crc_next_w[gvIdx-1]<<'d1) ;
        end
      end
    end
  end
  endgenerate
  //always @(*) begin
  //      dat_crc_next_w = dat_crc_prev_w ^ (true_dat_i    <<(DATA_OUT_WD-'d1-cfg_siz_poly_i)) ;
  //  for( lpIdx = DATA_OUT_WD - 'd1 ;lpIdx >= 'd0 ;lpIdx = lpIdx - 'd1 ) begin
  //    if( dat_crc_next_w[DATA_OUT_WD-1] ) begin
  //      dat_crc_next_w = dat_crc_next_w << 'd1 ;
  //      dat_crc_next_w = dat_crc_next_w ^ (cfg_dat_poly_i<<(DATA_OUT_WD-'d1-cfg_siz_poly_i)) ;
  //    end
  //    else begin
  //      dat_crc_next_w = dat_crc_next_w << 'd1 ;
  //    end
  //  end
  //end

  // dat_crc_curr_w
  assign dat_crc_curr_w = dat_crc_prev_w ^ (true_dat_i<<(DATA_OUT_WD-DATA_INP_WD)) ;

  // dat_crc_prev_w
  assign dat_crc_prev_w = flg_fst_i
                        ? ( cfg_dat_init_i << (DATA_OUT_WD-'d1-cfg_siz_poly_i) )
                        : dat_crc_r
  ;


//--- OUTPUT ---------------------------
  // val_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o <= 'd0 ;
    end
    else begin
      val_o <= val_i && flg_lst_i ;
    end
  end

  // dat_o
  assign dat_o = dat_out_1_w ^ cfg_dat_xorout_i ;

  // dat_out_1_w
  assign dat_out_1_w = cfg_flg_refout_i
                     ? dat_out_0_w
                     : ( dat_crc_r >> (DATA_OUT_WD-'d1-cfg_siz_poly_i) )
  ;

  // dat_out_0_w
  generate
  for( gvIdx = 'd0 ;gvIdx < DATA_OUT_WD ;gvIdx = gvIdx + 'd1 ) begin : out
    assign dat_out_0_w[gvIdx] = cfg_flg_refout_i
                              ? dat_crc_r[DATA_OUT_WD-'d1-gvIdx]
                              : dat_crc_r[gvIdx]
    ;
  end
  endgenerate
//always @(*) begin
//  if( cfg_flg_refout_i ) begin
//    for( lpIdx = 'd0 ;lpIdx < DATA_OUT_WD ;lpIdx = lpIdx + 'd1 ) begin
//      dat_out_w[lpIdx] = dat_crc_r[DATA_OUT_WD-'d1-lpIdx] ;
//    end
//  end
//  else begin
//      dat_out_w        = dat_crc_r ;
//  end
//end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
