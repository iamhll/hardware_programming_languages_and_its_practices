//------------------------------------------------------------------------------
  //
  //  Filename       : uart_rx.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : uart_rx
  //
//------------------------------------------------------------------------------

`include "define_uart.vh"

module uart_rx(
  // global
  clk                  ,
  rstn                 ,
  // cfg_i
  cfg_num_div_clk_i    ,
  cfg_num_bit_i        ,
  cfg_enm_parity_i     ,
  // dat_i
  uart_rx_i            ,
  // dat_o
  val_o                ,
  dat_o
);


//*** PARAMETER DECLARATION ****************************************************

  // local
  localparam   FSM_WD                        = 'd3              ;
  localparam   IDLE                          =   3'd0           ;
  localparam   START                         =   3'd1           ;
  localparam   DATA                          =   3'd2           ;
  localparam   PARITY                        =   3'd3           ;
  localparam   STOP                          =   3'd4           ;


//*** INPUT/OUTPUT DECLARATION *************************************************

  // global
  input                                      clk                ;
  input                                      rstn               ;

  // cfg_i
  input      [`UART_NUMB_DIV_CLK_WD-1: 0]    cfg_num_div_clk_i  ;
  input      [`UART_NUMB_BIT_WD    -1: 0]    cfg_num_bit_i      ;
  input      [`UART_ENUM_PARITY_WD -1: 0]    cfg_enm_parity_i   ;

  // dat_i
  input                                      uart_rx_i          ;

  // dat_o
  output reg                                 val_o              ;
  output reg [`UART_NUMB_BIT_MAX   -1: 0]    dat_o              ;


//*** WIRE/REG DECLARATION *****************************************************

  // fsm
  reg        [FSM_WD               -1 :0]    cur_state_r        ;
  reg        [FSM_WD               -1 :0]    nxt_state_w        ;

  wire                                       val_w              ;
  reg                                        uart_rx_d1_r       ;
  reg                                        uart_rx_d0_r       ;

  wire                                       flg_switch_w       ;

  reg        [`UART_NUMB_DIV_CLK_WD-1 :0]    cnt_div_clk_r      ;
  wire                                       cnt_div_clk_done_w ;
  reg        [`UART_NUMB_TICK_WD   -1 :0]    cnt_tick_r         ;
  reg                                        cnt_tick_done_w    ;
  reg        [`UART_NUMB_BIT_WD    -1: 0]    cnt_bit_r          ;
  wire                                       cnt_bit_done_w     ;

  // output
  reg                                        uart_sample_r      ;


//*** MAIN BODY ****************************************************************
//--- FSM ------------------------------
  // cur_state_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      cur_state_r <= IDLE ;
    end
    else begin
      cur_state_r <= nxt_state_w ;
    end
  end

  // nxt_state_w
  always @(*) begin
                                              nxt_state_w = IDLE   ;
    case( cur_state_r )
      IDLE   : begin    if( val_w )           nxt_state_w = START  ;
                        else                  nxt_state_w = IDLE   ;
      end
      START  : begin    if( flg_switch_w )    nxt_state_w = DATA   ;
                        else                  nxt_state_w = START  ;
      end
      DATA   : begin    if( flg_switch_w ) begin
                          if( cnt_bit_done_w ) begin
                            if( cfg_enm_parity_i == `UART_ENUM_PARITY_NONE ) begin
                                              nxt_state_w = STOP   ;
                            end
                            else begin        nxt_state_w = PARITY ;
                            end
                          end
                          else begin          nxt_state_w = DATA   ;
                          end
                        end
                        else begin            nxt_state_w = DATA   ;
                        end
      end
      PARITY : begin    if( flg_switch_w )    nxt_state_w = STOP   ;
                        else                  nxt_state_w = PARITY ;
      end
      STOP   : begin                          nxt_state_w = IDLE   ;
      end
    endcase
  end

  // val_w
  assign val_w = uart_rx_d1_r=='d0 ;
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      uart_rx_d0_r <= 'd1 ;
      uart_rx_d1_r <= 'd1 ;
    end
    else begin
      uart_rx_d0_r <= uart_rx_i    ;
      uart_rx_d1_r <= uart_rx_d0_r ;
    end
  end

  // flg_switch_w
  assign flg_switch_w = cnt_div_clk_done_w && cnt_tick_done_w ;


//--- COUNTER --------------------------
  // cnt_div_clk_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      cnt_div_clk_r <= 'd0 ;
    end
    else begin
      if( cur_state_r != IDLE ) begin
        if( cnt_div_clk_done_w ) begin
          cnt_div_clk_r <= 'd0 ;
        end
        else begin
          cnt_div_clk_r <= cnt_div_clk_r + 'd1 ;
        end
      end
    end
  end

  // cnt_div_clk_done_w
  assign cnt_div_clk_done_w = cnt_div_clk_r == cfg_num_div_clk_i ;

  // cnt_tick_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      cnt_tick_r <= 'd0 ;
    end
    else begin
      if( (cur_state_r!=IDLE) && cnt_div_clk_done_w ) begin
        if( cnt_tick_done_w ) begin
          cnt_tick_r <= 'd0 ;
        end
        else begin
          cnt_tick_r <= cnt_tick_r + 'd1 ;
        end
      end
    end
  end

  // cnt_tick_done_w
  always @(*) begin
                  cnt_tick_done_w = 'd0 ;
    case( cur_state_r )
      START  :    cnt_tick_done_w = cnt_tick_r == 'd3 - 'd1 ;
      DATA   :    cnt_tick_done_w = cnt_tick_r == 'd2 - 'd1 ;
      PARITY :    cnt_tick_done_w = cnt_tick_r == 'd2 - 'd1 ;
    endcase
  end


  // cnt_bit_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      cnt_bit_r <= 'd0 ;
    end
    else begin
      if( (cur_state_r==DATA) && cnt_div_clk_done_w && cnt_tick_done_w ) begin
        if( cnt_bit_done_w ) begin
          cnt_bit_r <= 'd0 ;
        end
        else begin
          cnt_bit_r <= cnt_bit_r + 'd1 ;
        end
      end
    end
  end

  // cnt_bit_done_w
  assign cnt_bit_done_w = cnt_bit_r == cfg_num_bit_i ;


//--- OUTPUT (DAT_O) -------------------
  // val_o, dat_o, dat_parity_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      val_o        <= 'd0 ;
      dat_o        <= 'd0 ;
    //dat_parity_r <= 'd0 ;
    end
    else begin
                      val_o            <= 'b0        ;
      if( uart_sample_r ) begin
        case( cur_state_r )
          DATA   :    dat_o[cnt_bit_r] <=  uart_rx_i ;
        //PARITY :    dat_parity_r     <=  uart_rx_i ;
          STOP   :    val_o            <= 'b1        ;
        endcase
      end
    end
  end

  // uart_change_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      uart_sample_r <= 'd0 ;
    end
    else begin
      uart_sample_r <= flg_switch_w ;
    end
  end


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

    initial begin
      forever begin
        @(negedge clk );
        if( (cur_state_r!=nxt_state_w) && (nxt_state_w==IDLE) ) begin
          $display( "UART_RX received [%c]" ,dat_o );
        end
      end
    end

  `endif

endmodule
