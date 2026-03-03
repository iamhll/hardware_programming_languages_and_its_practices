//------------------------------------------------------------------------------
  //
  //  Filename       : gray2bin.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [kernal logic] of [gray2bin]
  //
//------------------------------------------------------------------------------

module gray2bin(
  // dat_i
  dat_g_i    ,
  // dat_o
  dat_b_o
);


//*** PARAMETER ****************************************************************

  // global
  // !!! a special case here.
  parameter    DATA_WD         = 'd32  ;


//*** INPUT/OUTPUT *************************************************************  ;

  // dat_i
  input      [DATA_WD-1 :0]    dat_g_i ;

  // dat_o
  output reg [DATA_WD-1 :0]    dat_b_o ;


//*** WIRE/REG *****************************************************************

  // loop
  integer                  lpIdx   ;


//*** MAIN BODY ****************************************************************

  // dat_b_o
  always @(*) begin
      dat_b_o[DATA_WD-1] = dat_g_i[DATA_WD-1] ;
    for( lpIdx = DATA_WD-'d2 ;lpIdx >= 'sd0 ;lpIdx = lpIdx-'d1 ) begin
      dat_b_o[lpIdx    ] = dat_b_o[lpIdx+1  ] ^ dat_g_i[lpIdx] ;
    end
  end

endmodule
