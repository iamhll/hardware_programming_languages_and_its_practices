//------------------------------------------------------------------------------
  //
  //  Filename       : tb_sin.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [testbench] for [sin]
  //
//------------------------------------------------------------------------------

`include "define.vh"

//--- GLOBAL ---------------------------
  `define SIM_KNOB_WAVEFORM_VCD     1
  `define SIM_DATA_WAVEFORM_TIME    0


//--- LOCAL ----------------------------
  // SIM
  `define SIM_DATA_PRD_CLK    10.000

  `define SIM_CSTR_FILE_CHKI_DAT_I    "../SIN_DAT_I_S0I1F16.dat"
  `define SIM_CSTR_FILE_CHKO_DAT_O    "../SIN_DAT_O_S0I1F16.dat"

  `define SIM_CSTR_FILE_WAVE_VCD    "waveform.vcd"


module tb_sin ;


//*** PARAMETER ****************************************************************

  // local
  localparam    DATA_WD  = 'd17    ;


//*** INPUT/OUTPUT *************************************************************

  // global
  reg                    clk       ;
  reg                    rstn      ;

  // dat_i
  reg                    val_i     ;
  reg  [DATA_WD-1 :0]    dat_i     ;

  // dat_o
  wire [DATA_WD-1 :0]    dat_o     ;


//*** WIRE/REG *****************************************************************

  // sim
  integer                sim_fpt_i ;
  integer                sim_fpt_o ;
  integer                sim_tmp   ;
  reg  [DATA_WD-1 :0]    sim_dat   ;

  // dut
  reg                    dut_val   ;
  reg  [DATA_WD-1 :0]    dut_dat   ;


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

  // dat_o
  assign val_o = val_i ;

  // main
  initial begin
    // init
    val_i = 'd0 ;
    dat_i = 'd0 ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // log
    $display( "\n\n*** CHECK BEGIN ! ***\n" );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );
    $display( "" );

    // open files
    sim_fpt_i = $fopen( `SIM_CSTR_FILE_CHKI_DAT_I ,"r" );

    // set
    sim_tmp = 'd1 ;
    while( sim_tmp != -'sd1 ) begin
      @(negedge clk );
      val_i   = 'd1 ;
      sim_tmp = $fscanf( sim_fpt_i ,"%x" ,dat_i );
    end
    @(negedge clk );
    val_i = 'd0 ;
    dat_i = $random ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // post
    val_i = 'd0 ;
    dat_i = 'd0 ;

    // log
    #( 1000 * `SIM_DATA_PRD_CLK );
    $display( "\n\n*** CHECK END ! ***\n" );
    $finish;
  end

  // checker
  initial begin
    // log info
    #( 10 * `SIM_DATA_PRD_CLK );
    $display( "\t\t function check to dat_o is on!" );

    // open files
    sim_fpt_o = $fopen( `SIM_CSTR_FILE_CHKO_DAT_O ,"r" );

    // core loop
    forever begin
        // wait
        @(posedge clk );

        // dut_val
        dut_val = val_o ;

        // if valid
        if( dut_val ) begin
          // dut_*
          dut_dat = dat_o ;

          // sim_*
          sim_tmp = $fscanf( sim_fpt_o ,"%x" ,sim_dat );

          // check
          if( dut_dat !== sim_dat ) begin
            $display("\n\t ERROR: at %08d ns, dat_c_o should be %x, however is %x!\n"
              ,$time
              ,sim_dat
              ,dut_dat
            );
            #( 1000 * `SIM_DATA_PRD_CLK );
            $finish ;
          end
        end
    end
  end


//--- INSTANTIATION --------------------
  // begin of DUT
    sin dut(
      // dat_i
      .dat_i    ( dat_i    ),
      // dat_o
      .dat_o    ( dat_o    )
    );
  // end   of DUT


//--- WAVEFORM DUMP --------------------
  // vcd
  `ifdef SIM_KNOB_WAVEFORM_VCD
    initial begin
      if( `SIM_KNOB_WAVEFORM_VCD ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $dumpfile( `SIM_CSTR_FILE_WAVE_VCD );
        $dumpvars( 'd0, tb_sin );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (vcd) to this test is on!" );
      end
    end
  `endif

endmodule
