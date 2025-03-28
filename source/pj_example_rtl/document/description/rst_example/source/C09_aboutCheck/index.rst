.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about check
   ..
.. -----------------------------------------------------------------------------

About Check
===========

   Directory *check* contains **two** different kinds of check environments.

*  :formality: Formality based check environments
*  :spyglass: Spyglass based check environments


Existing Environments
---------------------

fm_calc_add_knl
```````````````

*  Function

   #. check design *calc_add_knl* with Formality

*  Content

      .. table::
         :align: left
         :widths: auto

         ========================== ============================================== ============
          item                       description                                    postscript
         ========================== ============================================== ============
          script/makefile.mk         mother makefile
          script/top.tcl             entry script of Formality Tcl
          script/lst2Tcl.pl          script to convert file list to Formality Tcl
          fm_calc_add_knl/makefile   daughter makefile
          fm_calc_add_knl/session    check session                                  generated by command *make chk*
         ========================== ============================================== ============

*  Dependency

      .. table::
         :align: left
         :widths: auto

         ========== ============
          item       my version
         ========== ============
          make       3.82
          spyglass   N-2017.12-SP2 for Linux
         ========== ============

*  Usage

      |  On the Linux server, change directory to check/formality/fm_calc_add_knl,
      |  then you can

   #. view help with

      ::

         make

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: fm_make.png
         :width: 465

   #. check with

      ::

         make chk

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: fm_make_chk_0.png
         :width: 655

      \.\.\.

      .. image:: fm_make_chk_1.png
         :width: 690

   #. view configuration value with

      ::

         make cfg_view

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: fm_make_cfg_view.png
         :width: 1130

   #. clean files with

      ::

         make clean

      or

      ::

         make clean_all

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: fm_make_clean.png
         :width: 845

sg_calc_add_knl
```````````````

*  Function

   #. check design *calc_add_knl* with Spyglass

*  Content

      .. table::
         :align: left
         :widths: auto

         ================================= ============================================= ============
          item                              description                                   postscript
         ================================= ============================================= ============
          script/makefile.mk                mother makefile
          script/lst2Tcl.pl                 script to convert file list to Spyglass Tcl
          script/analyzeReport.pl           script to analyze Spyglass reports
          fm_calc_add_knl/makefile          daughter makefile
          fm_calc_add_knl/rule.lst          Spyglass rule list
          fm_calc_add_knl/setCst.sgdc       constraints related Spyglass Tcl
          fm_calc_add_knl/session           check session                                 generated by command *make com* or *make chk*
          fm_calc_add_knl/session/top.tcl   entry script of Spyglass Tcl                  generated by command *make com* or *make chk*
         ================================= ============================================= ============

*  Dependency

      .. table::
         :align: left
         :widths: auto

         =========== ============
          item        my version
         =========== ============
          make        3.82
          formality   Q-2019.12-SP5
         =========== ============

*  Usage

      |  On the Linux server, change directory to check/spyglass/sg_calc_add_knl,
      |  then you can

   #. view help with

      ::

         make

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make.png
         :width: 705

   #. compile with

      ::

         make com

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make_com.png
         :width: 880

   #. check with

      ::

         make chk

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make_chk.png
         :width: 880

   #. view check results with

      ::

         make chk

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make_chk_view.png
         :width: 745

   #. view configuration value with

      ::

         make cfg_view

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make_cfg_view.png
         :width: 915

   #. clean files with

      ::

         make clean

      or

      ::

         make clean_all

      then you will get

      .. +++++++++++++++++++ uncommented to help the decision of width

      .. image:: sg_make_clean.png
         :width: 840
