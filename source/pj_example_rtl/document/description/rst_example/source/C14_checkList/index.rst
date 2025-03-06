.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : check list
   ..
.. -----------------------------------------------------------------------------

Check List
==========

Development Flow
----------------

   .. table::
      :align: left
      :widths: auto

      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
      | Main Step      | Sub Step            | Check List                                                                                                 |
      +================+=====================+============================================================================================================+
      | task           | task definition     | The manager should make the target, content, date, and owner as clear as possible.                         |
      | assignment     +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | branch creation     | The manager should create a task branch.                                                                   |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
      | implementation | sub-branch creation | | If multiple owners or modules are involved,                                                              |
      |                |                     | |   the owner should create sub-branches postfixed with <module>/<owner>,                                  |
      |                |                     | |   (for example, *undergoing/update/source/xxx/implement/ADD/HLL*)                                        |
      |                |                     | | otherwise,                                                                                               |
      |                |                     | |   the owner could directly work on the branch created by the manager.                                    |
      |                |                     | |   (for example, *undergoing/update/source/xxx/implement/master*)                                         |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | edit                | | The owner should split his/her edits into atomic ones.                                                   |
      |                |                     | | The owner should edit according to the coding style and template.                                        |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | commit              | | The owner should execute the script-based udpate list and check the logs                                 |
      |                |                     | |   *cd script; ./runListUpdate.sh;*                                                                       |
      |                |                     | | The owner should execute the script-based check list and check the logs                                  |
      |                |                     | |   *cd script; ./runListCheck.sh;*                                                                        |
      |                |                     | | The owner should pass compilation                                                                        |
      |                |                     | |   *cd simulation/rtl/rtl_xxx; make com_view*                                                             |
      |                |                     | |   *cd simulation/rtl/rtl_xxx; make com_view EDA_CSTR_TOOL=syn*                                           |
      |                |                     | |   *cd simulation/rtl/rtl_xxx; make chk_view*                                                             |
      |                |                     | | The owner had better pass simulation, especially for incremental changes or optimization.                |
      |                |                     | |   *cd simulation/rtl/rtl_xxx; make sim*                                                                  |
      |                |                     | |   *cd simulation/rtl/rtl_xxx; make sim EDA_CSTR_TOOL=syn*                                                |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | push                | | The owner should make the check and synthesis results match expectations.                                |
      |                |                     | |   *cd check/spyglass/sg_xxx; make chk* then *make chk_view*                                              |
      |                |                     | |   *cd synthesis/design_compiler/dc_xxx; make syn* then *make syn_view*                                   |
      |                |                     | |   *cd check/formality/fm_xxx; make chk* then *make chk_view*                                             |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | feedback            | | The owner should report the degree of completion in regular meetings.                                    |
      |                |                     | | The owner should notify the corresponding manager once he/she finishes the task.                         |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
      | branch review  | review              | | The manager should re-check the results of simulations, checks, and syntheses.                           |
      | and merging    |                     | | The manager should perform two more operations                                                           |
      |                |                     | |   *cd synthesis/quartus/qt_xxx; make syn*, several manual operations then *make syn_view*                |
      |                |                     | |   *cd synthesis/vivado/vv_xxx; make syn* then several manual operations                                  |
      |                |                     | | The manager should review changes by "differing" the final commit with the corresponding starting point. |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | feedback            | | If anything improper is noticed,                                                                         |
      |                |                     | |   the manager should discuss with the corresponding owner and directly note down TODOs in code files;    |
      |                |                     | |   the owner should modify his/her implementation accordingly.                                            |
      |                |                     | | If nothing improper is noticed,                                                                          |
      |                |                     | |   the manager should merge the task branch.                                                              |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | task branch merging | | The manager should rebase the task branch onto the master branch.                                        |
      |                |                     | | The manager should re-check the results of simulations, checks, and syntheses.                           |
      |                |                     | | The manager should review and minimize differences with the master branch.                               |
      |                |                     | | The manager should add changing histories to the head of related files.                                  |
      |                |                     | | The manager should update the design version defined in file *define_calc.vh* if necessary.              |
      |                |                     | | The manager should execute the script-based update list and check list.                                  |
      |                |                     | | The manager should re-check the results of simulations, checks, and syntheses.                           |
      |                |                     | | The manager should change the branch prefix from *undergoing* to *merged* and protect this branch.       |
      |                |                     | | The manager should make a "shortcut" commit on the master branch.                                        |
      |                |                     | | The manager should create a tag if necessary.                                                            |
      |                |                     | | The manager should notice other co-developers to rebase their branches.                                  |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | patch               | | The owner should regression the master branch.                                                           |
      |                |                     | | If regression fails                                                                                      |
      |                |                     | |   the owner should fix it                                                                                |
      |                |                     | |   the manager should make a patch directly on the master branch                                          |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
