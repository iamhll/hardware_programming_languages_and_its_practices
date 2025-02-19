.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : before everything
   ..
.. -----------------------------------------------------------------------------

Before Everything
=================

   Please get the following items ready before you start.


WSL
---

#. enable the developer mode

   .. image:: WSL_step1.png
      :width: 800

#. enable WSL function (Hyper-V, Virtual Machine Platform or Windows Hypervisor Platform may also be needed)

   .. image:: WSL_step3.png
      :width: 800

#. install Ubuntu (please install **22.04** version)

   .. image:: WSL_step2.png
      :width: 800

#. open Ubuntu

   for the first time, it will install itself and ask you to create a default user account

   .. image:: WSL_step4.png
      :width: 800

   if there is some thing wrong with this step, you may need enter the following code in "Windows PowerShell" to update WSL

   ::

      wsl --update

   you can also enter the following code in "Windows PowerShell" to re-install Ubuntu

   ::

      wsl --unregister Ubuntu-22.04

   the upper code assumes that your Ubuntu distribuiton is Ubuntu-22.04

   you can enter the following code in "Windows PowerShell" to check the distribuiton

   ::

      wsl --list

#. install linux basic tools

   ::

      sudo apt-get update
      sudo apt-get -f install
      sudo apt-get upgrade
      sudo apt-get install cmake ffmpeg g++ gcc gdb gitk make python3 python3-pip tree --fix-missing

   if this step is very slow, you can try changing apt source:

      open file */etc/apt/sources.list* with root privilege

      ::

         sudo vi /etc/apt/sources.list

      replace

      ::

         http://archive.ubuntu.com/ubuntu/

      with

      ::

         http://mirrors.aliyun.com/ubuntu/

#. install basic python library

   ::

      pip3 install numpy sphinx


   if it is very slow, you can try changing pip source:

      temporarily change pip source with

      ::

         pip3 install numpy sphinx -i https://mirrors.aliyun.com/pypi/simple

      or

      permenantly change pip source with

      ::

         pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
         pip config set install.trusted-host mirrors.aliyun.com

#. change some settings (optional)

   *  open file *~/.bashrc* with root privilege

      ::

         sudo vi ~/.bashrc

   *  replace

      ::

         PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

      with

      ::

         PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\W\[\033[00m\]\$ '


Git (Optional)
--------------

#. install Git and TortoiseGit

   .. image:: Git_step1a.png
      :width: 500

   (https://git-scm.com/downloads)

   .. image:: Git_step1b.png
      :width: 500

   (https://tortoisegit.org/download/)


Xming (Unnecessray for WSL2)
----------------------------

   it is **unnecessray** for WSL2.

   you can enter the following code in "Windows PowerShell" to check WSL version

   ::

      wsl --list --verbose

#. install Xming

   .. image:: Xming_step1.png
      :width: 500

   (http://www.straightrunning.com/XmingNotes/)

#. set global variable *DISPLAY*

   *  open *~/.bashrc* with root privilege
   *  add

      ::

         export DISPLAY=:0.0


VS Code
-------

#. install VS Code

   .. image:: VSCode_step1.png
      :width: 500

   (https://code.visualstudio.com/Download)

#. open VS code and connect it to WSL (this step will automatically install "WSL" extension)

   .. image:: VSCode_step2.png
      :width: 800

#. install "C/C++" extension in WSL (if not connected to mode, click the bottom-left corner and choose "connected to WSL")

   .. image:: VSCode_step3.png
      :width: 800

#. install other extensions (optional)

   *  Better Comments
   *  Binary
   *  C/C++
   *  Chinese (Simplified) Language Pack for Visual Studio code
   *  Excel Viewer
   *  Git History
   *  Jupyter
   *  Tcl
   *  Verilog-HDL/SystemVerilog/Bluespec SystemVerilog
   *  vscode-pdf
   *  ...

#. change some settings (optional but recomended)

   *  enable *Indent Using Spaces* (open an arbitrary file, press key *ctrl*\ +\ *shift*\ +\ *p* and search it)
   *  disable *C_Cpp: Code Folding* of *C/C++* extension (open *C/C++*\ 's settings and search it)
   *  ...

#. download *pj_example_c_model.tar* and put it to your home directory

   .. image:: VSCode_step4.png
      :width: 800

#. decompress it

   ::

      tar -zxf pj_example_c_model.tar

#. open it with VS code connected to WSL (if not connected to mode, click the bottom-left corner and choose "connected to WSL")

   .. image:: VSCode_step5.png
      :width: 800

#. open file *source/top/msc.cpp*

   .. image:: VSCode_step6.png
      :width: 800

#. press F5 to run gdb (it seems WSL1 does not support gdb. to fix it, you can update it to WSL2 with "wsl --update" in "Windows PowerShell" environment)

   .. image:: VSCode_step7.png
      :width: 800
