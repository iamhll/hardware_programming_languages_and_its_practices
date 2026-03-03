//------------------------------------------------------------------------------
  //
  //  Filename       : bin2gray.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [kernal logic] of [bin2gray]
  //
//------------------------------------------------------------------------------

module bin2gray(
  // dat_i
  dat_b_i    ,
  // dat_o
  dat_g_o
);


//*** PARAMETER ****************************************************************

  // global
  // !!! a special case here.
  parameter    DATA_WD     = 'd32  ;


//*** INPUT/OUTPUT *************************************************************

  // dat_i
  input  [DATA_WD-1 :0]    dat_b_i ;

  // dat_o
  output [DATA_WD-1 :0]    dat_g_o ;


//*** WIRE/REG *****************************************************************


//*** MAIN BODY ****************************************************************

  // dat_g_o
  assign dat_g_o = dat_b_i ^ (dat_b_i>>'b1) ;

endmodule
