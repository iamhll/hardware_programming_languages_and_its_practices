.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : how to
   ..
.. -----------------------------------------------------------------------------

How-To
======

How to select "columnly"
------------------------

   #. Holding key *Shift* and *Alt*, and then you can select "columnly":

      .. image:: howToSelectColumnly_step1.png
         :width: 800


How to rename
-------------

   #. |   Put cursor on the variable or function you want to rename and press key F2.
      |   (or right click on it, and then click item *rename*)
      |   Enter a new name and press key *Enter*

      .. image:: howToRename_step1.png
         :width: 800

   #. Confirm the list and click button *apply*

      .. image:: howToRename_step2.png
         :width: 800

   #. Do not forget to save those changes, if setting *auto save* is not enabled


How to diff
-----------

   *  With command *git diff*

      #. Execute

         ::

            git diff <SHA1 ID of the commit you want to diff with>

   *  With command *git reset*

      #. Execute

         ::

            git reset <SHA1 ID of the commit you want to diff with>

      #. Do not forget to reset back with

         ::

            git reset ORIG_HEAD


How to revert partially
-----------------------

   #. Open the "diff" view

      .. image:: howToRevertChangePartially_step1.png
         :width: 800

   #. Choose the changes you want to revert, right click on them, and then click item *revert the selected changes*

      .. image:: howToRevertChangePartially_step2.png
         :width: 800

   #. Do not forget to save those changes, if setting *auto save* is not enabled


How to get a simple history
---------------------------

   #. Execute

      ::

         gitk --all &

   #. Click item *View* and then click item *Edit view...* or Press F4 directly.

   #. Click item *Simple history* and then click button *ok*.

   #. Sure, the above steps can be replaced with the following command:

      ::

         gitk --all --simplify-by-decoration &


How to sync
-----------

   #. Fetch and prune

      ::

         git fetch --all
         git remote prune origin

   #. Checkout

      ::

         git checkout <the branch you want to synchronize>

   #. Three different situations may happen

      *  If you want the remote only, execute

         ::

            git reset --hard origin/<the branch you want to synchronize>

      *  If you want the "local" only, execute

         ::

            git push -f [origin <the branch you want to synchronize>]

      *  If you want both of them, execute

         ::

            git pull --rebase

         or

         ::

            git rebase origin/<the branch you want to synchronize>

         Then fix conflicts with

         ::

            <edit>
            git add
            git rebase --continue

         or

         ::

            git rebase --skip

         Finally, push it with

         ::

            git push [origin <the branch you want to synchronize>]


How to make a "shortcut"
------------------------

   To Be Added
