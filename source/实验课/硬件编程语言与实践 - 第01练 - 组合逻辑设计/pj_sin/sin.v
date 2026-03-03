//------------------------------------------------------------------------------
  //
  //  Filename       : sin.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : sin
  //
//------------------------------------------------------------------------------

`include "define.vh"

`define SIN_DATA_A    ( ( lpIdx == 'd00 ) ? DATA_A_00    \
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

module sin(
  dat_i    ,
  dat_o
);


//*** PARAMETER DECLARATION ****************************************************

  // local
  localparam    NUMB_ITR                = 'd16      ;

  localparam    DATA_INT_WD             = 'd1       ;
  localparam    DATA_FRC_WD             = 'd16      ;

  localparam    DATA_INN_ANG_FRC_WD     = 'd17      ;
  localparam    DATA_INN_FRC_WD         = 'd19      ;

  localparam    DATA_K                  = 'sd318375 ;
  localparam    DATA_A_00               = 'sd102944 ;
  localparam    DATA_A_01               = 'sd60771  ;
  localparam    DATA_A_02               = 'sd32110  ;
  localparam    DATA_A_03               = 'sd16299  ;
  localparam    DATA_A_04               = 'sd8181   ;
  localparam    DATA_A_05               = 'sd4095   ;
  localparam    DATA_A_06               = 'sd2048   ;
  localparam    DATA_A_07               = 'sd1024   ;
  localparam    DATA_A_08               = 'sd512    ;
  localparam    DATA_A_09               = 'sd256    ;
  localparam    DATA_A_10               = 'sd128    ;
  localparam    DATA_A_11               = 'sd64     ;
  localparam    DATA_A_12               = 'sd32     ;
  localparam    DATA_A_13               = 'sd16     ;
  localparam    DATA_A_14               = 'sd8      ;
  localparam    DATA_A_15               = 'sd4      ;

  // derived
  localparam    DATA_WD                 = DATA_INT_WD
                                        + DATA_FRC_WD ;
  localparam    DATA_INN_ANG_WD         = 'd1
                                        + DATA_INT_WD
                                        + DATA_INN_ANG_FRC_WD ;
  localparam    DATA_INN_RLT_WD         = 'd1
                                        + DATA_INT_WD
                                        + DATA_INN_FRC_WD ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // input
  input       [DATA_WD        -1 :0]    dat_i       ;

  // output
  output      [DATA_WD        -1 :0]    dat_o       ;


//*** WIRE/REG DECLARATION *****************************************************

  // output
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_x_w     ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_y_w     ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_x_tmp_w ;
  reg  signed [DATA_INN_RLT_WD-1 :0]    dat_y_tmp_w ;
  reg  signed [DATA_INN_ANG_WD-1 :0]    dat_a_w     ;

  integer                               lpIdx       ;


//*** MAIN BODY ****************************************************************
//--- OUPUT ----------------------------
  // dat_o
  assign dat_o = ( dat_y_w + ('sd1<<<(DATA_INN_FRC_WD-DATA_FRC_WD-'d1)) )
             >>> ( DATA_INN_FRC_WD - DATA_FRC_WD )
  ;

  // dat_x_w, dat_y_w
  // dat_a_w
  always @(*) begin
        dat_x_w     =  DATA_K                  ;
        dat_y_w     = 'sd0                     ;
        dat_a_w     = $signed({1'b0,dat_i}) <<< (DATA_INN_ANG_FRC_WD-DATA_FRC_WD) ;
    for( lpIdx = 'd0 ;lpIdx < NUMB_ITR ;lpIdx = lpIdx + 'd1 ) begin
        dat_x_tmp_w =  dat_x_w >>> lpIdx       ;
        dat_y_tmp_w =  dat_y_w >>> lpIdx       ;
      if( dat_a_w >= 'sd0 ) begin
        dat_x_w     =  dat_x_w -   dat_y_tmp_w ;
        dat_y_w     =  dat_y_w +   dat_x_tmp_w ;
        dat_a_w     =  dat_a_w -  `SIN_DATA_A  ;
      end
      else begin
        dat_x_w     =  dat_x_w +   dat_y_tmp_w ;
        dat_y_w     =  dat_y_w -   dat_x_tmp_w ;
        dat_a_w     =  dat_a_w +  `SIN_DATA_A  ;
      end
    end
  end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule

`undef SIN_DATA_A
