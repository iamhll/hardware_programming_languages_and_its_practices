//------------------------------------------------------------------------------
  //
  //  Filename       : tb_gray2bin.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [testbench] for [gray2bin]
  //
//------------------------------------------------------------------------------

//--- GLOBAL ---------------------------
  `define SIM_KNOB_WAVEFORM_VCD      1
  `define SIM_DATA_WAVEFORM_TIME     0


//--- LOCAL ----------------------------
  // SIM
  `define SIM_DATA_PRD_CLK    10.000

  `define SIM_CSTR_FILE_WAVE_VCD     "waveform.vcd"


module tb_gray2bin ;


//*** PARAMETER ****************************************************************

  // local
  `ifdef TEST_DATA_WD
  localparam    DATA_WD  = `TEST_DATA_WD ;
  `else
  localparam    DATA_WD  = 'd32    ;
  `endif


//*** INPUT/OUTPUT *************************************************************

  // global
  reg                    clk       ;
  reg                    rstn      ;

  // dat_i
  reg                    val_i     ;
  reg  [DATA_WD-1 :0]    dat_b_i   ;

  // dat_w
  wire [DATA_WD-1 :0]    dat_g_w   ;

  // dat_o
  wire                   val_o     ;
  wire [DATA_WD-1 :0]    dat_b_o   ;


//*** WIRE/REG *****************************************************************

  // sim
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
    val_i   = 'd0 ;
    dat_b_i = 'd0 ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // log
    $display( "\n\n*** CHECK BEGIN (DW=%0d)! ***\n" ,DATA_WD );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );
    $display( "" );

    // set
    @(negedge clk );
    val_i   = 'd1 ;
    dat_b_i = 'd0 ;
    repeat( 'd15 ) begin
      @(negedge clk );
      dat_b_i = dat_b_i + 'd1 ;
    end
    @(negedge clk );
    dat_b_i = 'hffff_fff0 ;
    repeat( 'd15 ) begin
      @(negedge clk );
      dat_b_i = dat_b_i + 'd1 ;
    end
    repeat( 'd1000 ) begin
      @(negedge clk );
      dat_b_i = $random ;
    end
    @(negedge clk );
    val_i   = 'd0 ;
    dat_b_i = $random ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // post
    val_i   = 'd0 ;
    dat_b_i = 'd0 ;

    // log
    #( 1000 * `SIM_DATA_PRD_CLK );
    $display( "\n\n*** CHECK END ! ***\n" );
    $finish;
  end

  // checker
  initial begin
    // log info
    #( 10 * `SIM_DATA_PRD_CLK );
    $display( "\t\t function check to dat_b_o is on!" );

    // core loop
    forever begin
        // wait
        @(posedge clk );

        // dut_val
        dut_val = val_o ;

        // if valid
        if( dut_val ) begin
          // dut_*
          dut_dat = dat_b_o ;

          // sim_*
          sim_dat = dat_b_i ;

          // check
          if( dut_dat !== sim_dat ) begin
            $display("\n\t ERROR: at %08d ns, dat_b_o should be %x, however is %x!\n"
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
  // begin of GOLDEN bin2gray
    bin2gray #(
      .DATA_WD    ( DATA_WD    )
    ) bin2gray(
      // dat_i
      .dat_b_i    ( dat_b_i    ),
      // dat_g_o
      .dat_g_o    ( dat_g_w    )
    );
  // end   of GOLDEN bin2gray

  // begin of DUT
    gray2bin #(
      .DATA_WD    ( DATA_WD    )
    ) dut(
      // dat_i
      .dat_g_i    ( dat_g_w    ),
      // dat_g_o
      .dat_b_o    ( dat_b_o    )
    );
  // end   of DUT


//--- WAVEFORM DUMP --------------------
  // vcd
  `ifdef SIM_KNOB_WAVEFORM_VCD
    initial begin
      if( `SIM_KNOB_WAVEFORM_VCD ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $dumpfile( `SIM_CSTR_FILE_WAVE_VCD );
        $dumpvars( 'd0, tb_gray2bin );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (vcd) to this test is on!" );
      end
    end
  `endif

endmodule
