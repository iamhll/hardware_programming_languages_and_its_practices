//------------------------------------------------------------------------------
  //
  //  Filename       : fifo_sc_ew_req_reg_based.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : register-based fifo
  //
//------------------------------------------------------------------------------

`include "define.vh"

module fifo_sc_ew_req_reg_based(
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
  parameter    KNOB_LOG          = -1                 ;

  parameter    SIZE              = -1                 ;

  parameter    DATA_WD           = -1                 ;

  parameter    NAME_LOG_INP      = -1                 ;
  parameter    NAME_LOG_OUT      = -1                 ;

  // derived
  localparam   SIZE_WD           = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                          clk                  ;
  input                          rstn                 ;

  // write
  input                          wr_val_i             ;
  input      [DATA_WD  -1 :0]    wr_dat_i             ;
  output                         wr_ful_o             ;

  // read
  input                          rd_val_i             ;
  output                         rd_val_o             ;
  output     [DATA_WD  -1 :0]    rd_dat_o             ;
  output                         rd_ept_o             ;

  // common
  output reg [SIZE_WD+1-1 :0]    wd_usd_o             ;


//*** WIRE/REG DECLARATION *****************************************************

  // write
  reg        [SIZE_WD  -1 :0]    wr_adr_r             ;

  // read
  reg        [SIZE_WD  -1 :0]    rd_adr_r             ;


//*** MAIN BODY ****************************************************************
//--- WRITE ----------------------------
  // wr_ful_o
  assign wr_ful_o = wd_usd_o == SIZE ;

  // wr_adr_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      wr_adr_r <= 'd0 ;
    end
    else if( wr_val_i ) begin
      if( wr_adr_r == SIZE - 'd1 ) begin
        wr_adr_r <= 'd0 ;
      end
      else begin
        wr_adr_r <= wr_adr_r + 'd1 ;
      end
    end
  end


//--- READ -----------------------------
  // rd_ept_o
  assign rd_ept_o = wd_usd_o == 'd0 ;

  // rd_adr_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      rd_adr_r <= 'd0 ;
    end
    else if( rd_val_i ) begin
      if( rd_adr_r == SIZE - 'd1 ) begin
        rd_adr_r <= 'd0 ;
      end
      else begin
        rd_adr_r <= rd_adr_r + 'd1 ;
      end
    end
  end


//--- COMMON ---------------------------
  // wd_usd_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      wd_usd_o <= 'd0 ;
    end
    else if( wr_val_i && rd_val_i ) begin
      wd_usd_o <= wd_usd_o ;
    end
    else if( wr_val_i ) begin
      if( wd_usd_o == SIZE ) begin    // full error
        wd_usd_o <= wd_usd_o ;
      end
      else begin
        wd_usd_o <= wd_usd_o + 'd1 ;
      end
    end
    else if( rd_val_i ) begin
      if( wd_usd_o == 'd0 ) begin    // empty error
        wd_usd_o <= wd_usd_o ;
      end
      else begin
        wd_usd_o <= wd_usd_o - 'd1 ;
      end
    end
  end


//--- REG ARRAY ------------------------
  // sram_tp_reg_based
  sram_tp_reg_based #(
    .KNOB_REGOUT    ( 'd0         ),
    .SIZE           ( SIZE        ),
    .DATA_WD        ( DATA_WD     )
  ) sram_tp_reg_based(
    .clk            ( clk         ),
    .rstn           ( rstn        ),
    .wr_val_i       ( wr_val_i    ),
    .wr_adr_i       ( wr_adr_r    ),
    .wr_dat_i       ( wr_dat_i    ),
    .rd_val_i       ( rd_val_i    ),
    .rd_val_o       ( rd_val_o    ),
    .rd_adr_i       ( rd_adr_r    ),
    .rd_dat_o       ( rd_dat_o    )
  );


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
