//------------------------------------------------------------------------------
  //
  //  Filename       : define_uart.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [definition] of [uart]
  //
//------------------------------------------------------------------------------

`include "define.vh"

`define APB_ADDR_WD                 'd32
`define APB_DATA_WD                 'd32

`define UART_NUMB_REG               'd5
`define UART_NUMB_REG_WD            `FUNC_LOG2( `UART_NUMB_REG )
`define UART_DATA_REG_WD            `APB_DATA_WD
`define UART_NUMB_DIV_CLK_WD        `UART_DATA_REG_WD
`define UART_NUMB_BIT_MAX           'd8
`define UART_NUMB_BIT_WD            `FUNC_LOG2( `UART_NUMB_BIT_MAX )
`define UART_ENUM_PARITY_WD         'd3
  `define UART_ENUM_PARITY_NONE       3'd0
  `define UART_ENUM_PARITY_ODD        3'd1
  `define UART_ENUM_PARITY_EVEN       3'd2
  `define UART_ENUM_PARITY_MARK       3'd3
  `define UART_ENUM_PARITY_SPACE      3'd4
`define UART_SIZE_STOP_MAX          'd4
`define UART_SIZE_STOP_WD           `FUNC_LOG2( `UART_SIZE_STOP_MAX )
`define UART_SIZE_FIFO              'd128
`define UART_SIZE_FIFO_WD           `FUNC_LOG2( `UART_SIZE_FIFO )
`define UART_NUMB_TICK_WD           `UART_SIZE_STOP_WD

`define UART_CFG_DATA_DIV_CLK       'd0
`define UART_CFG_NUMB_BIT           'd1
`define UART_CFG_ENUM_PARITY        'd2
`define UART_CFG_SIZE_STOP          'd3
`define UART_CFG_DATA               'd4
`define UART_FDB_DATA               'd4
`define UART_FDB_NUMB_DAT           'd5
`define UART_FDB_FLAG_READY         'd6
