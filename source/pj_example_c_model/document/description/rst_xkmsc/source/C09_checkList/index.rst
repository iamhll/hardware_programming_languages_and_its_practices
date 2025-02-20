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
      | task           | task definition     | The manager should make the target, content, date and owner as clear as possible.                          |
      | assignment     +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | branch creation     | The manager should create a task branch.                                                                   |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
      | implementation | sub-branch creation | | If multiple owners or modules are involved,                                                              |
      |                |                     | |   the owners should create sub-branches postfixed with module/owner,                                     |
      |                |                     | |   (for example, *undergoing/update/source/xxx/implement/ADD/HLL*)                                        |
      |                |                     | | otherwise,                                                                                               |
      |                |                     | |   the owner could directly work on the branch created by the manager.                                    |
      |                |                     | |   (for example, *undergoing/update/source/xxx/implement/master*)                                         |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | edit                | | The owner should split his/her edits into atomic ones.                                                   |
      |                |                     | | The owner should edit according to the coding style and template.                                        |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | commit              | | The owner should execute the script-based udpate list.                                                   |
      |                |                     | |   *cd script/run/runListUpdate; ./runListUpdate.sh*                                                      |
      |                |                     | | The owner should avoid compilation warnings.                                                             |
      |                |                     | |   *cd build/linux/xxx; ./build.sh; make*                                                                 |
      |                |                     | | The owner should make the single run results matching with expectation.                                  |
      |                |                     | |   *cd build/linux/xxx; ./run.sh*                                                                         |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | push                | | The owner should make the regression run results match expectations.                                     |
      |                |                     | |   *cd script/run/runXXX; make run*                                                                       |
      |                |                     | | The owner should save the regression run results under document/performance, if they have any changes.   |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | feedback            | | The owner should report the degree of completion in regular meetings.                                    |
      |                |                     | | The owner should notify the corresponding manager once he/she finishes the task.                         |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
      | branch review  | review              | | The manager should re-check the results of compilations, single runs, and regression runs.               |
      | and merging    |                     | | The manager should review changes by "differing" the final commit with the corresponding starting point. |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | feedback            | | If anything improper is noticed,                                                                         |
      |                |                     | |   the manager should discuss with the corresponding owner and directly note down TODOs in code files;    |
      |                |                     | |   the owner should modify his/her implementation accordingly.                                            |
      |                |                     | | If nothing improper is noticed,                                                                          |
      |                |                     | |   the manager should merge the task branch.                                                              |
      |                +---------------------+------------------------------------------------------------------------------------------------------------+
      |                | task branch merging | | The manager should rebase the task branch onto the master branch.                                        |
      |                |                     | | The manager should re-check the results of compilations, single runs, and regression runs.               |
      |                |                     | | The manager should review and minimize differences with the master branch.                               |
      |                |                     | | The manager should add changing histories to the head of related files.                                  |
      |                |                     | | The manager should update the version number and descriptions in function *logo* if necessary.           |
      |                |                     | | The manager should execute the script-based update list.                                                 |
      |                |                     | | The manager should re-check the results of compilations, single runs, and regression runs.               |
      |                |                     | | The manager should change the branch prefix from *undergoing* to *merged* and protect this branch.       |
      |                |                     | | The manager should make a "shortcut" commit on the master branch.                                        |
      |                |                     | | The manager should create a tag if necessary.                                                            |
      |                |                     | | The manager should notice other co-developers to rebase their branches.                                  |
      +----------------+---------------------+------------------------------------------------------------------------------------------------------------+
