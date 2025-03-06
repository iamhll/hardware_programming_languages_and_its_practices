.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : introduction
   ..
.. -----------------------------------------------------------------------------

Introduction
============

Project Tree
------------

   As the name suggested, git_example_rtl is an example for RTL projects, which has the following project tree.

   ::

      ├── check                    check environments
      │     ├── formality            formality-based environments
      │     └── spyglass             spyglass-based environments
      ├── document                 documents
      │     ├── description          module-related documents
      │     ├── brief                branch-related documents
      │     ├── conclusion           phase-related documents
      │     ├── performance          evaluation-related documents
      ├── include                  definitions and top-level parameters
      ├── library                  models
      │     ├── behave_rtl           behavior models used in designs
      │     ├── behave_sim           behavior models used in testbenches
      │     └── *                    models of technology * (for example, TSMC65 or GF28) (used in both designs and testbenches)
      ├── reference_model          reference models
      ├── script                   scripts
      │     ├── runListUpdate.sh     update script
      │     └── runListCheck.sh      check script
      ├── simulation               simulation environments
      │     ├── rtl                  RTL-level environments
      │     └── netlist              netlist-level environments
      ├── source                   design files
      │     ├── *                    design files for design * (for example, xkcalc or xkcdc)
      │     │     ├── interface        interface-related design files
      │     │     ├── kernel           kernel-related design files
      │     │     └── memory           memory-related design files
      │     └── common               commonly-used design files
      ├── synthesis                synthesis environments
      │     ├── design_compiler      Design-Compiler-based environments
      │     ├── quartus              Quartus-based environments
      └     └── vivado               Vivado-based environments

   I will introduce those directories in the following pages
