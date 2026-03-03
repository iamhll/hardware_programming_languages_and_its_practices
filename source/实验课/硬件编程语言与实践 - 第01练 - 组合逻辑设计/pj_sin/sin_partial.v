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

module sin(
  dat_i    ,
  dat_o
);


//*** PARAMETER DECLARATION ****************************************************

  // local
  localparam    NUMB_ITR                = 'd16      ;

  localparam    DATA_INT_WD             = 'd1       ;
  localparam    DATA_FRC_WD             = 'd16      ;

  // derived
  localparam    DATA_WD                 = DATA_INT_WD
                                        + DATA_FRC_WD ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // input
  input       [DATA_WD        -1 :0]    dat_i       ;

  // output
  output      [DATA_WD        -1 :0]    dat_o       ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule

`undef SIN_DATA_A
