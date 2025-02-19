.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about source
   ..
.. -----------------------------------------------------------------------------

About Source
============

   Directory *source* contains **four** different kinds of design files.

*  :common:       commonly-used design files
*  :\*/kernel:    kernel-related design files used in design * (for example, *xkcalc* or *xkcdc*)
*  :\*/interface: interface-related, pre-process-related or post-process-related design files used in design * (for example, *xkcalc* or *xkcdc*)
*  :\*/memory:    memory instantiations of different technologies (for example, TSMC65 or GF28) used in design * (for example, *xkcalc* or *xkcdc*)


Common
------

   Directory *common* contains design files like

   *  register-based single-port SRAMs (with or without byte enable)
   *  register-based two-port SRAMs
   *  register-based ack-type FIFOs
   *  register-based req-type FIFOs
   *  register-based delayers


Before Introduction to Kernel and Interface
-------------------------------------------

   |  In order to illustrate the contents contained in directory *kernel* and *interface*,
      I would like to give a simple introduction to design *add* and design *xkcdc*.
   |  The former is a simple combination of adder, substrator, multiplier, and dividor,
      while the latter is a complex video encoder.

   *  *xkcalc*

      .. image:: xkcalc.png
         :width: 800

      *  APB: APB-bus-to-register-access convertor (empty now)
      *  AXI: data-access-to-AXI-bus convertor (empty now)
      *  FTH: fetch (empty now)
      *  ADD: adder (almost empty)
      *  SUB: substrator (empty now)
      *  MUL: multiplier (empty now)
      *  DIV: dividor (empty now)
      *  DMP: dump (empty now)

   *  *xkcdc*

      .. image:: xkcdc.png
         :width: 1100

      *  APB: APB-bus-to-register-access convertor (empty now)
      *  AXI: data-access-to-AXI-bus convertor (empty now)
      *  SCL: scaler (empty now)
      *  OSD: on-screen display (empty now)
      *  FTH: fetch (empty now)
      *  RMD: rough mode decision (empty now)
      *  IME: integer motion estimation (empty now)
      *  FME: fractional motion estimation (empty now)
      *  RDO: rate-distortion optimization (empty now)
      *  REC: reconstruction (empty now)
      *  DBF: de-blocking filter (empty now)
      *  SAO: sample-adaptive offset (empty now)
      *  E_C: entropy encoding (empty now)
      *  DMP: dump (empty now)


\*/Kernel
---------

   Directory *kernel* contains all kernel-related design files.

   In design *xkcalc*, the following modules belongs to the kernel part since they belong to the core processing

   *  FTH
   *  ADD
   *  SUB
   *  MUL
   *  DIV
   *  DMP

   Due to the same reason, the following modules belongs to the kernel part of design *xkcdc*

   *  FTH
   *  RMD
   *  IME
   *  FME
   *  RDO
   *  REC
   *  DBF
   *  SAO
   *  E_C
   *  DMP


\*/Interface
------------

   Directory *kernel* contains all interface-related design files.

   In design *xkcalc*, the following modules belongs to the interface part
   since they either do the job of interface converting or belong to the pre/post-processing

   *  APB
   *  AXI

   Due to the same reason, the following modules belongs to the kernel part of design *xkcdc*

   *  APB
   *  AXI
   *  SCL
   *  OSD


\*/Memory
---------

   Directory *memory* contains memory instantiations of different technologies,
   which is managed with perl scripts.


Naming Rule
-----------

   All codes in design files use this naming rule

   ::

      [<(hierachy|tag)>_]<type>_<object>_<modifier0>_..._<modifierN>_[s?_][d?_][(i|o|w|r)]

#. |  <(hierachy|tags)> refer to the short name of hierarchies or tags, which usually use 3 letters.
   |  For example,
   |  wires directly connected to module *calc_add_top* can be prefixed with *ADD_*; variables related to adding      logic can be prefixed with *add_*;
   |  wires directly connected to module *calc_sub_top* can be prefixed with *SUB_*; variables related to substrating logic can be prefixed with *sub_*;
   |  wires directly connected to module *calc_mul_top* can be prefixed with *MUL_*; variables related to multiplying logic can be prefixed with *mul_*;
   |  wires directly connected to module *calc_div_top* can be prefixed with *DIV_*; variables related to dividing    logic can be prefixed with *div_*;
   |  wires directly connected to module *calc_reg*     can be prefixed with *REG_*;
   |  wires directly connected to module *calc_knl_top* can be prefixed with *KNL_*;
   |  wires directly connected to module *calc_itf_top* can be prefixed with *ITF_*;

#. <type> includes the following items, which use 3 letters.

   .. table::
      :align: left
      :widths: auto

      ======== ============= ============
       <type>   description   postscript
      ======== ============= ============
       flg      enabling      enabled if configured with 1
       num      number
       siz      size
       cnt      counter
       idx      index
       enm      enumerator
       dat      value
      ======== ============= ============

#. <object> refer to the short name of objects.
   For example,

   .. table::
      :align: left
      :widths: auto

      ========== =============
       <object>   description
      ========== =============
       frame      frame
       unit       unit
       reg        register
       scl        scaler
       delay      delay
      ========== =============

#. <modifier> refer to the short name of modifiers, which usually use 3 letters.
   For example,

   .. table::
      :align: left
      :widths: auto

      ============ =============
       <modifier>   description
      ============ =============
       max          maximum
       min          minimum
       bfr          before
       aft          after
       in           input
       out          output
      ============ =============

#. s? and d? refer to the short name of the ?th stage or delay respectively.

#. (i|o|w|r) refer to the short name of input, output, wire or reg respectively.

#. special cases

   *  FSM: cur_state_r and nxt_state_w are adopted
   *  counter done: cnt_done_w is adopted


Hierarchy
---------

#. The hierarchy of design files contains **three** levels, which are top level, interface/kernel level, and module level.

   *  |  In general, top-level design files contain only one file, which is the top of the whole design,
      |  for example, *calc_top.v* or *xkcdc_top.v*
   *  |  In general, kernel/interface-level design files contain only two files which are the top of interface-related and kernel-related design files,
      |  for example, *calc_knl_top.v* and *calc_itf_top.v* or *xkcdc_knl_top.v* and *xkcdc_itf_top.v*
   *  |  Module-level design files contain all design files related to the current module.
      |  For example, module RMD (rough mode decision) in design *xkcdc* contains

      *  *cdc_rmd_top.v*:                 top of RMD
      *  *cdc_rmd_ctl.v*:                 logic to do control
      *  *cdc_rmd_ref.v*:                 buffer for reference pixels and logic to do reference management
      *  *sram_sp_cdc_rmd_ref_buf_ref.v*: wrapper for the single-port SRAM instantiated in *cdc_rmd_ref.v* to buffer reference pixels
      *  *cdc_rmd_pre.v*:                 wrapper for prediciton modules
      *  *cdc_rmd_pre_knl.v*:             logic to do prediction
      *  *cdc_rmd_res.v*:                 logic to do residual calculation
      *  *cdc_rmd_cst.v*:                 wrapper for cost calculation moduels
      *  *cdc_rmd_cst_knl.v*:             logic to do cost calculation
      *  *cdc_rmd_cmp.v*:                 logic to do comparison

#. The hierarchy of memory instantiations also have **three** levels, which are memory-wrapper level, definition level, and instantiation level.

   ::

      <module_name>
      └── <memroy_type>_<design_name>_buf_<content_name>.v
             └── definitions
                    └── instantiations

   For example, one buffer which stores reference pixels is need in module cdc_rmd_ref.v, hierachy of which would be

   ::

      *cdc_rmd_ref.v*
      └── *sram_sp_cdc_rmd_ref_buf_ref.v*
             ├── `KNOB_LIB_BEHAVE
             │      └── sram_sp_behave.v
             ├── `KNOB_LIB_FPGA
             │      └── FPGA_INST_SRAM_SP_CDC_RMD_REF_BUF_REF_1024X32.v
             └── `KNOB_LIB_ASIC
                    └── ASIC_INST_SRAM_SP_CDC_RMD_REF_BUF_REF_1024X32.v

   Noting that modules in the instantiation level would be marked with the implementation platform, design, buffer content, and size.

   Here are the detailed contents of *sram_sp_cdc_rmd_ref_buf_ref.v*

   *  *sram_sp_cdc_rmd_ref_buf_ref.v*

      overview

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: buf_full.png
         :width: 785

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: buf_001.png
         :width: 775

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: buf_051.png
         :width: 775

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: buf_101.png
         :width: 775

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: buf_151.png
         :width: 1050

      \


Detailed Rules
--------------

   Contents of *cdc_rmd_top.v*, *cdc_rmd_ctl.v* and *cdc_rmd_cst_knl.v* are provided to illustrate the detailed rules of design codes.

   *  *cdc_rmd_top.v*

      overview

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_full.png
         :width: 780

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_001.png
         :width: 800

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_051.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_101.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_151.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_201.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_251.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_301.png
         :width: 680

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_351.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_401.png
         :width: 680

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_451.png
         :width: 670

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_501.png
         :width: 660

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_551.png
         :width: 1000

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: top_601.png
         :width: 780

   *  *cdc_rmd_ctl.v*

      overall

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_full.png
         :width: 800

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_001.png
         :width: 810

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_051.png
         :width: 780

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_101.png
         :width: 910

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_151.png
         :width: 760

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_201.png
         :width: 900

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: ctl_251.png
         :width: 780

   *  *cdc_rmd_cst_knl.v*

      overall

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_full.png
         :width: 800

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_001.png
         :width: 1250

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_051.png
         :width: 750

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_101.png
         :width: 1340

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_151.png
         :width: 1450

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_201.png
         :width: 1530

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_251.png
         :width: 920

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_301.png
         :width: 1040

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_351.png
         :width: 780

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_401.png
         :width: 910

      \

      .. +++++++++++++++ uncommented to help the decision of width

      .. image:: cst_451.png
         :width: 650
