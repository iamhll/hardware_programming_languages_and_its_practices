//------------------------------------------------------------------------------
  //
  //  Filename       : sim_fifo.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [testbench] for [fifo]
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
  `define SIM_KNOB_CHK               'b1
  `define SIM_KNOB_CHK_FIFO_DAT    'b1
  `ifdef  SIM_KNOB_DBG
  `define SIM_KNOB_CHK_XXX           `SIM_KNOB_DBG
  `endif
  `ifdef  SIM_KNOB_DBG
  `define SIM_KNOB_DBG_CALC
  `endif
  //`define SIM_KNOB_WAVEFORM_EVCD

  // DUT
  `include "define_calc.vh"


//--- LOCAL (CONSTANT) -----------------
  // SIM
  `define SIM_DATA_PRD_CLK    10.000

  `define SIM_CSTR_FILE_INIT_XXX    "XXX"

  `define SIM_CSTR_FILE_CHKI_XXX    "XXX"

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
  //`include "localparam_fifo.vh"

  // local
  localparam   SIZE        = 'd128      ;
  localparam   DATA_WD     = 'd8        ;

  // derived
  localparam   SIZE_WD     = `FUNC_LOG2( SIZE ) ;


//*** INPUT/OUTPUT *************************************************************

  // global
  reg                      clk          ;
  reg                      rstn         ;

  // write
  reg                      wr_val_i     ;
  reg  [DATA_WD  -1 :0]    wr_dat_i     ;
  wire                     wr_ful_o     ;

  // read
  reg                      rd_val_i     ;
  wire                     rd_val_o     ;
  wire [DATA_WD  -1 :0]    rd_dat_o     ;
  wire                     rd_ept_o     ;

  // common
  wire [SIZE_WD+1-1 :0]    wd_usd_o     ;


//*** WIRE/REG *****************************************************************

  // seed
  integer                  sim_dat_seed ;


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
    wr_val_i = 'd0 ;
    wr_dat_i = 'd0 ;
    rd_val_i = 'd0 ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // log
    $display( "\n\n*** CHECK %s BEGIN ! ***\n" ,`DUT_CSTR_TOP );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );
    $display( "" );

    // core
    -> sim_event_init_fifo_cfg     ;
    -> sim_event_chki_fifo_dat_bgn ;
    @  sim_event_chki_fifo_dat_end ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // post
    wr_dat_i = 'd0 ;

    // wait
    @(negedge clk );
    while( !rd_ept_o ) begin
      @(negedge clk );
    end

    // log
    #( 1000 * `SIM_DATA_PRD_CLK );
    $display( "\n\n*** CHECK %s END ! ***\n" ,`DUT_CSTR_TOP );
    $finish;
  end


//--- INSTANTIATION --------------------
  // begin of DUT
    `DUT_EVAL_TOP #(
      .KNOB_LOG        ( 'b1          ),
      .SIZE            ( SIZE         ),
      .DATA_WD         ( DATA_WD      ),
      .NAME_LOG_INP    ( "simul_data/in.log"     ),
      .NAME_LOG_OUT    ( "simul_data/out.log"    )
    ) dut(
      // global
      .clk             ( clk          ),
      .rstn            ( rstn         ),
      // write
      .wr_val_i        ( wr_val_i     ),
      .wr_dat_i        ( wr_dat_i     ),
      .wr_ful_o        ( wr_ful_o     ),
      // read
      .rd_val_i        ( rd_val_i     ),
      .rd_val_o        ( rd_val_o     ),
      .rd_dat_o        ( rd_dat_o     ),
      .rd_ept_o        ( rd_ept_o     ),
      // common
      .wd_usd_o        ( wd_usd_o     )
    );
  // end   of DUT

  // pop logic
  reg sim_flg_pop ;
  always @(posedge clk or negedge rstn ) begin
    if( !rstn ) begin
      sim_flg_pop <= 'd0 ;
    end
    else begin
      sim_flg_pop <= ({$random(sim_dat_seed)}%10) == 0 ;
    end
  end
  always @(*) begin
    rd_val_i = (!rd_ept_o) && sim_flg_pop ;
  end

  


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


//*** DEBUG ********************************************************************

  `ifdef SIM_KNOB_DBG_CALC

  `endif

endmodule

`include "undef_calc.vh"
