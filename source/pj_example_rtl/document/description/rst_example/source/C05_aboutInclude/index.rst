.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : about script
   ..
.. -----------------------------------------------------------------------------

About Include
=============

   Directory *include* contains definitions and top-level parameters.


Naming Rule
-----------

   All definitions and parameters use this naming rule

   ::

      [<hierachy>_]<type>_<object>_<modifier0>_..._<modifierN>[_(WD|BP)]

#. |  <hierachy> refer to the short name of hierarchies, which usually use 3 letters.
   |  For example,
   |  hierachy *calc_add_top* related definitions and parameters can be prefixed with *ADD_*;
   |  hierachy *calc_sub_top* related definitions and parameters can be prefixed with *SUB_*;
   |  hierachy *calc_mul_top* related definitions and parameters can be prefixed with *MUL_*;
   |  hierachy *calc_div_top* related definitions and parameters can be prefixed with *DIV_*;
   |  hierachy *calc_reg* related definitions and parameters can be prefixed with *CTL_* (control registers), *CFG_* (configuration registers) and *FDB_* (feedback regsiters);
   |  hierachy *calc_knl_top* related definitions and parameters can be prefixed with *KNL_*;
   |  hierachy *calc_itf_top* related definitions and parameters can be prefixed with *ITF_*;
   |  hierachy *calc_top* related definitions and parameters can be prefixed with *TOP_*, but it is usually omitted.

#. <type> includes the following items, which use 4 letters.

   .. table::
      :align: left
      :widths: auto

      ======== ============= ============
       <type>   description   postscript
      ======== ============= ============
       KNOB     existence     exists if defined
       FLAG     enabling      enabled if configured with 1
       NUMB     number
       SIZE     size
       ENUM     enumerator
       DATA     value
       CSTR     string
       FUNC     function
      ======== ============= ============

#. <object> refer to the short name of objects.
   For example,

   .. table::
      :align: left
      :widths: auto

      ========== =============
       <object>   description
      ========== =============
       FRAME      frame
       UNIT       unit
       REG        register
       SRAM       sram
       SCL        scaler
       DELAY      delay
      ========== =============

#. <modifier> refer to the short name of modifiers, which usually use 3 letters.
   For example,

   .. table::
      :align: left
      :widths: auto

      ============ =============
       <modifier>   description
      ============ =============
       MAX          maximum
       MIN          minimum
       BFR          before
       AFT          after
       IN           input
       OUT          output
      ============ =============


Hierarchy
---------

   The hierarchy of this RTL example's definitions contains **three** levels, which are top level, IP level, and module level.

*  Top-level definitions are collected in file *define.vh* and shared by all the designs.
*  IP-level definitions are collected in file *define_calc.vh* and shared by all the designs under *calc_top*.
*  Module-level definitions are collected in file *define_calc_add.vh*, *define_calc_sub.vh*, *define_calc_mul.vh*, *define_calc_div.vh*
   and shared by all the designs under *calc_add*, *calc_sub*, *calc_mul* and *calc_div* respectively.

include iteratively
```````````````````

   |  Obviously,
   |  designs which includes file *define_calc_add.vh* must include file *define_calc.vh*,
   |  designs which includes file *define_calc.vh* must include file *define.vh*.

   |  As a result, I directly
   |  include file *define.vh* in file *define_calc.vh*,
   |  include file *define_calc.vh* in file *define_calc_add.vh*.

   |  In this way, each design file could include just one definition file,
   |  and a definition file in a lower level would include a definition file in a higher level.

isolate with undef
``````````````````

   |  In order to keep the definitions in file *define_calc_add.vh* invisible to other unrelated modules,
   |  I have created a corresponding "undef" file *undef_calc_add.vh*, which "undefs" every definition in file *define_calc_add.v*.
   |  Due to the same reason, other definition files except file *define.vh* also have the corresponding "undef" files.

   |  In this way, definitions of modules and IPs can be isolated from each other.
   |  This is meaningful since multiple modules would exist in one IP and multiple IPs would exist in one "top".

diagram
```````

   A simplified diagram is given to illustrate the above two tricks.

   .. image:: hierachy.png
      :width: 1000
