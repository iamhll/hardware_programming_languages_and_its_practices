//------------------------------------------------------------------------------
  //
  //  Filename       : sram_tp_reg_based_multi_bank.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : register-based two-port sram (multi-bank)
  //
//------------------------------------------------------------------------------

`include "define.vh"

module sram_tp_reg_based_multi_bank(
  // global
  clk              ,
  rstn             ,
  // cfg_i
  cfg_idx_bnk_i    ,
  // write
  wr_val_i         ,
  wr_adr_i         ,
  wr_dat_i         ,
  // read
  rd_val_i         ,
  rd_adr_i         ,
  rd_val_o         ,
  rd_dat_o
);


//*** PARAMETER ****************************************************************

  // global
  parameter    KNOB_REGOUT          = -1                     ;

  parameter    NUMB_BNK             = -1                     ;

  parameter    SIZE                 = -1                     ;

  parameter    DATA_WD              = -1                     ;

  // local
  localparam   NUMB_BNK_WD          = `FUNC_LOG2( NUMB_BNK ) ;

  localparam   SIZE_WD              = `FUNC_LOG2( SIZE )     ;


//*** INPUT/OUTPUT *************************************************************

  // global
  input                             clk                      ;
  input                             rstn                     ;

  // cfg_i
  input  [NUMB_BNK_WD     -1 :0]    cfg_idx_bnk_i            ;

  // write
  input                             wr_val_i                 ;
  input  [SIZE_WD         -1 :0]    wr_adr_i                 ;
  input  [DATA_WD         -1 :0]    wr_dat_i                 ;

  // read
  input                             rd_val_i                 ;
  input  [SIZE_WD         -1 :0]    rd_adr_i                 ;
  output                            rd_val_o                 ;
  output [DATA_WD         -1 :0]    rd_dat_o                 ;


//*** WIRE/REG *****************************************************************

  // read
  wire   [DATA_WD*NUMB_BNK-1 :0]    rd_dat_ful_w             ;
  wire   [DATA_WD         -1 :0]    rd_dat_w                 ;

  // genvar
  genvar                            gvIdx                    ;


//*** MAIN BODY ****************************************************************
//--- RAM ------------------------------
  generate
    for( gvIdx = 'd0 ;gvIdx < NUMB_BNK ;gvIdx = gvIdx + 'd1 ) begin : rdDatFul
      // variables
      wire                   wr_val_w ;
      wire [SIZE_WD-1 :0]    wr_adr_w ;
      wire [DATA_WD-1 :0]    wr_dat_w ;
      wire                   rd_val_w ;
      wire [SIZE_WD-1 :0]    rd_adr_w ;

      // logic
      assign wr_val_w = (cfg_idx_bnk_i==gvIdx) ? wr_val_i : 'd0 ;
      assign wr_adr_w =                          wr_adr_i       ;
      assign wr_dat_w =                          wr_dat_i       ;
      assign rd_val_w = (cfg_idx_bnk_i==gvIdx) ? rd_val_i : 'd0 ;
      assign rd_adr_w =                          rd_adr_i       ;

      // instantiations
      sram_tp_reg_based #(
        .KNOB_REGOUT    ( 'd0             ),
        .SIZE           ( SIZE            ),
        .DATA_WD        ( DATA_WD         )
      ) sram_tp_reg_based(
        // global
        .clk            ( clk             ),
        .rstn           ( rstn            ),
        // common
        // write
        .wr_val_i       ( wr_val_w        ),
        .wr_adr_i       ( wr_adr_w        ),
        .wr_dat_i       ( wr_dat_w        ),
        // read
        .rd_val_i       ( rd_val_w        ),
        .rd_adr_i       ( rd_adr_w        ),
        .rd_val_o       ( /* UNUSED */    ),
        .rd_dat_o       ( rd_dat_ful_w[ DATA_WD*(NUMB_BNK-gvIdx)-'d1
                                      -:DATA_WD]
                                          )
      );
    end
  endgenerate

  assign rd_dat_w = rd_dat_ful_w[DATA_WD*(NUMB_BNK-cfg_idx_bnk_i)-'d1-:DATA_WD] ;


//--- OUTPUT ---------------------------
  generate
    if( KNOB_REGOUT == 'd1 ) begin : regOut
      // variables
      reg                   rd_val_d0_r ;
      reg                   rd_val_d1_r ;
      reg [DATA_WD-1 :0]    rd_dat_d1_r ;

      // logic
      assign rd_val_o = rd_val_d1_r ;
      assign rd_dat_o = rd_dat_d1_r ;
      always @(posedge clk or negedge rstn ) begin
        if( !rstn ) begin
          rd_val_d0_r <= 'd0 ;
          rd_val_d1_r <= 'd0 ;
          rd_dat_d1_r <= 'd0 ;
        end
        else begin
            rd_val_d0_r <= rd_val_i    ;
            rd_val_d1_r <= rd_val_d0_r ;
          if( rd_val_d0_r ) begin
            rd_dat_d1_r <= rd_dat_w    ;
          end
        end
      end
    end
    else begin : notRegOut
      // variables
      reg    rd_val_d0_r ;

      // logic
      assign rd_val_o = rd_val_d0_r ;
      assign rd_dat_o = rd_dat_w    ;
      always @(posedge clk or negedge rstn ) begin
        if( !rstn ) begin
          rd_val_d0_r <= 'd0 ;
        end
        else begin
          rd_val_d0_r <= rd_val_i ;
        end
      end
    end
  endgenerate


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

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
