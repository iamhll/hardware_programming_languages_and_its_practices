//------------------------------------------------------------------------------
  //
  //  Filename       : divide.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : divide
  //
//------------------------------------------------------------------------------

`include "define.vh"

module divide(
  dat_a_i    ,
  dat_b_i    ,
  dat_c_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  localparam    DATA_WD        = 'd8        ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // input
  input  [DATA_WD    -1 :0]    dat_a_i      ;
  input  [DATA_WD    -1 :0]    dat_b_i      ;

  // output
  output [DATA_WD*2  -1 :0]    dat_c_o      ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
