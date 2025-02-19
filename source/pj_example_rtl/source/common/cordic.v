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

`define CORDIC_DATA_A    ( ( lpIdx == 'd00 ) ? DATA_A_00    \
                         : ( lpIdx == 'd01 ) ? DATA_A_01    \
                         : ( lpIdx == 'd02 ) ? DATA_A_02    \
                         : ( lpIdx == 'd03 ) ? DATA_A_03    \
                         : ( lpIdx == 'd04 ) ? DATA_A_04    \
                         : ( lpIdx == 'd05 ) ? DATA_A_05    \
                         : ( lpIdx == 'd06 ) ? DATA_A_06    \
                         : ( lpIdx == 'd07 ) ? DATA_A_07    \
                         : ( lpIdx == 'd08 ) ? DATA_A_08    \
                         : ( lpIdx == 'd09 ) ? DATA_A_09    \
                         : ( lpIdx == 'd10 ) ? DATA_A_10    \
                         : ( lpIdx == 'd11 ) ? DATA_A_11    \
                         : ( lpIdx == 'd12 ) ? DATA_A_12    \
                         : ( lpIdx == 'd13 ) ? DATA_A_13    \
                         : ( lpIdx == 'd14 ) ? DATA_A_14    \
                         :                     DATA_A_15    \
                         )

module cordic(
    dat_theta_i     ,
    dat_result_o
);


//*** PARAMETER DECLARATION ****************************************************

  // local
  localparam    NUMB_ITR                = 'd16        ;

  localparam    DATA_INT_WD             = 'd1         ;
  localparam    DATA_FRC_WD             = 'd16        ;

  localparam    DATA_INN_ANG_FRC_WD     = 'd19        ;
  localparam    DATA_INN_RLT_FRC_WD     = 'd19        ;

  localparam    DATA_K                  = 'sd318375   ;
  localparam    DATA_A_00               = 'sd411775   ;
  localparam    DATA_A_01               = 'sd243085   ;
  localparam    DATA_A_02               = 'sd128439   ;
  localparam    DATA_A_03               = 'sd65198    ;
  localparam    DATA_A_04               = 'sd32725    ;
  localparam    DATA_A_05               = 'sd16379    ;
  localparam    DATA_A_06               = 'sd8191     ;
  localparam    DATA_A_07               = 'sd4096     ;
  localparam    DATA_A_08               = 'sd2048     ;
  localparam    DATA_A_09               = 'sd1024     ;
  localparam    DATA_A_10               = 'sd512      ;
  localparam    DATA_A_11               = 'sd256      ;
  localparam    DATA_A_12               = 'sd128      ;
  localparam    DATA_A_13               = 'sd64       ;
  localparam    DATA_A_14               = 'sd32       ;
  localparam    DATA_A_15               = 'sd16       ;

  // derived
  localparam    DATA_WD                 = DATA_INT_WD
                                        + DATA_FRC_WD ;
  localparam    DATA_INN_ANG_WD         = 'd1
                                        + DATA_INT_WD
                                        + DATA_INN_ANG_FRC_WD ;
  localparam    DATA_INN_RLT_WD         = 'd1
                                        + DATA_INT_WD
                                        + DATA_INN_RLT_FRC_WD ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // input
  input       [DATA_WD        -1 :0]    dat_theta_i   ;

  // output
  output      [DATA_WD        -1 :0]    dat_result_o  ;


//*** WIRE/REG DECLARATION *****************************************************

  // output
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_x_w       ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_y_w       ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_x_tmp_w   ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_y_tmp_w   ;
  reg  signed [DATA_INN_ANG_WD-1 :0]    dat_z_w       ;

  integer                               lpIdx         ;


//*** MAIN BODY ****************************************************************
//--- OUPUT ----------------------------
  // dat_result_o
  assign dat_result_o = ( dat_y_w + ('sd1<<<(DATA_INN_RLT_FRC_WD-DATA_FRC_WD-'d1)) )
                    >>> ( DATA_INN_RLT_FRC_WD - DATA_FRC_WD )
  ;

  // dat_x_w, dat_y_w
  // dat_z_w
  always @(*) begin
        dat_x_w     =  DATA_K                    ;
        dat_y_w     = 'sd0                       ;
        dat_z_w     = $signed({1'b0,dat_theta_i}) <<< (DATA_INN_ANG_FRC_WD-DATA_FRC_WD) ;
    for( lpIdx = 'd0 ;lpIdx < NUMB_ITR ;lpIdx = lpIdx + 'd1 ) begin
        dat_x_tmp_w =  dat_x_w >>> lpIdx         ;
        dat_y_tmp_w =  dat_y_w >>> lpIdx         ;
      if( dat_z_w >= 'sd0 ) begin
        dat_x_w     =  dat_x_w -   dat_y_tmp_w   ;
        dat_y_w     =  dat_y_w +   dat_x_tmp_w   ;
        dat_z_w     =  dat_z_w -  `CORDIC_DATA_A ;
      end
      else begin
        dat_x_w     =  dat_x_w +   dat_y_tmp_w   ;
        dat_y_w     =  dat_y_w -   dat_x_tmp_w   ;
        dat_z_w     =  dat_z_w +  `CORDIC_DATA_A ;
      end
    end
  end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule

`undef CORDIC_DATA_A
