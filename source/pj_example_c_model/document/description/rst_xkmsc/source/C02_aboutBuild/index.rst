.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about build
   ..
.. -----------------------------------------------------------------------------

About Build
===========

   Directory *build* contains **two** different kinds of environments.

*  :linux: Linux-based build environments
*  :windows: Windows-based build environments


Existing Environments
---------------------

   Information on several existing environments is listed below.

linux/xkmsc
```````````

*  Function

   #. generate and run executable file *xkmsc* under Linux OS

*  Dependency

      .. table::
         :align: left
         :widths: auto

         ========== ============
          item       my version
         ========== ============
          gcc, g++   11.4.0
          Make       4.3
          cmake      3.22.1
         ========== ============

*  Content

      .. table::
         :align: left
         :widths: auto

         ========== =============
          item       description
         ========== =============
          build.sh   build script
          run.sh     (single-)run script
         ========== =============

*  Usage

      |  In WSL environment, change directory to *build/linux/xkmsc*,
      |  then you can

   #. create a building environment with

      ::

         ./build.sh

      then you will get

      .. \++++++ uncommented to help the decision of width

      .. image:: buildLinux_Usage1.png
         :width: 700

   #. generate executable file *xkmsc* with

      ::

         make

      then you will get

      .. \++++++ uncommented to help the decision of width

      .. image:: buildLinux_Usage2.png
         :width: 1100

   #. run executable file *xkmsc* (with a given configuration setting) with

      ::

         ./xkmsc -c ../../../script/run/runXkmsc/xkmsc.cfg

      then you will get

      .. \++++++ uncommented to help the decision of width

      .. image:: buildLinux_Usage3.png
         :width: 540

   #. |  Sure, to run with a different configuration setting,
      |  you can either change the contents of configuration file *xkmsc.cfg* or overwrite them through CLI (command-line interface).
      |  For example,

      ::

         ./xkmsc -c ../../../script/run/runXkmsc/xkmsc.cfg --numFrame 3

      .. \++++++ uncommented to help the decision of width

      .. image:: buildLinux_Usage4a.png
         :width: 650

      |  Besides, I have created a (single-)run script *run.sh* which would execute the above steps one by one.
      |  Build parameters can be passed through -B "...";
      |  Run parameters can be passed through -R "...".
      |  For example,

      ::

         ./run.sh -R "--numFrame 5"

      .. \++++++ uncommented to help the decision of width

      .. image:: buildLinux_Usage4b.png
         :width: 700


windows/xkmsc (Optional)
````````````````````````

   To Be Updated

   .. *  Function

   ..    #. generate and run executable file *xkmsc* under Windows OS

   .. *  Dependency

   ..       .. table::
   ..          :align: left
   ..          :widths: auto

   ..          =============== ============
   ..          item            my version
   ..          =============== ============
   ..          CMake           3.21.0
   ..          Visual Studio   2017-15.9.37
   ..          =============== ============

   .. *  Content

   ..       .. table::
   ..          :align: left
   ..          :widths: auto

   ..          =============== =============
   ..          item            description
   ..          =============== =============
   ..          build_2017.dat  VS_2017 build script
   ..          build_2019.dat  VS_2019 build script
   ..          =============== =============

   .. *  Usage

   ..       |  In Windows Explorer, change directory to *build/windows/xkmsc*,
   ..       |  then you can

   ..    #. |  double click the corresponding build.bat to create a building environment
   ..       |  (choose build_2017.bat if Visual Studio 2017 is installed)
   ..       |  (choose build_2019.bat if Visual Studio 2019 is installed)

   ..       .. image:: buildWindows_Usage1.png
   ..          :width: 1000

   ..    #. open solution file *xkmsc.sln*

   ..       .. image:: buildWindows_Usage2.png
   ..          :width: 800

   ..    #. right click on solution *xkmsc* and set it as the startup item

   ..       .. image:: buildWindows_Usage3.png
   ..          :width: 800

   ..    #. right click on solution *xkmsc* and click *properties*, then add

   ..       ::

   ..          -c ../../../script/run/runXkmsc/xkmsc.cfg

   ..       |  to the command-line parameter
   ..       |  (both slash and backslash can be recognized)

   ..       .. image:: buildWindows_Usage4a.png
   ..          :width: 800

   ..       .. image:: buildWindows_Usage4b.png
   ..          :width: 800

   ..    #. click button *Start* or press key *F5* to generate executable file *xkmsc* and run it with the given configuration setting

   ..       .. image:: buildWindows_Usage5.png
   ..          :width: 900
