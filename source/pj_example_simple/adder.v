//------------------------------------------------------------------------------
  //
  //  Filename       : adder.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [kernal logic] of [adder]
  //
//------------------------------------------------------------------------------

module adder(
  // global
  clk        ,
  rstn       ,
  // dat_i
  val_i      ,
  dat_a_i    ,
  dat_b_i    ,
  // dat_o
  val_o      ,
  dat_c_o
);


//*** PARAMETER ****************************************************************

  // global
  // !!! a special case here.
  localparam   DATA_WD                  = 'd8   ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                                 clk     ;
  input                                 rstn    ;

  // dat_i
  input                                 val_i   ;
  input      signed [DATA_WD  -1 :0]    dat_a_i ;
  input      signed [DATA_WD  -1 :0]    dat_b_i ;

  // dat_o
  output reg                            val_o   ;
  output reg signed [DATA_WD+1-1 :0]    dat_c_o ;


//*** WIRE/REG *****************************************************************


//*** MAIN BODY ****************************************************************
//--- OUTPUT ---------------------------
  // val_o, dat_c_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o   <= 'd0 ;
      dat_c_o <= 'd0 ;
    end
    else begin
        val_o   <= val_i ;
      if( val_i ) begin
        dat_c_o <= dat_a_i + dat_b_i ;
      end
    end
  end

endmodule
