//------------------------------------------------------------------------------
  //
  //  Filename       : fifo_req_duplex_sp_sram_based.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : sp-sram-based-duplex fifo
  //
//------------------------------------------------------------------------------

`include "define.vh"

module fifo_req_duplex_sp_sram_based(
  // global
  clk         ,
  rstn        ,
  // write
  wr_val_i    ,
  wr_dat_i    ,
  wr_ful_o    ,
  // read
  rd_val_i    ,
  rd_val_o    ,
  rd_dat_o    ,
  rd_ept_o    ,
  // common
  wd_usd_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  parameter    KNOB_LOG                = -1                 ;

  parameter    SIZE                    = -1                 ;

  parameter    DATA_WD                 = -1                 ;

  parameter    NAME_LOG_INP            = -1                 ;
  parameter    NAME_LOG_OUT            = -1                 ;

  // local

  // derived
  localparam   SIZE_WD                 = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                                clk                  ;
  input                                rstn                 ;

  // write
  input                                wr_val_i             ;
  input      [DATA_WD        -1 :0]    wr_dat_i             ;
  output                               wr_ful_o             ;

  // read
  input                                rd_val_i             ;
  output reg                           rd_val_o             ;
  output     [DATA_WD        -1 :0]    rd_dat_o             ;
  output                               rd_ept_o             ;

  // common
  output     [SIZE_WD+1      -1 :0]    wd_usd_o             ;


//*** WIRE/REG DECLARATION *****************************************************


//*** MAIN BODY ****************************************************************


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

    // access log
    integer tp_log   ;
    integer fp_log_i ;
    integer fp_log_o ;

    initial begin
      if( KNOB_LOG == 'd1 ) begin
        fp_log_i = $fopen( NAME_LOG_INP ,"w" );
        fp_log_o = $fopen( NAME_LOG_OUT ,"w" );
      end
    end

    // write log
    initial begin
      if( KNOB_LOG == 'd1 ) begin
        @(posedge rstn );
        forever begin
          @(posedge clk );
          if( wr_val_i ) begin
            $fdisplay( fp_log_i ,"%x" ,wr_dat_i );
          end
        end
      end
    end

    // read log
    initial begin
      if( KNOB_LOG == 'd1 ) begin
        @(posedge rstn );
        forever begin
          @(posedge clk );
          if( rd_val_o ) begin
            $fdisplay( fp_log_o ,"%x" ,rd_dat_o );
          end
        end
      end
    end

    // write full check
    initial begin
      @(posedge rstn );
      forever begin
        @(posedge clk );
        if( wr_val_i && wr_ful_o ) begin
          $display( "\n\t COMMON_FIFO ERROR: at %08d ns, write full happens in %m!\n" ,$time );
          #1000 ;
          $finish ;
        end
      end
    end

    // read empty check
    initial begin
      @(posedge rstn );
      forever begin
        @(posedge clk );
        if( rd_val_i && rd_ept_o ) begin
          $display( "\n\t COMMON_FIFO ERROR: at %08d ns, read empty happens in %m!\n" ,$time );
          #1000 ;
          $finish ;
        end
      end
    end

  `endif

endmodule
