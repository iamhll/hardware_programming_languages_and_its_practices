.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about synthesis
   ..
.. -----------------------------------------------------------------------------

About Synthesis
===============

   Directory *synthesis* contains **three** different kinds of synthesis environments.

*  :design_compiler: Design Compiler based synthesis environments
*  :vivado: Vivado based synthesis environments
*  :quartus: Quartus based synthesis environments


Existing Environments
---------------------

dc_calc_add_knl
```````````````

*  Function

   #. synthesize design *calc_add_knl* with DC

*  Content

      .. table::
         :align: left
         :widths: auto

         ================================ ==================================================== ============
          item                             description                                          postscript
         ================================ ==================================================== ============
          script/makefile.mk               mother makefile
          script/top.tcl                   entry script of DC Tcl
          script/lst2Tcl.pl                script to convert file list to DC Tcl
          script/check_VER-318.sh          script to filter VER-318 warnings
          dc_calc_add_knl/makefile         daughter makefile
          dc_calc_add_knl/setCst.tcl       constraint related DC Tcl
          dc_calc_add_knl/setPth.tcl       timing path related DC Tcl
          dc_calc_add_knl/session_2.000    synthesis session with a clock period of 2.000 ns    generated by *make syn*
          dc_calc_add_knl/session_10.000   synthesis session with a clock period of 10.000 ns   generated by *make syn DATA_PRD_CLK=10.000*
         ================================ ==================================================== ============

*  Dependency

      .. table::
         :align: left
         :widths: auto

         ================= ============
          item              my version
         ================= ============
          make              3.82
          design compiler   Q-2019.12-SP5
         ================= ============

*  Usage

      |  Change directory to synthesis/design_compiler/dc_calc_add_knl,
      |  then you can

   #. view help with

      ::

         make

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make.png
         :width: 575

   #. synthesize with

      ::

         make syn

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make_syn_0.png
         :width: 725

      \.\.\.

      .. image:: dc_make_syn_1.png
         :width: 860

   #. view synthesis results (brief) with

      ::

         make syn_view

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make_syn_view_0.png
         :width: 485

      Other results are located in directory *log*, *rpt*, *rlt* under the generated session.

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make_syn_view_1.png
         :width: 1400

   #. view configuration value with

      ::

         make cfg_view

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make_cfg_view.png
         :width: 1110

   #. clean files with

      ::

         make clean

      or

      ::

         make clean_all

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: dc_make_clean.png
         :width: 965

qt_calc_add_knl
```````````````

   TO BE ADDED

vv_calc_add_knl
```````````````

   TO BE ADDED
