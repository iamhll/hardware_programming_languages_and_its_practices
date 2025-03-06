//------------------------------------------------------------------------------
  //
  //  Filename       : calc_add_knl.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [kernal logic] of [adder]
  //
//------------------------------------------------------------------------------

`include "define_calc.vh"

module calc_add_knl(
  // global
  clk                     ,
  rstn                    ,
  // cfg_i
  cfg_flg_saturation_i    ,
  // dat_i
  val_i                   ,
  dat_a_i                 ,
  dat_b_i                 ,
  // dat_o
  val_o                   ,
  dat_o
);


//*** PARAMETER ****************************************************************

  // global
  // !!! a special case here.
  localparam   DATA_WD                  = 'd16               ;

  // derived
  localparam   DATA_MAX                 = $signed( { 1'b0, {(DATA_WD-'d1){1'b1}}
                                        } )                  ;
  localparam   DATA_MIN                 = $signed( { 1'b1, {(DATA_WD-'d1){1'b0}}
                                        } )                  ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                                 clk                  ;
  input                                 rstn                 ;

  // cfg_i
  input                                 cfg_flg_saturation_i ;

  // val_i
  input                                 val_i                ;
  input      signed [DATA_WD  -1 :0]    dat_a_i              ;
  input      signed [DATA_WD  -1 :0]    dat_b_i              ;

  // val_o
  output reg                            val_o                ;
  output reg signed [DATA_WD  -1 :0]    dat_o                ;


//*** WIRE/REG *****************************************************************

  // output
  wire       signed [DATA_WD+1-1 :0]    dat_w                ;


//*** MAIN BODY ****************************************************************
//--- OUTPUT ---------------------------
  // val_o, dat_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o <= 'd0 ;
      dat_o <= 'd0 ;
    end
    else begin
        val_o <= val_i ;
      if( val_i ) begin
        dat_o <= !cfg_flg_saturation_i ? dat_w
               : ( dat_w > DATA_MAX )  ? DATA_MAX
               : ( dat_w < DATA_MIN )  ? DATA_MIN
               : dat_w
        ;
      end
    end
  end

  // dat_w
  assign dat_w = dat_a_i + dat_b_i ;


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG_CALC

  `endif

endmodule

`include "undef_calc.vh"
