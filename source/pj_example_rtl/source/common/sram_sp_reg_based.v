//------------------------------------------------------------------------------
  //
  //  Filename       : sram_sp_reg_based.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : register-based single-port sram
  //
//------------------------------------------------------------------------------

`include "define.vh"

module sram_sp_reg_based(
  // global
  clk         ,
  rstn        ,
  // common
  adr_i       ,
  // write
  wr_val_i    ,
  wr_dat_i    ,
  // read
  rd_val_i    ,
  rd_val_o    ,
  rd_dat_o
);


//*** PARAMETER ****************************************************************

  // global
  parameter    KNOB_REGOUT     = -1                 ;

  parameter    SIZE            = -1                 ;

  parameter    DATA_WD         = -1                 ;

  // derived
  localparam   SIZE_WD         = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                        clk                  ;
  input                        rstn                 ;

  // common
  input      [SIZE_WD-1 :0]    adr_i                ;

  // write
  input                        wr_val_i             ;
  input      [DATA_WD-1 :0]    wr_dat_i             ;

  // read
  input                        rd_val_i             ;
  output reg                   rd_val_o             ;
  output reg [DATA_WD-1 :0]    rd_dat_o             ;


//*** WIRE/REG *****************************************************************

  reg        [DATA_WD-1 :0]    mem_array[SIZE-1 :0] ;

  reg                          rd_val_r             ;
  reg        [DATA_WD-1 :0]    rd_dat_r             ;


//*** MAIN BODY ****************************************************************

  // mem_array
  always @(posedge clk ) begin
    if( wr_val_i ) begin
      mem_array[adr_i] <= wr_dat_i ;
    end
  end

  // rd_val_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      rd_val_r <= 'd0 ;
    end
    else begin
      rd_val_r <= rd_val_i ;
    end
  end

  // rd_dat_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      rd_dat_r <= 'd0 ;
    end
    else if( rd_val_i ) begin
      rd_dat_r <= mem_array[adr_i] ;
    end
  end

  // rd_val/dat_o
  generate
    if( KNOB_REGOUT == 'd1 ) begin : enabRegOut
      always @(posedge clk or negedge rstn ) begin
        if( !rstn ) begin
          rd_val_o <= 'd0 ;
          rd_dat_o <= 'd0 ;
        end
        else begin
            rd_val_o <= rd_val_r ;
          if( rd_val_r ) begin
            rd_dat_o <= rd_dat_r ;
          end
        end
      end
    end
    else begin : disabRegOut
      always @(*) begin
        rd_val_o = rd_val_r ;
        rd_dat_o = rd_dat_r ;
      end
    end
  endgenerate


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

    // sanity check
    initial begin
      wait( rstn );
      if( SIZE > 'd32 ) begin
        $display( "\n\t COMMON_SRAM WARNING: size (%1d) of %m is too large! \n" ,SIZE );
      end
    end

    // sanity check
    initial begin
      wait( rstn );
      if( KNOB_REGOUT == -'d1 ) begin
        $display( "\n\t COMMON_SRAM ERROR: KNOB_REGOUT in %m is not configured! \n" );
        #1000 ;
        $finish ;
      end
    end

  `endif

endmodule
