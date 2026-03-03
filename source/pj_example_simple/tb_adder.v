//------------------------------------------------------------------------------
  //
  //  Filename       : tb_adder.v
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2026-03-03
  //  Description    : [testbench] for [adder]
  //
//------------------------------------------------------------------------------

//--- GLOBAL ---------------------------
  `define SIM_KNOB_WAVEFORM_VCD      1
  `define SIM_DATA_WAVEFORM_TIME     0


//--- LOCAL ----------------------------
  // SIM
  `define SIM_DATA_PRD_CLK    10.000

  `define SIM_CSTR_FILE_CHKI_ADD_DAT_A    "DATA_A.txt"
  `define SIM_CSTR_FILE_CHKI_ADD_DAT_B    "DATA_B.txt"

  `define SIM_CSTR_FILE_CHKO_ADD_DAT_C    "DATA_C.txt"

  `define SIM_CSTR_FILE_WAVE_VCD     "waveform.vcd"


module tb_adder ;


//*** PARAMETER ****************************************************************

  // local
  localparam    DATA_WD    = 'd8     ;


//*** INPUT/OUTPUT *************************************************************

  // global
  reg                      clk       ;
  reg                      rstn      ;

  // dat_i
  reg                      val_i     ;
  reg  [DATA_WD  -1 :0]    dat_a_i   ;
  reg  [DATA_WD  -1 :0]    dat_b_i   ;

  // dat_o
  wire                     val_o     ;
  wire [DATA_WD+1-1 :0]    dat_c_o   ;


//*** WIRE/REG *****************************************************************

  // sim
  integer                  sim_fpt_a ;
  integer                  sim_fpt_b ;
  integer                  sim_fpt_c ;
  integer                  sim_tmp   ;
  reg  [DATA_WD+1-1 :0]    sim_dat   ;

  // dut
  reg                      dut_val   ;
  reg  [DATA_WD+1-1 :0]    dut_dat   ;


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

  // main
  initial begin
    // init
    val_i   = 'd0 ;
    dat_a_i = 'd0 ;
    dat_b_i = 'd0 ;

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // log
    $display( "\n\n*** CHECK BEGIN ! ***\n" );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );
    $display( "" );

    // set
    sim_fpt_a = $fopen( `SIM_CSTR_FILE_CHKI_ADD_DAT_A ,"r" );
    sim_fpt_b = $fopen( `SIM_CSTR_FILE_CHKI_ADD_DAT_B ,"r" );
    sim_tmp = 'd1 ;
    while( sim_tmp != -'sd1 ) begin
      @(negedge clk );
      val_i   = 'd1 ;
      sim_tmp = $fscanf( sim_fpt_a ,"%d", dat_a_i );
      sim_tmp = $fscanf( sim_fpt_b ,"%d", dat_b_i );
    end
    val_i   = 'd0 ;
    dat_a_i = $random;
    dat_b_i = $random;
    $fclose( sim_fpt_a );
    $fclose( sim_fpt_b );

    // delay
    #( 5 * `SIM_DATA_PRD_CLK );

    // post
    val_i   = 'd0 ;
    dat_a_i = 'd0 ;
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
    $display( "\t\t function check to dat_c_o is on!" );

    // open files
    sim_fpt_c = $fopen( `SIM_CSTR_FILE_CHKO_ADD_DAT_C ,"r" );

    // core loop
    forever begin
        // wait
        @(negedge clk );

        // dut_val
        dut_val = val_o ;

        // if valid
        if( dut_val ) begin
          // dut_*
          dut_dat = dat_c_o ;

          // sim_*
          sim_tmp = $fscanf( sim_fpt_c ,"%d" ,sim_dat );

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
    adder dut(
      // global
      .clk        ( clk        ),
      .rstn       ( rstn       ),
      // dat_i
      .val_i      ( val_i      ),
      .dat_a_i    ( dat_a_i    ),
      .dat_b_i    ( dat_b_i    ),
      // dat_c_o
      .val_o      ( val_o      ),
      .dat_c_o    ( dat_c_o    )
    );
  // end   of DUT


//--- WAVEFORM DUMP --------------------
  // vcd
  `ifdef SIM_KNOB_WAVEFORM_VCD
    initial begin
      if( `SIM_KNOB_WAVEFORM_VCD ) begin
        #`SIM_DATA_WAVEFORM_TIME ;
        $dumpfile( `SIM_CSTR_FILE_WAVE_VCD );
        $dumpvars( 'd0, tb_adder );
        #( 10 * `SIM_DATA_PRD_CLK );
        $display( "\t\t dump (vcd) to this test is on!" );
      end
    end
  `endif

endmodule
