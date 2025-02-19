//------------------------------------------------------------------------------
  //
  //  Filename       : uart_tx.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : uart_tx
  //
//------------------------------------------------------------------------------

`include "define_uart.vh"

module uart_tx(
  // global
  clk                  ,
  rstn                 ,
  // cfg_i
  cfg_num_div_clk_i    ,
  cfg_num_bit_i        ,
  cfg_enm_parity_i     ,
  cfg_siz_stop_i       ,
  // dat_i
  val_i                ,
  dat_i                ,
  // dat_o
  uart_tx_o            ,
  // status_o
  ready_o
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
  input      [`UART_SIZE_STOP_WD   -1: 0]    cfg_siz_stop_i     ;

  // dat_i
  input                                      val_i              ;
  input      [`UART_NUMB_BIT_MAX   -1: 0]    dat_i              ;

  // dat_o
  output reg                                 uart_tx_o          ;

  // status_o
  output                                     ready_o            ;


//*** WIRE/REG DECLARATION *****************************************************

  // input
  reg        [`UART_NUMB_BIT_MAX   -1: 0]    dat_r              ;
  reg                                        dat_parity_w       ;

  // fsm
  reg        [FSM_WD               -1 :0]    cur_state_r        ;
  reg        [FSM_WD               -1 :0]    nxt_state_w        ;

  wire                                       flg_switch_w       ;

  reg        [`UART_NUMB_DIV_CLK_WD-1 :0]    cnt_div_clk_r      ;
  wire                                       cnt_div_clk_done_w ;
  reg        [`UART_NUMB_TICK_WD   -1 :0]    cnt_tick_r         ;
  reg                                        cnt_tick_done_w    ;
  reg        [`UART_NUMB_BIT_WD    -1: 0]    cnt_bit_r          ;
  wire                                       cnt_bit_done_w     ;

  // output
  reg                                        uart_change_r      ;


//*** MAIN BODY ****************************************************************
//--- INPUT ----------------------------
  // dat_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      dat_r <= 'd0 ;
    end
    else begin
      if( val_i ) begin
        dat_r <= dat_i ;
      end
    end
  end

  // dat_parity_w
  always @(*) begin
                                   dat_parity_w =  'd0    ;
    case( cfg_enm_parity_i )
      `UART_ENUM_PARITY_NONE  :    dat_parity_w =  'd0    ;
      `UART_ENUM_PARITY_ODD   :    dat_parity_w =  ^dat_r ;
      `UART_ENUM_PARITY_EVEN  :    dat_parity_w = ~^dat_r ;
      `UART_ENUM_PARITY_MARK  :    dat_parity_w =  'd1    ;
      `UART_ENUM_PARITY_SPACE :    dat_parity_w =  'd0    ;
    endcase
  end


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
      IDLE   : begin    if( val_i )           nxt_state_w = START  ;
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
      STOP   : begin    if( flg_switch_w )    nxt_state_w = IDLE   ;
                        else                  nxt_state_w = STOP   ;
      end
    endcase
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
      START  :    cnt_tick_done_w = cnt_tick_r == 'd2 - 'd1       ;
      DATA   :    cnt_tick_done_w = cnt_tick_r == 'd2 - 'd1       ;
      PARITY :    cnt_tick_done_w = cnt_tick_r == 'd2 - 'd1       ;
      STOP   :    cnt_tick_done_w = cnt_tick_r ==  cfg_siz_stop_i ;
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
  // uart_tx_o
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      uart_tx_o <= 'd1 ;
    end
    else begin
      if( uart_change_r ) begin
        case( cur_state_r )
          START  :    uart_tx_o <= 'b0               ;
          DATA   :    uart_tx_o <=  dat_r[cnt_bit_r] ;
          PARITY :    uart_tx_o <=  dat_parity_w     ;
          STOP   :    uart_tx_o <= 'b1               ;
        endcase
      end
    end
  end

  // uart_change_r
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      uart_change_r <= 'd0 ;
    end
    else begin
      uart_change_r <= val_i || flg_switch_w ;
    end
  end


//--- OUTPUT (STATUS_O) ----------------
  // ready_o
  assign ready_o = cur_state_r == IDLE ;


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG

  `endif

endmodule
