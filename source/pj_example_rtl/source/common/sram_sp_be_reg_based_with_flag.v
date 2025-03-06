//------------------------------------------------------------------------------
  //
  //  Filename       : sram_sp_be_reg_based_with_flag.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : register-based single-port sram (bit enable)
  //
//------------------------------------------------------------------------------

// NOTE: do remember update this file once sram_sp_be_reg_based changes.

`include "define.vh"

module sram_sp_be_reg_based_with_flag(
  // global
  clk             ,
  rstn            ,
  // prev
  prev_start_i    ,
  // common
  adr_i           ,
  // write
  wr_val_i        ,
  wr_dat_i        ,
  // read
  rd_val_i        ,
  rd_val_o        ,
  rd_dat_o
);


//*** PARAMETER ****************************************************************

  // global
  parameter    KNOB_REGOUT              = -1                 ;

  parameter    SIZE                     = -1                 ;
  parameter    SIZE_COL                 = -1                 ;

  parameter    DATA_WD                  = -1                 ;

  // derived
  localparam   SIZE_WD                  = `FUNC_LOG2( SIZE ) ;

  localparam   UNWRITTEN                = 'd0                ;
  localparam   WRITTEN                  = 'd1                ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                                 clk                  ;
  input                                 rstn                 ;

  // prev
  input                                 prev_start_i         ;

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
  wire       [DATA_WD         -1 :0]    rd_dat_msk_w         ;

  // flag
  reg        [DATA_WD/SIZE_COL-1 :0]    flg_all_r[SIZE-1:0]  ;
  reg        [DATA_WD/SIZE_COL-1 :0]    flg_cur_r            ;

  // genvar
  genvar                                gvIdx                ;
  genvar                                gvIdxX               ;
  genvar                                gvIdxY               ;


//*** MAIN BODY ****************************************************************

  // mem_array
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
      rd_dat_r <= 'd0 ;
    end
    else if( rd_val_i ) begin
      rd_dat_r <= mem_array[adr_i] ;
    end
  end

  // flg_all_r
  generate
    for( gvIdxY = 'd0 ;gvIdxY < SIZE             ;gvIdxY = gvIdxY + 'd1 ) begin : flgAllX
      for( gvIdxX = 'd0 ;gvIdxX < DATA_WD/SIZE_COL ;gvIdxX = gvIdxX + 'd1 ) begin : flgAllY
        always @(posedge clk or negedge rstn ) begin
          if( !rstn ) begin
            flg_all_r[gvIdxY][gvIdxX] <= UNWRITTEN ;
          end
          else begin
            if( prev_start_i ) begin
              flg_all_r[gvIdxY][gvIdxX] <= UNWRITTEN ;
            end
            else if( (adr_i==gvIdxY) && wr_val_i[gvIdxX] ) begin
              flg_all_r[gvIdxY][gvIdxX] <= WRITTEN ;
            end
          end
        end
      end
    end
  endgenerate

  // flg_cur_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      flg_cur_r <= UNWRITTEN ;
    end
    else begin
      if( rd_val_i ) begin
        flg_cur_r <= flg_all_r[adr_i] ;
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
            rd_val_o <= rd_val_r     ;
          if( rd_val_r ) begin
            rd_dat_o <= rd_dat_msk_w ;
          end
        end
      end
    end
    else begin : disabRegOut
      always @(*) begin
        rd_val_o = rd_val_r     ;
        rd_dat_o = rd_dat_msk_w ;
      end
    end
  endgenerate

  // rd_dat_msk_w
  generate
    for( gvIdx = 'd0 ;gvIdx < DATA_WD/SIZE_COL ;gvIdx = gvIdx + 'd1 ) begin : rdDatMsk
      assign rd_dat_msk_w[SIZE_COL*(gvIdx+'d1)-'d1-:SIZE_COL] = ( flg_cur_r[gvIdx] == WRITTEN )
        ?        rd_dat_r[SIZE_COL*(gvIdx+'d1)-'d1-:SIZE_COL]
        :             'd0     // skip checkExpressionInSquareBracket
      ;
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
