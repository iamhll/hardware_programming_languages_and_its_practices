.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about library
   ..
.. -----------------------------------------------------------------------------

About Library
=============

   Directory *library* contains **three** sub-directories.

*  :behave_rtl: behavior models used in designs
*  :behave_sim: behavior models used in testbenches
*  :\*: models of technology * (for example, TSMC65 or GF28)


Behave RTL
----------

   Directory *behave_rtl* contains **three** behavior models which can be used in designs.

   .. table:: **sram_sp_behave** (single port sram)
      :align: left
      :widths: auto

      ======================= ============= ==============
       type                    item          description
      ======================= ============= ==============
       parameter               KNOB_RNDOUT   | existence of random output logic
                                             | if enabled,
                                             | memory array will be initialized with random value
                                             | output *rd_dat_o* will be driven with random value on the next cycle, if input *rd_val_i* is disasserted
       parameter               SIZE          memory depth
       parameter               DATA_WD       memory data width
       input                   clk           clock
       input  [SIZE_WD-1 :0]   adr_i         access address
       input                   wr_val_i      write enable, pulse signal, high active
       input  [DATA_WD-1 :0]   wr_dat_i      write data
       input                   rd_val_i      | read enable, pulse signal, high active
                                             | if asserted,
                                             | output *rd_dat_o* will be driven with the requested data on the next cycle
       output [DATA_WD-1 :0]   rd_dat_o      read data
      ======================= ============= ==============

   .. table:: **sram_sp_be_behave** (single port sram with bit enable)
      :align: left
      :widths: auto

      ================================ ============= ==============
       type                             item          description
      ================================ ============= ==============
       parameter                        KNOB_RNDOUT   | existence of random output logic
                                                      | if enabled,
                                                      | memory array will be initialized with random value
                                                      | output *rd_dat_o* will be driven with random value on the next cycle, if input *rd_val_i* is disasserted
       parameter                        SIZE          memory depth
       parameter                        SIZE_COL      memory data width controlled by one write enable bit
       parameter                        DATA_WD       memory data width
       input                            clk           clock
       input  [SIZE_WD-1 :0]            adr_i         access address
       input  [DATA_WD/SIZE_COL-1 :0]   wr_val_i      write enable, pulse signal, high active
       input  [DATA_WD-1 :0]            wr_dat_i      write data
       input                            rd_val_i      | read enable, pulse signal, high active
                                                      | if asserted,
                                                      | output *rd_dat_o* will be driven with the requested data on the next cycle
       output [DATA_WD-1 :0]            rd_dat_o      read data
      ================================ ============= ==============

   .. table:: **sram_tp_behave** (two port sram) (**will be removed later**)
      :align: left
      :widths: auto

      ================================ ============= ==============
       type                             item          description
      ================================ ============= ==============
       parameter                        KNOB_RNDOUT   | existence of random output logic
                                                      | if enabled,
                                                      | memory array will be initialized with random value
                                                      | output *rd_dat_o* will be driven with random value on the next cycle, if input *rd_val_i* is disasserted
       parameter                        SIZE          memory depth
       parameter                        DATA_WD       memory data width
       input                            clk           clock
       input                            wr_val_i      write enable, pulse signal, high active
       input  [SIZE_WD-1 :0]            wr_adr_i      write address
       input  [DATA_WD-1 :0]            wr_dat_i      write data
       input                            rd_val_i      | read enable, pulse signal, high active
                                                      | if asserted,
                                                      | output *rd_dat_o* will be driven with the requested data on the next cycle
       input  [SIZE_WD-1 :0]            rd_adr_i      write address
       output [DATA_WD-1 :0]            rd_dat_o      read data
      ================================ ============= ==============

*  Considering backend implementation, dual-port SRAMs are forbidden in our project.
*  Due to the same reason, two-port SRAMs are only allowed in FIFOs now.
   Nevertheless, they will also be forbidden sooner or later,
   since two-port SRAMs in single-clock FIFOs can always be replaced with single-port SRAMs.
*  Once instantiated, model *sram_sp_behave* would display calling information *("\t calling sram_sp_behave (%0dx%0d) @%m", SIZE, DATA_WD)*.
*  Once instantiated, model *sram_sp_be_behave* would display calling information *("\t calling sram_sp_be_behave (%0dx%0d)(%0d) @%m", SIZE, DATA_WD, SIZE_COL)*.
*  Once instantiated, model *sram_tp_behave* would display calling information *("\t calling sram_tp_behave (%0dx%0d) @%m", SIZE, DATA_WD)*.
*  Once instantiated, all of the above models would display size warnings *("\n\t SRAM WARNING: size of %m is too small!\n")*, if depth is less than 32.



Behave SIM
----------

   Directory *behave_sim* contains **three** corresponding behavior models which can be used in testbenches.

*  model *sram_sp_behave_sim* is the corresponding model of *sram_sp_behave*
*  model *sram_sp_be_behave_sim* is the corresponding model of *sram_sp_be_behave*
*  model *sram_tp_behave_sim* is the corresponding model of *sram_tp_behave*
*  besides the items exist in design models, the corresponding testbench models have 3 extra items,
   but they do not display the calling information or size warnings

\

   .. table::
      :align: left
      :widths: auto

      =========== ============= ==============
       type        item          description
      =========== ============= ==============
       input       rstn          reset, level signal, low active
       parameter   KNOB_HLDOUT   | existence of output holding logic
                                 | if enabled,
                                 | output *rd_dat_o* will hold the value, if input *rd_val_i* is disasserted
       parameter   KNOB_REGOUT   | existence of output registering logic
                                 | if enabled,
                                 | output *rd_dat_o* will be driven with the requested data on the next cycle
      =========== ============= ==============
