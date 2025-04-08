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

module divide_iteration(
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

  // derived
  localparam    NUMB_ITR_WD        = `FUNC_LOG2( NUMB_ITR );


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
  wire       [DATA_INN_WD-1 :0]    dat_t_w      ;
  wire       [DATA_WD
             +DATA_INN_WD-1 :0]    dat_j_full_w ;
  wire       [1
             +DATA_INN_WD-1 :0]    dat_j_w      ;
  wire       [1
             +DATA_INN_WD-1 :0]    dat_k_w      ;
  wire       [1
             +DATA_INN_WD
             +DATA_INN_WD-1 :0]    dat_t_full_w ;
  wire       [DATA_INN_WD-1 :0]    dat_t_nxt_w  ;
  reg        [DATA_INN_WD-1 :0]    dat_t_r      ;

  reg                              val_r        ;
  reg        [NUMB_ITR_WD-1 :0]    cnt_r        ;


//*** MAIN BODY ****************************************************************
//--- OUTPUT ---------------------------
  // val_o, dat_c_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o   <= 'd0 ;
      dat_c_o <= 'd0 ;
    end
    else begin
        val_o   <= val_r ;
      if( val_r ) begin
      //I8F8       I8F24
        dat_c_o <= ((dat_c_full_w >> 'd15) + 'd1) >> 'd1 ;
      end
    end
  end

  // dat_c_full_w
  //     I8F24          I8F0      I0F24
  assign dat_c_full_w = dat_a_i * dat_t_r ;

  // dat_t_w
  assign dat_t_w = ( cnt_r == 'd0 )
                 ? ( 'd1 << (DATA_INN_WD - DATA_WD) )
                 : dat_t_r
  ;

  // dat_j_full_w
  //     I8F24          I8F0    * I0F24
  assign dat_j_full_w = dat_b_i * dat_t_w ;
  //     I1F24     I8F24
  assign dat_j_w = dat_j_full_w ;
  //     I1F24     I2F24    I1F24
  assign dat_k_w = DATA_2 - dat_j_w ;
  //     I1F48          I0F24     I1F24
  assign dat_t_full_w = dat_t_w * dat_k_w ;
  //     I0F24     I1F48
  assign dat_t_nxt_w = ((dat_t_full_w >> 'd23) + 'd1) >> 'd1 ;

  // dat_t_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      dat_t_r <= 'd0 ;
    end
    else begin
      if( val_i || cnt_r!='d0 ) begin
        dat_t_r <= dat_t_nxt_w ;
      end
    end
  end

  // cnt_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_r <= 'd0 ;
      cnt_r <= 'd0 ;
    end
    else begin
          val_r <= cnt_done_w ;
      if( val_i || cnt_r!='d0 ) begin
        if( cnt_done_w ) begin
          cnt_r <= 'd0 ;
        end
        else begin
          cnt_r <= cnt_r + 'd1 ;
        end
      end
    end
  end

  // cnt_done_w
  assign cnt_done_w = cnt_r == NUMB_ITR-1 ;


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
