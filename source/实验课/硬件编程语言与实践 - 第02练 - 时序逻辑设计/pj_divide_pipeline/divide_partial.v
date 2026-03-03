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
  clk        ,
  rstn       ,
  val_i      ,
  dat_a_i    ,
  dat_b_i    ,
  val_o      ,
  dat_c_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  localparam    DATA_WD            = 'd8        ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                            clk          ;
  input                            rstn         ;

  // input
  input                            val_i        ;
  input      [DATA_WD    -1 :0]    dat_a_i      ;
  input      [DATA_WD    -1 :0]    dat_b_i      ;

  // output
  output reg                       val_o        ;
  output reg [DATA_WD*2  -1 :0]    dat_c_o      ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
