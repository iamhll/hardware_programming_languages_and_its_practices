//--------------------------------------------
//      INC
//--------------------------------------------
+incdir+$ENV_CSTR_DIR_PRJ/include


//--------------------------------------------
//      LIB
//--------------------------------------------
$ENV_CSTR_DIR_PRJ/source/common/uart/uart_rx_with_apb.v
$ENV_CSTR_DIR_PRJ/source/common/uart/uart_tx_with_apb.v
$ENV_CSTR_DIR_PRJ/source/common/uart/apb2reg.v
$ENV_CSTR_DIR_PRJ/source/common/uart/uart_reg.v
$ENV_CSTR_DIR_PRJ/source/common/uart/uart_rx.v
$ENV_CSTR_DIR_PRJ/source/common/uart/uart_tx.v
$ENV_CSTR_DIR_PRJ/source/common/fifo_sc_ew_ack_reg_based.v
$ENV_CSTR_DIR_PRJ/source/common/sram_tp_reg_based.v


//--------------------------------------------
//      SIM
//--------------------------------------------
./sim_uart.v
