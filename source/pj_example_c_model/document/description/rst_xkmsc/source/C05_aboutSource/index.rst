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

   Directory *source* contains **four** kinds of source files.

*  :top: responsible for configuration management and multiple-frame processing.
*  :kernel: responsible for single-frame/multiple-unit processing.
*  :unit: responsible for single-unit processing.
*  :common: responsible for underlying processes.

   ("Frame" here refers to multiple units. "Unit" here refers to the basic block processed by each module.)


Common
------

   |  Directory *common* contains collection *COMMON*,
   |  which is made up of definitions, types, enumerators, structs, tables, and functions
   |  used for information acquiring, data processing, cost calculating, and other underlying processes


Unit
----

   |  Directory *unit* contains class *UNIT* and its inheritors.
   |  As a C model, it should emulate the behaviors of RTL,
   |  while a key feature of RTL is that they usually have several modules and those modules work in a pipeline.
   |  So I create a basic class called *UNIT* and it acts like RTL modules in the following way.

   .. image:: classUnit.png
      :width: 900

   *  | In phase *new*
      | all *UNITs* are newed with their constructor function, which would allocate spaces and assign initial value.
   *  | In phase *connect*
      | all *UNITs* are connected with function *connect*, which would note down the address of its previous *UNITs* according to the pipeline structure
   *  | In phase *run*
      | each *UNIT* would call function *load* to load data from its previous *UNITs* or from files.
      | each *UNIT* would call function *proc* to process those data.
      | each *UNIT* would call function *dump* to dump data to files.
   *  | In phase *delete*
      | all *UNITs* are deleted with their deconstructor function, which would release spaces.

   | Sure, apart from the above common behaviors,
   | those *UNITs* should have some different behaviors to act like different modules in RTL.
   | Fortunately, this can be realized easily by class inheriting.


Kernel
------

   Directory *kernel* contains 3 classes.

*  class *KNL* is responsible for single-frame/multiple unit processing.
*  class *FTH* is responsible for single-frame/multiple unit data fetching.
*  class *DMP* is responsible for single-frame/multiple unit data dumping.


Top
---

   Directory *top* contains file *msc.cpp* and struct *CFG*.

file *msc.cpp*
``````````````

   It is responsible for multiple-frame processing.


struct *CFG*
````````````

   It is responsible for configuration management.

   |  During the development of C models, configurations may update frequently.
   |  To reduce the efforts spent on it, I created a script called *cfg.pl* to maintain them.

   .. image:: structCfg.png
      :width: 850

   where

   .. table::
      :align: left
      :widths: auto

      ================== =============
       name               description
      ================== =============
       msc_cfg.cpp        | source file containting function *cfgIni*, *cfgIniFromFile* and *cfgIniFromCli*
                          | the former one calls the latter two and all the functions in file cfg_proc.cpp to
                          | initialize struct *CFG* according the contents in configuration files and the parameters in command line interface
       msc_cfg.csv        | information file containing the
                          | domain, name, (opening) level, size, short name, type,
                          | minimum value, maximum value, precision, default value and description of each configuration
       msc_cfg.pl         | script to
                          | generate file *msc_cfg.hpp*, *msc_cfg_type.hpp*, *msc_cfg_proc.cpp*, *msc_cfg.rst* and *xkmsc.cfg*
                          | according to file *msc_cfg.csv*
       msc_cfg.hpp          header file containing the decaration of functions
       msc_cfg_type.hpp     header file containing the decaration of struct *CFG*
       msc_cfg_proc.cpp   | source file containing the definition of
                          | function *cfgRst*, used to reset struct *CFG* to the default value
                          | function *cfgHlp*, used to print help information
                          | function *cfgMap*, used to map key-value pair into struct *CFG*
                          | function *cfgChk*, used to check sanity of struct *CFG*'s value
                          | function *cfgLog*, used to print struct *CFG*'s value
       msc_cfg.rst          table file in restructedText format
       xkmsc.cfg            configuration file to be read by the executable file *msc*
      ================== =============

   |  As shown in the above figure and table, only one file needs to be manually maintained frequently,
   |  which largely reduces the burden to manage configurations


Other Information
-----------------

   Other Information is given below.

Hierarchy
`````````

   .. image:: hierarchy.png
      :width: 600

Naming Rule
```````````

*  macro-definitions

   ::

      [<class>_]<type>_<object>[_<modifier1>][_<modifier2>]...[_<modifierN>]

   where,

   .. table::
      :align: left
      :widths: auto

      ========== =========================
       item       description
      ========== =========================
       class      short name of class
       type       allowed strings include "KNOB", "FLAG", "NUMB"(number), "SIZE", "ENUM"(enumerator), "DATA", "FUNC"(function)
       object     allowed strings include "Frame", "Unit"
       modifier   allowed strings include "MAX"(maximum), "MIN"(minimum), "EXT"(extended), "X", "Y", "WD"
      ========== =========================

*  variables

   ::

      [<classification>_]<type>_<object>[_<domain>][_<modifier1>][_<modifier2>]...[_<modifierN>]

   where,

   .. table::
      :align: left
      :widths: auto

      ================ =========================
       item             description
      ================ =========================
       classification   allowed strings include "m\_"(member), "s\_"(static table)
       type             allowed strings include "flg"(flag), "num"(number), "idx"(index), "siz"(size), "enm"(enumerator), "dat"(data)
       object           allowed strings include "Ori"(original data), "Coe"(coefficient data)
       domain           allowed strings include "Frame", "Unit"
       modifier         allowed strings include "Ext"(extended), "Ful"(full), "All", "Cur"(current), "Bst"(best), "Bfr"(before), "Aft"(after)
      ================ =========================

*  functions

   ::

      [<operation>_]<type>_<object>[_<domain>][_<modifier1>][_<modifier2>]...[_<modifierN>]

   where,

   .. table::
      :align: left
      :widths: auto

      =========== ============================
       item        description
      =========== ============================
       operation   allowed strings include "cpy"(copy), "get", "upd"(update)
       type        allowed strings include "flg"(flag), "num"(number), "idx"(index), "siz"(size), "enm"(enumerator), "dat"(data)
       object      allowed strings include "Ori"(original data), "Coe"(coefficient data)
       domain      allowed strings include "Frame", "Unit"
       modifier    allowed strings include "Ext"(extended), "Ful"(full), "All", "Cur"(current), "Bst"(best), "Bfr"(before), "Aft"(after)
      =========== ============================


Configuration
`````````````

   .. table::
      :align: left
      :widths: auto

      .. include:: ../../../../../source/xkmsc/top/configuration/msc_cfg.rst

Macro-Definition
````````````````

   .. table::
      :align: left
      :widths: auto

      ======== ================= ======================
       Domain   Name              Description
      ======== ================= ======================
       TOP      | KNOB\_...       | knob of ...
                | FLAG\_...       | flag for ...
                | NUMB\_...       | number of ...
                | SIZE\_...       | size of ...
                | ENUM\_...       | enumerator for ...
                | DATA\_...       | data of ...
                | FUNC\_...       | function of ...
                | ...             | ...
       KERNEL   | KNOB\_...       | knob of ...
                | FLAG\_...       | flag for ...
                | NUMB\_...       | number of ...
                | ...             | ...
       UNIT     | ...             | ...
       COMMON   | ...             | ...
      ======== ================= ======================

   Please refer to *source/common/common.hpp* for more information.
