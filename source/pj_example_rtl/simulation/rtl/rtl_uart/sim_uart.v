//------------------------------------------------------------------------------
  //
  //  Filename       : sim_uart.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [testbench] for [uart]
  //
//------------------------------------------------------------------------------

//--- GLOBAL ---------------------------
  // SIM
  //`define SIM_EVAL_TOP               -1
  //`define SIM_CSTR_TOP               -1
  //`define SIM_KNOB_DBG               -1
  //`define SIM_CSTR_LEVEL_STOP        -1
  //`define SIM_DATA_SEED              -1
  //`define SIM_KNOB_WAVEFORM_SHM      -1
  //`define SIM_KNOB_WAVEFORM_FSDB     -1
  //`define SIM_KNOB_WAVEFORM_VCD      -1
  //`define SIM_DATA_WAVEFORM_TIME     -1
  //`define SIM_CSTR_WAVEFORM_LEVEL    -1

  // DUT
  //`define DUT_EVAL_TOP    -1
  //`define DUT_CSTR_TOP    -1
  //`include "check_data/dut_setting.vh"


//--- LOCAL (VARIABLE) -----------------
  // SIM
  `define SIM_KNOB_CHK            'b1
  `define SIM_KNOB_CHK_UART_DAT     'b1
  `ifdef  SIM_KNOB_DBG
  `define SIM_KNOB_CHK_XXX        `SIM_KNOB_DBG
  `endif
  `ifdef  SIM_KNOB_DBG
  `define SIM_KNOB_DBG_CALC
  `endif
  `define SIM_FLAG_DSP_REG        'b1
  //`define SIM_KNOB_WAVEFORM_EVCD

  // DUT
  `include "define_calc.vh"


//--- LOCAL (CONSTANT) -----------------
  // SIM
  `define SIM_DATA_PRD_CLK    10.000

  `define SIM_CSTR_FILE_INIT_XXX    "XXX"

  `define SIM_CSTR_FILE_CHKI_UART_DAT    "check_data/UART_dumpDatInp_S1I8F0.dat"

  `define SIM_CSTR_FILE_CHKI_XXX    "XXX"

  `define SIM_CSTR_FILE_CHKO_UART_DAT    "check_data/UART_dumpDatOut_S1I32F0.dat"

  `define SIM_CSTR_FILE_CHKO_XXX    "XXX"

  `define SIM_CSTR_FILE_WAVE_SHM     "simul_data/waveform.shm"
  `define SIM_CSTR_FILE_WAVE_FSDB    "simul_data/waveform.fsdb"
  `define SIM_CSTR_FILE_WAVE_VCD     "simul_data/waveform.vcd"
  `define SIM_CSTR_FILE_WAVE_EVCD    "simul_data/waveform.evcd"

  // DUT (setting)
  //`define DUT_XXX    XXX


module `SIM_EVAL_TOP ;


//*** PARAMETER ****************************************************************

  // global
  //`include "localparam_uart.vh"


//*** INPUT/OUTPUT *************************************************************

  // global
  reg                         clk          ;
  reg                         rstn         ;

  // apb_if
  reg  [`APB_ADDR_WD-1: 0]    tx_paddr_i   ;
  reg                         tx_psel_i    ;
  reg                         tx_penable_i ;
  reg                         tx_pwrite_i  ;
  wire [`APB_DATA_WD-1: 0]    tx_prdata_o  ;
  reg  [`APB_DATA_WD-1: 0]    tx_pwdata_i  ;

  // apb_if
  reg  [`APB_ADDR_WD-1: 0]    rx_paddr_i   ;
  reg                         rx_psel_i    ;
  reg                         rx_penable_i ;
  reg                         rx_pwrite_i  ;
  wire [`APB_DATA_WD-1: 0]    rx_prdata_o  ;
  reg  [`APB_DATA_WD-1: 0]    rx_pwdata_i  ;

  // uart_if
  wire                        uart_trx     ;

  // status_o
  wire                        ready_o      ;


//*** WIRE/REG *****************************************************************

  // seed
  integer                     sim_dat_seed ;
  reg  [`APB_DATA_WD-1: 0]    sim_dat_reg  ;


//*** SUB BENCH ****************************************************************

  `include "sub-testbench/sub-testbench.vh"


//*** MAIN BODY ****************************************************************
//--- PROCESS --------------------------
  // clk
  initial begin
    clk = 'd0 ;
    forever begin
      #( `SIM_DATA_PRD_CLK / 'd2 );
      clk = ! clk ;
    end
  end

  // rstn
  initial begin
    rstn = 'd0 ;
    #( 5 * `SIM_DATA_PRD_CLK );
    @(negedge clk );
    rstn = 'd1 ;
  end

  // sim_dat_seed
  initial begin
    sim_dat_seed = `SIM_DATA_SEED ;
  end

  // main
  initial begin
    // init
    tx_paddr_i   = 'd0 ;
    tx_psel_i    = 'd0 ;
    tx_penable_i = 'd0 ;
    tx_pwrite_i  = 'd0 ;
    tx_pwdata_i  = 'd0 ;
    rx_paddr_i   = 'd0 ;
    rx_psel_i    = 'd0 ;
    rx_penable_i = 'd0 ;
    rx_pwrite_i  = 'd0 ;
    rx_pwdata_i  = 'd0 ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // log
    $display( "\n\n*** CHECK %s BEGIN ! ***\n" ,`DUT_CSTR_TOP );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );
    $display( "" );

    // cfg
    -> sim_event_chki_uart_cfg_bgn ;
    @  sim_event_chki_uart_cfg_end ;

    // write
    -> sim_event_chki_uart_dat_bgn ;
    @  sim_event_chki_uart_dat_end ;

    // wait
    APB_TX_READ( `UART_FDB_NUMB_DAT ,'b0 );
    while( sim_dat_reg!='b0 ) begin
      #( 1000 * `SIM_DATA_PRD_CLK );
      APB_TX_READ( `UART_FDB_NUMB_DAT ,'b0 );
    end

    // read
    while( ready_o ) begin
      @(negedge clk );
      APB_RX_READ( `UART_FDB_DATA ,`SIM_FLAG_DSP_REG );
    end

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // post
    tx_paddr_i   = 'd0 ;
    tx_psel_i    = 'd0 ;
    tx_penable_i = 'd0 ;
    tx_pwrite_i  = 'd0 ;
    tx_pwdata_i  = 'd0 ;
    rx_paddr_i   = 'd0 ;
    rx_psel_i    = 'd0 ;
    rx_penable_i = 'd0 ;
    rx_pwrite_i  = 'd0 ;
    rx_pwdata_i  = 'd0 ;

    // log
    #( 1000 * `SIM_DATA_PRD_CLK );
    $display( "\n\n*** CHECK %s END ! ***\n" ,`DUT_CSTR_TOP );
    $finish;
  end


//--- INSTANTIATION --------------------
  // begin of DUT
    uart_tx_with_apb dut_tx(
      // global
      .clk          (    clk          ),
      .rstn         (    rstn         ),
      // apb_if
      .paddr_i      ( tx_paddr_i      ),
      .psel_i       ( tx_psel_i       ),
      .penable_i    ( tx_penable_i    ),
      .pwrite_i     ( tx_pwrite_i     ),
      .prdata_o     ( tx_prdata_o     ),
      .pwdata_i     ( tx_pwdata_i     ),
      // dat_o
      .uart_tx_o    (    uart_tr      )
    );
    uart_rx_with_apb dut_rx(
      // global
      .clk          (    clk          ),
      .rstn         (    rstn         ),
      // apb_if
      .paddr_i      ( rx_paddr_i      ),
      .psel_i       ( rx_psel_i       ),
      .penable_i    ( rx_penable_i    ),
      .pwrite_i     ( rx_pwrite_i     ),
      .prdata_o     ( rx_prdata_o     ),
      .pwdata_i     ( rx_pwdata_i     ),
      // dat_i
      .uart_rx_i    (    uart_tr      ),
      // status_o
      .ready_o      (    ready_o      )
    );
  // end   of DUT


//--- WAVEFORM DUMP --------------------
  // shm
  `ifdef SIM_KNOB_WAVEFORM_SHM
    initial begin
      if( `SIM_KNOB_WAVEFORM_SHM ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $shm_open( `SIM_CSTR_FILE_WAVE_SHM );
        $shm_probe( `SIM_EVAL_TOP ,`SIM_CSTR_WAVEFORM_LEVEL );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (shm,%s) to this test is on!" ,`SIM_CSTR_WAVEFORM_LEVEL );
      end
    end
  `endif

  // fsdb
  `ifdef SIM_KNOB_WAVEFORM_FSDB
    initial begin
      if( `SIM_KNOB_WAVEFORM_FSDB ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $fsdbDumpfile( `SIM_CSTR_FILE_WAVE_FSDB );
        $fsdbDumpvars( `SIM_EVAL_TOP );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (fsdb) to this test is on!" );
      end
    end
  `endif

  // vcd
  `ifdef SIM_KNOB_WAVEFORM_VCD
    initial begin
      if( `SIM_KNOB_WAVEFORM_VCD ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $dumpfile( `SIM_CSTR_FILE_WAVE_VCD );
        $dumpvars( 'd0, `SIM_EVAL_TOP );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (vcd) to this test is on!" );
      end
    end
  `endif

  // evcd
  `ifdef SIM_KNOB_WAVEFORM_EVCD
    initial begin
      #`EVCD_TIME_BGN ;
      $dumpports( dut ,`SIM_CSTR_FILE_WAVE_EVCD );
      #( 10 * `SIM_DATA_PRD_CLK );
      $display( "\t\t dump (evcd) to this test is on!" );
    end
  `endif


//*** TASK *********************************************************************
//--- APB_TX_WRITE ---------------------
  task APB_TX_WRITE;
    input [`APB_DATA_WD-2-1: 0]    addr ;
    input [`APB_DATA_WD  -1: 0]    data ;
    input                          flag_verbose ;
    begin
      @(negedge clk);
      tx_paddr_i   =  addr << 'd2 ;
      tx_psel_i    = 'b1   ;
      tx_penable_i = 'b0   ;
      tx_pwrite_i  = 'b1   ;
      tx_pwdata_i  =  data ;
      if( flag_verbose ) begin
        if( addr == `UART_CFG_DATA ) begin
          $display( "at %08d ns, write char %c to TX addr %x" ,$time ,data , addr);
        end
        else begin
          $display( "at %08d ns, write data %x to TX addr %x" ,$time ,data , addr);
        end
      end
      @(negedge clk);
      tx_penable_i = 'b1   ;
      @(negedge clk);
      tx_psel_i    = 'b0   ;
      tx_penable_i = 'b0   ;
      tx_pwrite_i  = 'b0   ;
    end
  endtask

//--- APB_TX_READ ----------------------
  task APB_TX_READ;
    input [`APB_DATA_WD-2-1: 0]    addr ;
    input                          flag_verbose ;
    begin
      @(negedge clk);
      tx_paddr_i   =  addr << 'd2 ;
      tx_psel_i    = 'b1   ;
      tx_penable_i = 'b0   ;
      tx_pwrite_i  = 'b0   ;
      @(negedge clk);
      tx_penable_i = 'b1   ;
      @(negedge clk);
      tx_psel_i    = 'b0   ;
      tx_penable_i = 'b0   ;
      tx_pwrite_i  = 'b0   ;
      sim_dat_reg  = tx_prdata_o ;
      if( flag_verbose ) begin
        if( addr == `UART_FDB_DATA ) begin
          $display( "at %08d ns, read char %c from TX addr %x" ,$time ,sim_dat_reg , addr);
        end
        else begin
          $display( "at %08d ns, read data %x from TX addr %x" ,$time ,sim_dat_reg , addr);
        end
      end
    end
  endtask

//--- APB_RX_WRITE ---------------------
  task APB_RX_WRITE;
    input [`APB_DATA_WD-2-1: 0]    addr ;
    input [`APB_DATA_WD  -1: 0]    data ;
    input                          flag_verbose ;
    begin
      @(negedge clk);
      rx_paddr_i   =  addr << 'd2 ;
      rx_psel_i    = 'b1   ;
      rx_penable_i = 'b0   ;
      rx_pwrite_i  = 'b1   ;
      rx_pwdata_i  =  data ;
      if( flag_verbose ) begin
        if( addr == `UART_CFG_DATA ) begin
          $display( "at %08d ns, write char %c to RX addr %x" ,$time ,data , addr);
        end
        else begin
          $display( "at %08d ns, write data %x to RX addr %x" ,$time ,data , addr);
        end
      end
      @(negedge clk);
      rx_penable_i = 'b1   ;
      @(negedge clk);
      rx_psel_i    = 'b0   ;
      rx_penable_i = 'b0   ;
      rx_pwrite_i  = 'b0   ;
    end
  endtask

//--- APB_RX_READ ----------------------
  task APB_RX_READ;
    input [`APB_DATA_WD-2-1: 0]    addr ;
    input                          flag_verbose ;
    begin
      @(negedge clk);
      rx_paddr_i   =  addr << 'd2 ;
      rx_psel_i    = 'b1   ;
      rx_penable_i = 'b0   ;
      rx_pwrite_i  = 'b0   ;
      @(negedge clk);
      rx_penable_i = 'b1   ;
      @(negedge clk);
      rx_psel_i    = 'b0   ;
      rx_penable_i = 'b0   ;
      rx_pwrite_i  = 'b0   ;
      sim_dat_reg  = rx_prdata_o ;
      if( flag_verbose ) begin
        if( addr == `UART_FDB_DATA ) begin
          $display( "at %08d ns, read char %c from RX addr %x" ,$time ,sim_dat_reg , addr);
        end
        else begin
          $display( "at %08d ns, read data %x from RX addr %x" ,$time ,sim_dat_reg , addr);
        end
      end
    end
  endtask


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG_CALC

  `endif

endmodule

`include "undef_calc.vh"
