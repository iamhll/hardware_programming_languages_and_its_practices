//------------------------------------------------------------------------------
  //
  //  Filename       : divide.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : divide
  //
//------------------------------------------------------------------------------

`include "define.vh"

module divide_pipeline(
    clk         ,
    rstn        ,
    val_i       ,
    dat_a_i     ,
    dat_b_i     ,
    val_o       ,
    dat_c_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  localparam    NUMB_ITR           = 'd12       ;
  localparam    DATA_WD            = 'd8        ;
  localparam    DATA_INN_WD        = 'd24       ;
  localparam    DATA_2             = 'd2
                                  << DATA_INN_WD ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                            clk          ;
  input                            rstn         ;

  // input
  input                            val_i        ;
  input      [DATA_WD    -1 :0]    dat_a_i      ;
  input      [DATA_WD    -1 :0]    dat_b_i      ;

  // output
  output reg                       val_o        ;
  output reg [DATA_WD*2  -1 :0]    dat_c_o      ;


//*** WIRE/REG DECLARATION *****************************************************

  // output
  wire       [DATA_WD
             +DATA_INN_WD-1 :0]    dat_c_full_w ;
  wire       [DATA_INN_WD-1 :0]    dat_t_w      [NUMB_ITR-1 :0];
  wire       [DATA_WD    -1 :0]    dat_b_w      [NUMB_ITR-1 :0];
  wire       [DATA_WD
             +DATA_INN_WD-1 :0]    dat_j_full_w [NUMB_ITR-1 :0];
  wire       [1
             +DATA_INN_WD-1 :0]    dat_j_w      [NUMB_ITR-1 :0];
  wire       [1
             +DATA_INN_WD-1 :0]    dat_k_w      [NUMB_ITR-1 :0];
  wire       [1
             +DATA_INN_WD
             +DATA_INN_WD-1 :0]    dat_t_full_w [NUMB_ITR-1 :0];
  wire       [DATA_INN_WD-1 :0]    dat_t_nxt_w  [NUMB_ITR-1 :0];
  reg                              val_r        [NUMB_ITR-1 :0];
  reg        [DATA_WD    -1 :0]    dat_a_r      [NUMB_ITR-1 :0];
  reg        [DATA_WD    -1 :0]    dat_b_r      [NUMB_ITR-1 :0];
  reg        [DATA_INN_WD-1 :0]    dat_t_r      [NUMB_ITR-1 :0];

  genvar                           gvIdx        ;


//*** MAIN BODY ****************************************************************
//--- OUTPUT ---------------------------
  // val_o, dat_c_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o   <= 'd0 ;
      dat_c_o <= 'd0 ;
    end
    else begin
        val_o   <= val_r[NUMB_ITR-1] ;
      if( val_r[NUMB_ITR-1] ) begin
      //I8F8       I8F24
        dat_c_o <= ((dat_c_full_w >> 'd15) + 'd1) >> 'd1 ;
      end
    end
  end

  // dat_c_full_w
  //     I8F24          I8F0                  I0F24
  assign dat_c_full_w = dat_a_r[NUMB_ITR-1] * dat_t_r[NUMB_ITR-1] ;

  // pipe
  generate
    for( gvIdx = 'd0 ;gvIdx < NUMB_ITR ;gvIdx = gvIdx + 'd1 ) begin
      // dat_t_w, dat_b_w
      if( gvIdx == 'd0 ) begin
        assign dat_t_w[gvIdx] = 'd1 << (DATA_INN_WD - DATA_WD) ;
        assign dat_b_w[gvIdx] = dat_b_i ;
      end
      else begin
        assign dat_t_w[gvIdx] = dat_t_r[gvIdx-1] ;
        assign dat_b_w[gvIdx] = dat_b_r[gvIdx-1] ;
      end

      // dat_j_full_w, dat_j_w, dat_k_w, dat_t_full_w, dat_t_nxt_w
      //     I8F24                 I8F0             I0F24
      assign dat_j_full_w[gvIdx] = dat_b_w[gvIdx] * dat_t_w[gvIdx] ;
      //     I1F24            I8F24
      assign dat_j_w[gvIdx] = dat_j_full_w[gvIdx] ;
      //     I1F24            I2F24    I1F24
      assign dat_k_w[gvIdx] = DATA_2 - dat_j_w[gvIdx] ;
      //     I1F48                 I0F24            I1F24
      assign dat_t_full_w[gvIdx] = dat_t_w[gvIdx] * dat_k_w[gvIdx] ;
      //     I0F24            I1F48
      assign dat_t_nxt_w[gvIdx] = ((dat_t_full_w[gvIdx] >> 'd23) + 'd1) >> 'd1 ;

      // val_r, dat_a_r, dat_b_r, dat_t_r
      if( gvIdx == 'd0 ) begin
        always @(posedge clk or negedge rstn ) begin
          if( !rstn ) begin
            val_r  [gvIdx] <= 'd0 ;
            dat_a_r[gvIdx] <= 'd0 ;
            dat_b_r[gvIdx] <= 'd0 ;
            dat_t_r[gvIdx] <= 'd0 ;
          end
          else begin
              val_r  [gvIdx] <= val_i ;
            if( val_i ) begin
              dat_a_r[gvIdx] <= dat_a_i ;
              dat_b_r[gvIdx] <= dat_b_i ;
              dat_t_r[gvIdx] <= dat_t_nxt_w[gvIdx] ;
            end
          end
        end
      end
      else begin
        always @(posedge clk or negedge rstn ) begin
          if( !rstn ) begin
            val_r  [gvIdx] <= 'd0 ;
            dat_a_r[gvIdx] <= 'd0 ;
            dat_b_r[gvIdx] <= 'd0 ;
            dat_t_r[gvIdx] <= 'd0 ;
          end
          else begin
              val_r  [gvIdx] <= val_r      [gvIdx-1] ;
            if( val_r[gvIdx-1] ) begin
              dat_a_r[gvIdx] <= dat_a_r    [gvIdx-1] ;
              dat_b_r[gvIdx] <= dat_b_r    [gvIdx-1] ;
              dat_t_r[gvIdx] <= dat_t_nxt_w[gvIdx  ] ;
            end
          end
        end
      end
    end
  endgenerate


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

    wire dbg_val_w ;
    assign dbg_val_w = val_r[0] ;

  `endif

endmodule
