//------------------------------------------------------------------------------
  //
  //  Filename       : sram_sp_behave.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [rtl model] for [single-port sram]
  //
//------------------------------------------------------------------------------

`include "define.vh"

module sram_sp_behave(
  // global
  clk         ,
  // common
  adr_i       ,
  // write
  wr_val_i    ,
  wr_dat_i    ,
  // read
  rd_val_i    ,
  rd_dat_o
);


//*** PARAMETER ****************************************************************

  // global
  parameter    KNOB_RNDOUT     = -1                 ;

  parameter    SIZE            = -1                 ;

  parameter    DATA_WD         = -1                 ;

  // derived
  localparam   SIZE_WD         = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                        clk                  ;

  // common
  input      [SIZE_WD-1 :0]    adr_i                ;

  // write
  input                        wr_val_i             ;
  input      [DATA_WD-1 :0]    wr_dat_i             ;

  // read
  input                        rd_val_i             ;
  output reg [DATA_WD-1 :0]    rd_dat_o             ;


//*** WIRE/REG *****************************************************************

  integer                      lpIdx                ;

  reg        [DATA_WD-1 :0]    mem_array[SIZE-1 :0] ;


//*** MAIN BODY ****************************************************************

  // mem_array
  // synthesis translate_off
  generate
    if( KNOB_RNDOUT == 'd1 ) begin : enabRndOut
      initial begin
        for( lpIdx = 'd0 ;lpIdx < SIZE ;lpIdx = lpIdx + 'd1 ) begin
          `ifdef SIM_EVAL_TOP
            mem_array[lpIdx] = $random( `SIM_EVAL_TOP.sim_dat_seed );
          `else
            mem_array[lpIdx] = $random ;
          `endif
        end
      end
    end
  endgenerate
  // synthesis translate_on
  always @(posedge clk ) begin
    if( wr_val_i ) begin
      mem_array[adr_i] <= wr_dat_i ;
    end
  end

  // rd_dat_o
  always @(posedge clk ) begin
    if( rd_val_i ) begin
        rd_dat_o <= mem_array[adr_i] ;
    end
    // synthesis translate_off
    else if( KNOB_RNDOUT == 'd1 ) begin
      `ifdef SIM_EVAL_TOP
        rd_dat_o <= $random( `SIM_EVAL_TOP.sim_dat_seed );
      `else
        rd_dat_o <= $random ;
      `endif
    end
    // synthesis translate_on
    else begin
        rd_dat_o <= 'dx ;
    end
  end


//*** DEBUG ********************************************************************

  // log size
  initial begin
    #1 ;
    $display( "\t calling sram_sp_behave (%0dx%0d) @%m" ,SIZE ,DATA_WD );
  end

  // sanity check
  initial begin
    #1 ;
    if( SIZE < 'd32 ) begin
      $display( "\n\t SRAM WARNING: size of %m is too small! \n" );
    end
  end

  // sanity check
  initial begin
    #1 ;
    if( KNOB_RNDOUT == -'sd1 ) begin
      $display( "\n\t SRAM ERROR: KNOB_RNDOUT in %m is not configured! \n" );
      #1000 ;
      $finish ;
    end
  end

endmodule
