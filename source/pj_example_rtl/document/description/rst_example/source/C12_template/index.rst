.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : template
   ..
.. -----------------------------------------------------------------------------

Template
========

Design
------

   ::

      //------------------------------------------------------------------------------
        //
        //  Filename       : calc_add_knl.v
        //  Author         : Huang Leilei
        //  Status         : draft
        //  Created        : 2025-02-18
        //  Description    : [kernal logic] of [adder]
        //
      //------------------------------------------------------------------------------

      `include "define_calc.vh"

      module calc_add_knl(
        // global
        clk                   ,
        rstn                  ,
        // cfg_i
        cfg_flg_saturation_i    ,
        // dat_i
        val_i                 ,
        dat_a_i               ,
        dat_b_i               ,
        // dat_o
        val_o                 ,
        dat_o
      );


      //*** PARAMETER ****************************************************************

        // global
        // !!! a special case here
        localparam   DATA_WD           = 'd32             ;

        // derived
        localparam   DATA_MAX          = { {DATA_WD{1'b1}}
                                       }                  ;


      //*** INPUT/OUTPUT *************************************************************

        // global
        input                          clk                ;
        input                          rstn               ;

        // cfg_i
        input                          cfg_flg_saturation_i ;

        // val_i
        input                          val_i              ;
        input      [DATA_WD  -1 :0]    dat_a_i            ;
        input      [DATA_WD  -1 :0]    dat_b_i            ;

        // val_o
        output reg                     val_o              ;
        output reg [DATA_WD  -1 :0]    dat_o              ;


      //*** WIRE/REG *****************************************************************

        // output
        wire       [DATA_WD+1-1 :0]    dat_w              ;


      //*** MAIN BODY ****************************************************************
      //--- OUTPUT ---------------------------
        // val_o, dat_o
        always @(posedge clk or negedge rstn ) begin
          if( !rstn ) begin
            val_o <= 'd0 ;
            dat_o <= 'd0 ;
          end
          else begin
              val_o <= val_i ;
            if( val_i ) begin
              dat_o <= (cfg_flg_saturation_i&&(dat_w>DATA_MAX)) ? DATA_MAX : dat_w ;
            end
          end
        end

        // dat_w
        assign dat_w = dat_a_i + dat_b_i ;


      //*** DEBUG ********************************************************************

        `ifdef KNOB_DBG_CALC

        `endif

      endmodule

      `include "undef_calc.vh"


Testbench
---------

   ::

      //------------------------------------------------------------------------------
        //
        //  Filename       : sim_calc_add_knl.v
        //  Author         : Huang Leilei
        //  Status         : draft
        //  Created        : 2025-02-18
        //  Description    : [testbench] for [calc_add_knl]
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
        //`define SIM_DATA_WAVEFORM_TIME     -1
        //`define SIM_CSTR_WAVEFORM_LEVEL    -1

        // DUT
        //`define DUT_EVAL_TOP    -1
        //`define DUT_CSTR_TOP    -1
        `include "check_data/dut_setting.vh"


      //--- LOCAL (VARIABLE) -----------------
        // SIM
        `define SIM_KNOB_CHKO                         'b1
        `define SIM_KNOB_CHKO_CALC_ADD_KNL_DAT    'b1
        `ifdef  SIM_KNOB_DBG
        `define SIM_KNOB_CHKO_XXX                     `SIM_KNOB_DBG
        `endif
        //`define SIM_KNOB_WAVEFORM_VCD
        //`define SIM_KNOB_WAVEFORM_EVCD

        // DUT
        `ifdef  SIM_KNOB_DBG
        `define SIM_KNOB_DBG_CALC
        `endif
        `include "define_calc.vh"


      //--- LOCAL (CONSTANT) -----------------
        // SIM
        `define SIM_DATA_PRD_CLK                             10.000
        `define SIM_CSTR_FILE_INIT_XXX                       "XXX"
        `define SIM_CSTR_FILE_CHKI_CALC_ADD_KNL_DAT_A    "check_data/dat_a.dat"
        `define SIM_CSTR_FILE_CHKI_CALC_ADD_KNL_DAT_B    "check_data/dat_b.dat"
        `define SIM_CSTR_FILE_CHKI_XXX                       "XXX"
        `define SIM_CSTR_FILE_CHKO_CALC_ADD_KNL_DAT      "check_data/dat.dat"
        `define SIM_CSTR_FILE_CHKO_XXX                       "XXX"
        `define SIM_CSTR_FILE_WAVE_SHM                       "simul_data/waveform.shm"
        `define SIM_CSTR_FILE_WAVE_FSDB                      "simul_data/waveform.fsdb"
        `define SIM_CSTR_FILE_WAVE_VCD                       "simul_data/waveform.vcd"
        `define SIM_CSTR_FILE_WAVE_EVCD                      "simul_data/waveform.evcd"

        // DUT (setting)
        //`define DUT_XXX    XXX


      module `SIM_EVAL_TOP ;


      //*** PARAMETER ****************************************************************

        // global
        `include "localparam_calc.vh"

        // local
        localparam    DATA_WD  = 'd32             ;


      //*** INPUT/OUTPUT *************************************************************

        // global
        reg                    clk                ;
        reg                    rstn               ;

        // cfg_i
        reg                    cfg_flg_saturation_i ;

        // val_i
        reg                    val_i              ;
        reg  [DATA_WD-1 :0]    dat_a_i            ;
        reg  [DATA_WD-1 :0]    dat_b_i            ;

        // val_o
        wire                   val_o              ;
        wire [DATA_WD-1 :0]    dat_o              ;


      //*** WIRE/REG *****************************************************************

        // seed
        integer                dat_seed_r    ;


      //*** SUB BENCH ****************************************************************

        `include "sub_bench/sub_bench.vh"


      //*** MAIN BODY ****************************************************************
      //--- PROC -----------------------------
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

        // dat_seed_r
        initial begin
          dat_seed_r = `SIM_DATA_SEED ;
        end

        // main
        initial begin
          // init
          cfg_flg_saturation_i = 'd0 ;
          val_i              = 'd0 ;
          dat_a_i            = 'd0 ;
          dat_b_i            = 'd0 ;

          // delay
          #( 5 * `SIM_DATA_PRD_CLK );

          // log
          $display( "\n\n*** CHECK %s BEGIN ! ***\n" ,`DUT_CSTR_TOP );

          // delay
          #( 5 * `SIM_DATA_PRD_CLK );
          $display( "" );

          // core
          -> event_init_calc_add_knl_cfg     ;
          -> event_chki_calc_add_knl_dat_bgn ;
          @  event_chki_calc_add_knl_dat_end ;

          // delay
          #( 5 * `SIM_DATA_PRD_CLK );

          // post
          rstn               = 'd0 ;
          cfg_flg_saturation_i = 'd0 ;
          val_i              = 'd0 ;
          dat_a_i            = 'd0 ;
          dat_b_i            = 'd0 ;

          // log
          #( 1000 * `SIM_DATA_PRD_CLK );
          $display( "\n\n*** CHECK %s END ! ***\n" ,`DUT_CSTR_TOP );
          $finish;
        end


      //--- INST -----------------------------
        // begin of DUT
          `DUT_EVAL_TOP dut(
            // global
            .clk                   ( clk                   ),
            .rstn                  ( rstn                  ),
            // cfg_i
            .cfg_flg_saturation_i    ( cfg_flg_saturation_i    ),
            // dat_i
            .val_i                 ( val_i                 ),
            .dat_a_i               ( dat_a_i               ),
            .dat_b_i               ( dat_b_i               ),
            // dat_o
            .val_o                 ( val_o                 ),
            .dat_o                 ( dat_o                 )
          );
        // end   of DUT


      //--- DUMP -----------------------------
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
            #`VCD_TIME_BGN ;
            $dumpfile( `SIM_CSTR_FILE_WAVE_VCD );
            $dumpvars( 'd0, `SIM_EVAL_TOP );
            #( 10 * `SIM_DATA_PRD_CLK );
            $display( "\t\t dump (vcd) to this test is on!" );
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

        `ifdef KNOB_DBG_CALC

        `endif

      endmodule

      `include "undef_calc.vh"


Sub-Testbench (Driver)
----------------------

   ::

      //------------------------------------------------------------------------------
        //
        //  Filename       : sub_bench.vh
        //  Author         : Huang Leilei
        //  Status         : draft
        //  Created        : 2025-02-18
        //  Description    : [sub testbench] for [calc_add_knl]
        //
      //------------------------------------------------------------------------------

      //*** SIM_TASK_INIT ************************************************************
      //--- SIM_TASK_INIT_CALC_ADD_KNL_CFG
        event    event_init_calc_add_knl_cfg ;

        initial begin
          SIM_TASK_INIT_CALC_ADD_KNL_CFG ;
        end

        task SIM_TASK_INIT_CALC_ADD_KNL_CFG ;
          // main body
          begin
            // wait
            @( event_init_calc_add_knl_cfg );

            // set
            cfg_flg_saturation_i = `CALC_ADD_FLAG_SATURATION ;
          end
        endtask


      //*** SIM_TASK_CHKI ************************************************************
      //--- SIM_TASK_CHKI_CALC_ADD_KNL_DAT
        event    event_chki_calc_add_knl_dat_bgn ;
        event    event_chki_calc_add_knl_dat_end ;

        initial begin
          SIM_TASK_CHKI_CALC_ADD_KNL_DAT ;
        end

        task SIM_TASK_CHKI_CALC_ADD_KNL_DAT ;
          // variables
          integer    sim_fpt_a ;
          integer    sim_fpt_b ;
          integer    sim_tmp   ;

          // main body
          begin
            // core loop
            forever begin
              // wait
              @( event_chki_calc_add_knl_dat_bgn );

              // open files
              sim_fpt_a = $fopen( `SIM_CSTR_FILE_CHKI_CALC_ADD_KNL_DAT_A ,"r" );
              sim_fpt_b = $fopen( `SIM_CSTR_FILE_CHKI_CALC_ADD_KNL_DAT_B ,"r" );

              // set
              sim_tmp = 'd1 ;
              while( sim_tmp != -'sd1 ) begin
                @(negedge clk );
                val_i   = 'd1 ;
                sim_tmp = $fscanf( sim_fpt_a ,"%x", dat_a_i );
                sim_tmp = $fscanf( sim_fpt_b ,"%x", dat_b_i );
              end

              // reset
              val_i   = 'd0 ;
              dat_a_i = $random( dat_seed_r );
              dat_b_i = $random( dat_seed_r );

              // close files
              $fclose( sim_fpt_a );
              $fclose( sim_fpt_b );

              // return
              -> event_chki_calc_add_knl_dat_end ;
            end
          end
        endtask


      //*** SIM_TASK_CHKO ************************************************************
      //--- CHKO_DAT -------------------------
        `define EVAL_PATH_CALC_ADD_KNL    dut
        `include "sub_bench/sub_bench_dat.vh"


Sub-Testbench (Monitor)
-----------------------

   ::

      //------------------------------------------------------------------------------
        //
        //  Filename       : sub_bench_dat.vh
        //  Author         : Huang Leilei
        //  Status         : draft
        //  Created        : 2025-02-18
        //  Description    : [sub-testbench dat] for [example]
        //
      //------------------------------------------------------------------------------

      //--- SIM_TASK_CHKO_CALC_ADD_KNL_DAT
      `ifdef SIM_KNOB_CHKO_CALC_ADD_KNL_DAT
        initial begin
          SIM_TASK_CHKO_CALC_ADD_KNL_DAT ;
        end

        task SIM_TASK_CHKO_CALC_ADD_KNL_DAT ;
          // variables
          integer                   sim_fpt ;
          integer                   sim_tmp ;
          reg     [DATA_WD-1 :0]    sim_dat ;

          reg                       dut_val ;
          reg     [DATA_WD-1 :0]    dut_dat ;

          // main body
          begin
            if( `SIM_KNOB_CHKO && `SIM_KNOB_CHKO_CALC_ADD_KNL_DAT ) begin
              // log info
              #( 10 * `SIM_DATA_PRD_CLK );
              $display( "\t\t function check to %s's dat is on!" ,`DUT_CSTR_TOP );

              // open files
              sim_fpt = $fopen( `SIM_CSTR_FILE_CHKO_CALC_ADD_KNL_DAT ,"r" );

              // core loop
              forever begin
                // wait
                @(negedge clk );

                // dut_val
                dut_val = `EVAL_PATH_CALC_ADD_KNL.val_o ;

                // if valid
                if( dut_val ) begin
                  // dut_*
                  dut_dat = `EVAL_PATH_CALC_ADD_KNL.dat_o ;

                  // sim_*
                  sim_tmp = $fscanf( sim_fpt ,"%x" ,sim_dat );

                  // check
                  if( dut_dat !== sim_dat ) begin
                    $display("\n\t CALC_ADD_KNL ERROR: at %08d ns, dat_o should be %x, however is %x!\n"
                      ,$time
                      ,sim_dat
                      ,dut_dat
                    );
                    if( `SIM_CSTR_LEVEL_STOP != "none" ) begin
                      #( 1000 * `SIM_DATA_PRD_CLK );
                      $finish ;
                    end
                  end
                end
              end
            end
          end
        endtask
      `endif
