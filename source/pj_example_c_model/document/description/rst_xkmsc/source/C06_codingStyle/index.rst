.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : coding style
   ..
.. -----------------------------------------------------------------------------

Coding Style
============

Basic Rules
-----------

   |  The following rules are revised from
   |  https://www.kernel.org/doc/html/latest/process/coding-style.html
   |  and
   |  https://bitbucket.org/multicoreware/x265/wiki/Coding

   #. indentation

      *  use 4 spaces

         ::

            if (condition) {
                statements
            }
            else {
                statements
            }

   #. breaking long lines and strings (not a must)

      *  keep lines within 80 characters

   #. placing braces and spaces

      *  for all non-function statement blocks, put the opening brace last on the line, and put the closing brace first

         ::

            if (condition) {
                statements
            }
            else {
                statements
            }

      *  for functions, put the opening brace at the beginning of the next line

         ::

            int function(int variable)
            {
                statements;
            }

      *  for single statements, omit braces

         ::

            if (condition)
                one statement;
            else
                one statement;

      *  but for the following cases, still keep them

         ::

            if (condition) {
                one statement;
                one statement;
            }
            else {
                one statement;
            }

            if (condition) {
               if (condition) {
                  if (condition)
                     statement
               }
            }

   #. spaces

      *  use a space after the following keywords

         ::

            if, switch, case, for, do, while

      *  but not with the following keywords

         ::

            sizeof, typeof, alignof, __attribute__

      *  do not add spaces around parenthesized expressions

         ::

            if (condition)

      *  adjacent * to the data name or function name

         ::

            int *variable;
            int *function(int variable);

      *  |  use one space on each side of the following operators
         |  (where, &, \*, ... are used as binary or ternary operators)

         ::

            =, +, -, <, >, *, /, %, |, &, ^, <=, >=, ==, !=, ?, :

      *  | do not use space after the following operators
         | (where, &, \*, ... are used as unary operators)

         ::

            &, *, +, -, ~, !, sizeof, typeof, alignof, __attribute__, defined

      *  do not use space before the postfix increment or decrement unary operators

         ::

            ++, --

      *  do not use space after the prefix increment or decrement unary operators

         ::

            ++, --

      *  do not use space around member operators

         ::

            ., ->

      *  do not leave trailing whitespace at the ends of lines

   #. naming

      *  use the "small camel case" for variables or functions

         ::

            int datCst
            int getDatCst()

      *  use the "big camel case" or small camel case with postfix _t for type

         ::

            Cst* datCst
            cst_t* datCst    // I prefer this one

      *  use the "big camel case" or capitalization for class

         ::

            class Add
            class ADD    // I prefer this one

      *  use the "big camel case" or capitalization for definitions or enums

         ::

            #define MACRO    value
            enums class enmCst_t{
               SAD = 0,
               SATD
            }

      *  use the following prefix or postfix to indicate variable types:

         ::

            m_, class member
            s_, static class member
            g_, global variables
            b, boolean variables (could be omitted for names like flgSplit)
            _t, defined types

   .. #.  typedefs
   ..
   .. #.  functions
   ..
   .. #.  commenting
   ..
   .. #.  you’ve made a mess of it
   ..
   .. #.  kconfig configuration files
   ..
   .. #.  data structures
   ..
   .. #.  macros, Enums and RTL
   ..
   .. #.  printing kernel messages
   ..
   .. #.  allocating memory
   ..
   .. #.  the inline disease
   ..
   .. #.  function return values and names
   ..
   .. #.  using bool
   ..
   .. #.  don't re-invent the kernel macros
   ..
   .. #.  editor modelines and other cruft
   ..
   .. #.  inline assembly
   ..
   .. #.  conditional Compilation


Supplemental Rules
------------------

   The following rules are collected through code review.

   #. |  never use tab as indentation
      |  (they have already been mentioned in "Basic Rules")

   #. |  pay attention to the use of space
      |  (they have already been mentioned in "Basic Rules")

      *  wrong

         ::

            int * dat
            & dat
            if(...){

      *  right

         ::

            int *dat
            &dat
            if (...) {

   #. definition must be atomic

      *  wrong:

         ::

            #define C    A + B

      *  right:

         ::

            #define C    (A + B)

   #. use magic numbers as less as possible
