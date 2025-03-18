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

module divide(
    dat_a_i     ,
    dat_b_i     ,
    dat_c_o
);


//*** PARAMETER DECLARATION ****************************************************

  // global
  localparam    NUMB_ITR         = 'd12         ;
  localparam    DATA_WD          = 'd8          ;
  localparam    DATA_INN_WD      = 'd24         ;
  localparam    DATA_2           = 'd2
                                << DATA_INN_WD  ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // input
  input      [DATA_WD    -1 :0]    dat_a_i      ;
  input      [DATA_WD    -1 :0]    dat_b_i      ;

  // output
  output     [DATA_WD*2  -1 :0]    dat_c_o      ;


//*** WIRE/REG DECLARATION *****************************************************

  // output
  wire       [DATA_WD
             +DATA_INN_WD-1 :0]    dat_c_full_w ;
  reg        [DATA_INN_WD-1 :0]    dat_t_w      ;
  reg        [DATA_WD
             +DATA_INN_WD-1 :0]    dat_j_full_w ;
  reg        [1
             +DATA_INN_WD-1 :0]    dat_j_w      ;
  reg        [1
             +DATA_INN_WD-1 :0]    dat_k_w      ;
  reg        [1
             +DATA_INN_WD
             +DATA_INN_WD-1 :0]    dat_t_full_w ;

  integer                          lpIdx        ;


//*** MAIN BODY ****************************************************************
//--- OUTPUT ---------------------------
  // dat_c_o
  //     I8F8      I8F24
  assign dat_c_o = ((dat_c_full_w >> 'd15) + 'd1) >> 'd1 ;

  // dat_c_full_w
  //     I8F24          I8F0      I0F24
  assign dat_c_full_w = dat_a_i * dat_t_w ;

  // dat_t_w
  always @(*) begin
      dat_t_w = 'd1 << (DATA_INN_WD - DATA_WD);
    for( lpIdx = 'd0 ;lpIdx < NUMB_ITR ;lpIdx = lpIdx + 'd1 ) begin
    //I8F24          I8F0    * I0F24
      dat_j_full_w = dat_b_i * dat_t_w ;
    //I1F24     I8F24
      dat_j_w = dat_j_full_w ;
    //I1F24     I2F24    I1F24
      dat_k_w = DATA_2 - dat_j_w ;
    //I1F48          I0F24     I1F24
      dat_t_full_w = dat_t_w * dat_k_w ;
    //I0F24     I1F48
      dat_t_w = ((dat_t_full_w >> 'd23) + 'd1) >> 'd1 ;
      #0.1 ;
    end
  end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
