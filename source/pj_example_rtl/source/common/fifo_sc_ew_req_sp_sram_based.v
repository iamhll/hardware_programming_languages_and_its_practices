//------------------------------------------------------------------------------
  //
  //  Filename       : fifo_sc_ew_req_sp_sram_based.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : sp-sram-based fifo
  //
//------------------------------------------------------------------------------

`include "define.vh"

module fifo_sc_ew_req_sp_sram_based(
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
  localparam   OUTER_SIZE              = 'd3                ;

  // derived
  localparam   INNER_SIZE              = SIZE / 'd2         ;
  localparam   INNER_DATA_WD           = DATA_WD * 'd2      ;

  localparam   OUTER_DATA_WD           = DATA_WD            ;

  localparam   SIZE_WD                 = `FUNC_LOG2( SIZE ) ;
  localparam   INNER_SIZE_WD           = `FUNC_LOG2( INNER_SIZE ) ;
  localparam   OUTER_SIZE_WD           = `FUNC_LOG2( OUTER_SIZE ) ;


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

  // write
  reg        [OUTER_DATA_WD  -1 :0]    outer_wr_dat_0_r     ;
  reg        [OUTER_DATA_WD  -1 :0]    outer_wr_dat_1_r     ;
  reg        [OUTER_DATA_WD  -1 :0]    outer_wr_dat_2_r     ;

  wire                                 inner_wr_val_i_w     ;
  wire       [INNER_DATA_WD  -1 :0]    inner_wr_dat_i_w     ;

  // read
  wire                                 inner_rd_val_i_w     ;
  wire                                 outer_rd_val_i_w     ;
  reg                                  inner_rd_flg_o_r     ;
  reg                                  inner_rd_flg_o_rr    ;
  // !!!      this is not a typo
  reg        [OUTER_DATA_WD  -1 :0]    inner_rd_dat_o_r     ;
  reg        [OUTER_DATA_WD  -1 :0]    outer_rd_dat_o_r     ;

  // common
  reg        [OUTER_SIZE_WD  -1 :0]    outer_wd_usd_r       ;

  // inner simplex fifo
//wire                                 inner_wr_val_i_w     ;
//wire       [INNER_DATA_WD  -1 :0]    inner_wr_dat_i_w     ;
//wire                                 inner_rd_val_i_w     ;
  wire                                 inner_rd_val_o_w     ;
  wire       [INNER_DATA_WD  -1 :0]    inner_rd_dat_o_w     ;
  wire       [INNER_SIZE_WD+1-1 :0]    inner_wd_usd_o_w     ;


//*** MAIN BODY ****************************************************************
//--- WRITE ----------------------------
  // wr_ful_o
  assign wr_ful_o = wd_usd_o >= SIZE ;

  // outer_wr_dat_0_r, outer_wr_dat_1_r, outer_wr_dat_2_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      outer_wr_dat_0_r <= 'd0 ;
      outer_wr_dat_1_r <= 'd0 ;
      outer_wr_dat_2_r <= 'd0 ;
    end
    else begin
      if( wr_val_i ) begin
        case( outer_wd_usd_r )
          'd0 :    outer_wr_dat_0_r <= wr_dat_i ;
          'd1 : begin
            if( outer_rd_val_i_w ) begin
                   outer_wr_dat_0_r <= wr_dat_i ;
            end
            else begin
                   outer_wr_dat_1_r <= wr_dat_i ;
            end
          end
          'd2 : begin
            if( inner_wr_val_i_w ) begin
                   outer_wr_dat_0_r <= wr_dat_i ;
            end
            else if( outer_rd_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_1_r ;
                   outer_wr_dat_1_r <= wr_dat_i ;
            end
            else begin
                   outer_wr_dat_2_r <= wr_dat_i ;
            end
          end
          'd3 : begin
            if( inner_wr_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_2_r ;
                   outer_wr_dat_1_r <= wr_dat_i ;
            end
            else if( outer_rd_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_1_r ;
                   outer_wr_dat_1_r <= outer_wr_dat_2_r ;
                   outer_wr_dat_2_r <= wr_dat_i ;
            end
          //else begin
          //       impossible
          //end
          end
        endcase
      end
      else begin
        case( outer_wd_usd_r )
        //'d0 :    do nothing
        //'d1 :    do nothing
          'd2 : begin
            if( outer_rd_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_1_r ;
            end
          //else begin
          //       do nothing
          //end
          end
          'd3 : begin
            if( inner_wr_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_2_r ;
            end
            else if( outer_rd_val_i_w ) begin
                   outer_wr_dat_0_r <= outer_wr_dat_1_r ;
                   outer_wr_dat_1_r <= outer_wr_dat_2_r ;
            end
          //else begin
          //       do nothing
          //end
          end
        endcase
      end
    end
  end

  // inner_wr_val_i_w
  assign inner_wr_val_i_w = ( outer_wd_usd_r   >= 'd2 )
                         && ( inner_rd_val_i_w == 'd0 )
                         && ( outer_rd_val_i_w == 'd0 )
  ;

  // inner_wr_dat_i_w
  assign inner_wr_dat_i_w = { outer_wr_dat_0_r ,outer_wr_dat_1_r };


//--- READ -----------------------------
  // rd_ept_o
  assign rd_ept_o = wd_usd_o == 'd0 ;

  // rd_val_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      rd_val_o <= 'd0 ;
    end
    else begin
      rd_val_o <= rd_val_i ;
    end
  end

  // rd_dat_o
  assign rd_dat_o = inner_rd_val_o_w  ? (inner_rd_dat_o_w>>DATA_WD)
                  : inner_rd_flg_o_rr ? inner_rd_dat_o_r
                  :                     outer_rd_dat_o_r
  ;

  // inner_rd_val_i_w
  assign inner_rd_val_i_w = rd_val_i && (inner_wd_usd_o_w> 'd0) && !inner_rd_flg_o_r       ;
  assign outer_rd_val_i_w = rd_val_i && (inner_wd_usd_o_w=='d0) && (inner_rd_flg_o_r=='d0) ;

  // inner_rd_flg_o_r, inner_rd_dat_o_r, inner_rd_flg_o_rr
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      inner_rd_flg_o_r  <= 'd0 ;
      inner_rd_dat_o_r  <= 'd0 ;
      inner_rd_flg_o_rr <= 'd0 ;
    end
    else begin
      if( inner_rd_val_i_w ) begin
        inner_rd_flg_o_r  <= 'd1 ;
      end
      else if( rd_val_i ) begin
        inner_rd_flg_o_r  <= 'd0 ;
      end
      if( inner_rd_val_o_w ) begin
        inner_rd_dat_o_r  <= inner_rd_dat_o_w ;
      end
        inner_rd_flg_o_rr <= inner_rd_flg_o_r ;
    end
  end

  // outer_rd_dat_o_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      outer_rd_dat_o_r <= 'd0 ;
    end
    else begin
      if( outer_rd_val_i_w ) begin
        outer_rd_dat_o_r <= outer_wr_dat_0_r ;
      end
    end
  end


//--- COMMON ---------------------------
  // wd_usd_o
  assign wd_usd_o = outer_wd_usd_r + inner_wd_usd_o_w*'d2 + inner_rd_flg_o_r ;

  // outer_wd_usd_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      outer_wd_usd_r <= 'd0 ;
    end
    else begin
      case( {wr_val_i,inner_wr_val_i_w,outer_rd_val_i_w} )
        3'b000 :    outer_wd_usd_r <= outer_wd_usd_r       ;
        3'b100 :    outer_wd_usd_r <= outer_wd_usd_r + 'd1 ;
        3'b010 :    outer_wd_usd_r <= outer_wd_usd_r - 'd2 ;
        3'b001 :    outer_wd_usd_r <= outer_wd_usd_r - 'd1 ;
        3'b110 :    outer_wd_usd_r <= outer_wd_usd_r - 'd1 ;
        3'b101 :    outer_wd_usd_r <= outer_wd_usd_r       ;
      //3'b011 :    impossible
      //3'b111 :    impossible
      endcase
    end
  end


//--- INNER SIMPLEX FIFO ---------------
  // fifo_sc_ew_req_reg_based
  fifo_sc_ew_req_reg_based #(
    .SIZE        ( INNER_SIZE          ),
    .DATA_WD     ( INNER_DATA_WD       )
  ) fifo_sc_ew_req_reg_based(
    // global
    .clk         ( clk                 ),
    .rstn        ( rstn                ),
    // write
    .wr_val_i    ( inner_wr_val_i_w    ),
    .wr_dat_i    ( inner_wr_dat_i_w    ),
    .wr_ful_o    ( inner_wr_ful_o_w    ),
    // read
    .rd_val_i    ( inner_rd_val_i_w    ),
    .rd_val_o    ( inner_rd_val_o_w    ),
    .rd_dat_o    ( inner_rd_dat_o_w    ),
    .rd_ept_o    ( inner_rd_ept_o_w    ),
    // common
    .wd_usd_o    ( inner_wd_usd_o_w    )
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
