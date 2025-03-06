//------------------------------------------------------------------------------
  //
  //  Filename       : sram_sp_be_behave_sim.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [simulation model] for [single-port sram with bit enable]
  //
//------------------------------------------------------------------------------

`include "define.vh"

module sram_sp_be_behave_sim(
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
  parameter    KNOB_HLDOUT              = -1                 ;
  parameter    KNOB_RNDOUT              = -1                 ;
  parameter    KNOB_REGOUT              = -1                 ;

  parameter    SIZE                     = -1                 ;
  parameter    SIZE_COL                 = -1                 ;

  parameter    DATA_WD                  = -1                 ;

  // derived
  localparam   SIZE_WD                  = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                                 clk                  ;
  input                                 rstn                 ;

  // common
  input      [SIZE_WD         -1 :0]    adr_i                ;

  // write
  input      [DATA_WD/SIZE_COL-1 :0]    wr_val_i             ;
  input      [DATA_WD         -1 :0]    wr_dat_i             ;

  // read
  input                                 rd_val_i             ;
  output reg                            rd_val_o             ;
  output reg [DATA_WD         -1 :0]    rd_dat_o             ;


//*** WIRE/REG *****************************************************************

  // mem
  reg        [DATA_WD         -1 :0]    mem_array[SIZE-1 :0] ;

  // read
  reg                                   rd_val_r             ;
  reg        [DATA_WD         -1 :0]    rd_dat_r             ;

  // loop
  integer                               lpIdx                ;

  // genvar
  genvar                                gvIdx                ;


//*** MAIN BODY ****************************************************************

  // mem_array
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
  generate
    for( gvIdx = 'd0 ;gvIdx < DATA_WD/SIZE_COL ;gvIdx = gvIdx + 'd1 ) begin : memArray
      always @(posedge clk ) begin
        if( wr_val_i[gvIdx] ) begin
          mem_array[adr_i][SIZE_COL*(gvIdx+'d1)-'d1-:SIZE_COL]
               <= wr_dat_i[SIZE_COL*(gvIdx+'d1)-'d1-:SIZE_COL]
          ;
        end
      end
    end
  endgenerate

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
      if( KNOB_RNDOUT ) begin
        `ifdef SIM_EVAL_TOP
          rd_dat_r <= $random( `SIM_EVAL_TOP.sim_dat_seed );
        `else
          rd_dat_r <= $random ;
        `endif
      end
      else begin
          rd_dat_r <= 'dx ;
      end
    end
    else begin
      if( rd_val_i ) begin
          rd_dat_r <= mem_array[adr_i] ;
      end
      else if( KNOB_HLDOUT ) begin
          rd_dat_r <= rd_dat_r ;
      end
      else if( KNOB_RNDOUT ) begin
        `ifdef SIM_EVAL_TOP
          rd_dat_r <= $random( `SIM_EVAL_TOP.sim_dat_seed );
        `else
          rd_dat_r <= $random ;
        `endif
      end
      else begin
          rd_dat_r <= 'dx ;
      end
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
      if( KNOB_HLDOUT == -'sd1 ) begin
        $display( "\n\t SRAM ERROR: KNOB_HLDOUT in %m is not configured! \n" );
        #1000 ;
        $finish ;
      end
    end

    // sanity check
    initial begin
      wait( rstn );
      if( KNOB_RNDOUT == -'sd1 ) begin
        $display( "\n\t SRAM ERROR: KNOB_RNDOUT in %m is not configured! \n" );
        #1000 ;
        $finish ;
      end
    end

    // sanity check
    initial begin
      wait( rstn );
      if( KNOB_REGOUT == -'sd1 ) begin
        $display( "\n\t SRAM ERROR: KNOB_REGOUT in %m is not configured! \n" );
        #1000 ;
        $finish ;
      end
    end

  `endif

endmodule
