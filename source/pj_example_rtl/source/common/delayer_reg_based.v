//------------------------------------------------------------------------------
  //
  //  Filename       : delayer_reg_based.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : register-based delayer
  //
//------------------------------------------------------------------------------

`include "define.vh"

module delayer_reg_based(
  // global
  clk      ,
  rstn     ,
  // dat_i
  val_i    ,
  dat_i    ,
  // dat_o
  val_o    ,
  dat_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  parameter    SIZE            = -1                 ;

  parameter    DATA_WD         = -1                 ;

  // derived
  localparam   SIZE_WD         = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                        clk                  ;
  input                        rstn                 ;

  // write
  input                        val_i                ;
  input      [DATA_WD-1 :0]    dat_i                ;

  // read
  output reg                   val_o                ;
  output     [DATA_WD-1 :0]    dat_o                ;


//*** WIRE/REG DECLARATION *****************************************************

  // val
  reg        [SIZE-1 -1 :0]    val_r                ;


//*** MAIN BODY ****************************************************************
//--- VAL ------------------------------
  // val_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      { val_o ,val_r } <= 'd0 ;
    end
    else begin
      { val_o ,val_r } <= { val_r ,val_i };
    end
  end


//--- REG ARRAY ------------------------
  fifo_sc_ew_req_reg_based #(
    .SIZE        ( SIZE                   ),
    .DATA_WD     ( DATA_WD                )
  ) fifo_sc_ew_req_reg_based(
    // global
    .clk         ( clk                    ),
    .rstn        ( rstn                   ),
    // write
    .wr_val_i    ( val_i                  ),
    .wr_dat_i    ( dat_i                  ),
    .wr_ful_o    ( /* UNUSED */           ),
    // read
    .rd_val_i    ( val_r[SIZE-'d1-'d1]    ),
    .rd_val_o    ( /* UNUSED */           ),
    .rd_dat_o    ( dat_o                  ),
    .rd_ept_o    ( /* UNUSED */           ),
    // common
    .wd_usd_o    ( /* UNUSED */           )
  );


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

    // sanity check
    initial begin
      wait( rstn );
      if( SIZE < 'd2 ) begin
        $display( "\n\t COMMON_DELAYER ERROR: SIZE in %m cannot be lesser than 2 ! \n" );
        #1000 ;
        $finish ;
      end
    end

  `endif

endmodule
