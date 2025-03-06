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

   collected based on Spyglass rules

   *  Arrary Rules

      #. :W17: Prefer full range of a bus/array in sensitivity list. Avoid bits or slices

         warning:

         ::

            always @( dat[1:0], ... ) begin
               ...    // expressions with dat[1:0]
            end

         preferred:

         ::

            assign dat_sub_w = dat[1:0];

            always @(*) begin
               ...    // expressions with dat_sub_w
            end

      #. :W86: Not all elements of an array are set

      #. :W111: Not all elements of an array are read

      #. :W488: A bus variable appears in the sensitivity list but not all bits of the bus are read in the contained block

   *  Case Rules

      #. :W69: case constructs that do not have all possible clauses described and also do not have the default clause

         warning:

         ::

            always @(*) begin
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 'b000 ;
                  2'd1 :    dat_thermal_w = 'b001 ;
                  2'd2 :    dat_thermal_w = 'b011 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                            dat_thermal_w = 'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 'b000 ;
                  2'd1 :    dat_thermal_w = 'b001 ;
                  2'd2 :    dat_thermal_w = 'b011 ;
                  2'd3 :    dat_thermal_w = 'b111 ;
               endcase
            end

      #. :W71: case constructs that do not contain a default clause

         warning:

         ::

            always @(*) begin
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 4'b000 ;
                  2'd1 :    dat_thermal_w = 4'b001 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd3 :    dat_thermal_w = 4'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                            dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 4'b000 ;
                  2'd1 :    dat_thermal_w = 4'b001 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd3 :    dat_thermal_w = 4'b111 ;
               endcase
            end

      #. :W171: Expressions used as case clause labels

         warning:

         ::

            always @(*) begin
                                         dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  dat_condition_0_w :    dat_thermal_w = 4'b000 ;
                  dat_condition_1_w :    dat_thermal_w = 4'b001 ;
                  dat_condition_2_w :    dat_thermal_w = 4'b011 ;
                  dat_condition_3_w :    dat_thermal_w = 4'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
               if( dat_bin_w == dat_condition_0_w ) begin
                  dat_thermal_w = 4'b000 ;
               end
               else if( dat_bin_w == dat_condition_1_w ) begin
                  dat_thermal_w = 4'b001 ;
               end
               else if( dat_bin_w == dat_condition_2_w ) begin
                  dat_thermal_w = 4'b011 ;
               end
               else if( dat_bin_w == dat_condition_3_w ) begin
                  dat_thermal_w = 4'b111 ;
               end
               else begin
                  dat_thermal_w = 4'b000 ;
               end
            end

      #. :W187: case constructs where the default clause is not the last clause

         warning:

         ::

            always @(*) begin
               case( dat_bin_w )
                  2'd0   :    dat_thermal_w = 'b000 ;
                  2'd1   :    dat_thermal_w = 'b001 ;
                  default:    dat_thermal_w = 'b000 ;
                  2'd3   :    dat_thermal_w = 'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                            dat_thermal_w = 'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 'b000 ;
                  2'd1 :    dat_thermal_w = 'b001 ;
                  2'd3 :    dat_thermal_w = 'b111 ;
               endcase
            end

      #. :W226: case constructs where the selector is a constant or a static expression

         warning:

         ::

            always @(*) begin
                                         dat_thermal_w = 4'b000 ;
               case( 2'b2 )
                  dat_condition_0_w :    dat_thermal_w = 4'b000 ;
                  dat_condition_1_w :    dat_thermal_w = 4'b001 ;
                  dat_condition_2_w :    dat_thermal_w = 4'b011 ;
                  dat_condition_3_w :    dat_thermal_w = 4'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
               if( dat_condition_0_w == 'd2 ) begin
                  dat_thermal_w = 4'b000 ;
               end
               else if( dat_condition_1_w == 'd2 ) begin
                  dat_thermal_w = 4'b001 ;
               end
               else if( dat_condition_2_w == 'd2 ) begin
                  dat_thermal_w = 4'b011 ;
               end
               else if( dat_condition_3_w == 'd2 ) begin
                  dat_thermal_w = 4'b111 ;
               end
               else begin
                  dat_thermal_w = 4'b000 ;
               end
            end

      #. :W263: case clause labels whose widths do not match the width of the corresponding case construct selector

         warning:

         ::

            wire [2-1 :0]    dat_bin_w ;

            always @(*) begin
                            dat_thermal_w = 'b000 ;
               case( dat_bin_w )
                  1'd0 :    dat_thermal_w = 'b000 ;
                  1'd1 :    dat_thermal_w = 'b001 ;
                  2'd2 :    dat_thermal_w = 'b011 ;
               endcase
            end

         preferred:

         ::

            wire [2-1 :0]    dat_bin_w ;

            always @(*) begin
                            dat_thermal_w = 'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 'b000 ;
                  2'd1 :    dat_thermal_w = 'b001 ;
                  2'd2 :    dat_thermal_w = 'b011 ;
               endcase
            end

      #. :W332: case constructs that do not have all possible clauses described and have a default clause

      #. :W337: Illegal case construct labels

         warning:

         ::

            always @(*) begin
                             dat_thermal_w = 'b000 ;
               case( dat_bin_w )
                  2'b00 :    dat_thermal_w = 'b000 ;
                  2'b01 :    dat_thermal_w = 'b001 ;
                  2'b1x :    dat_thermal_w = 'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                             dat_thermal_w = 'b000 ;
               casez( dat_bin_w )
                  2'b00 :    dat_thermal_w = 'b000 ;
                  2'b01 :    dat_thermal_w = 'b001 ;
                  2'b1? :    dat_thermal_w = 'b111 ;
               endcase
            end

      #. :W398: Duplicate choices in CASE construct

         warning:

         ::

            always @(*) begin
                            dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 4'b000 ;
                  2'd1 :    dat_thermal_w = 4'b001 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd3 :    dat_thermal_w = 4'b111 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                            dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 4'b000 ;
                  2'd1 :    dat_thermal_w = 4'b001 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd3 :    dat_thermal_w = 4'b111 ;
               endcase
            end

      #. :W453: case constructs with large selector bit-width and more number of case clauses

         warning:

         ::

            wire [32-1 :0]    dat_x_w ;

            always @(*) begin
                                 ...
               case( dat_x_w )
                  32'h00000000 : ...
                  32'h00000001 : ...
                  ... : ...
                  32'hffffffff : ...
               endcase
            end

         preferred:

         design should be optimized

      #. :W551: case constructs with the default clause and full_case pragma applied or priority/unique case constructs with default clause

         warning:

         ::

            always @(*) begin
                              dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  // synopsys full case
                  2'd0   :    dat_thermal_w = 4'b000 ;
                  2'd1   :    dat_thermal_w = 4'b001 ;
                  2'd2   :    dat_thermal_w = 4'b011 ;
                  2'd3   :    dat_thermal_w = 4'b111 ;
                  default:    dat_thermal_w = 4'b011 ;
               endcase
            end

         preferred:

         ::

            always @(*) begin
                            dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  2'd0 :    dat_thermal_w = 4'b000 ;
                  2'd1 :    dat_thermal_w = 4'b001 ;
                  2'd2 :    dat_thermal_w = 4'b011 ;
                  2'd3 :    dat_thermal_w = 4'b111 ;
               endcase
            end

   *  Lint_Reset Rules

      #. :W392: Reset/Set signals that have been used in both negative and positive polarity in the same architecture

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

            always @(posedge clk or posedge rstn ) begin
               if( rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W395: process/always blocks that use multiple asynchronous set/reset signals

         ::

            always @(posedge clk, negedge rstn_1, negedge rstn_2 ) begin
               if( !rstn_1 ) begin
                  dat_r <= 'd0 ;
               end
               else if( !rstn_2 ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W396: Processes that have a clock signal but no asynchronous reset signal

         ::

            always @(posedge clk) begin
               ...
            end

      #. :W402: Reset signals that are internally generates at level other than the top-level of the design

      #. :W402a: Synchronous reset signals that are not inputs to the module

      #. :W402b: Asynchronous reset signals that are not inputs to the module

      #. :W448: Signals that are used both as synchronous and asynchronous reset/set in a design

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

            always @(posedge clk ) begin
               if( !rstn ) begin
                  dat_b_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

            always @(posedge clk or negedge rstn ) begin
               ...
            end

      #. :W501: Reset ports in component instantiations that are connected to static names (generic or constant)

         ::

            test test(
               .clk     ( clk     ),
               .rstn    ( 1'b0    ),
               ...
            );

   *  Lint_Clock Rules

      #. :W391: Modules where both edges of a clock are used to describe sequential elements

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

            always @(negedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_b_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W401: Clock signals that are not input to the module where they are used

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  clk_r <= 'd0 ;
               end
               else begin
                  clk_r <= ! clk_r ;
               end
            end

            always @(posedge clk_r or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  flg_r <= 'd0 ;
               end
               else begin
                  flg_r <= ! flg_r ;
               end
            end

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  if( flg_r ) begin
                     ...
                  end
               end
            end

      #. :W422: Event control descriptions with more than one clock

         ::

            always @(posedge clk1 or posedge clk2 or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W500: Clock ports of component instances that use bus, indexed-name, sliced-name, expressions, or concatenation

         ::

            test test(
               .clk     ( 1'b0    ),
               .rstn    ( rstn    ),
               ...
            );

         ::

            test test(
               .clk     ( clk1 || clk2    ),
               .rstn    ( rstn            ),
               ...
            );

   *  Usage Rules

      #. :W34: Macros that are defined but not used

      #. :W88: Memories where all their elements are not set in the design

      .. #. :W111: Arrays where all elements are not read in the process

      #. :W120: Variables that are declared but not used

      #. :W121: Object names that are not unique within the current scope

         ::

            reg dat_r ;

            generate
               for( ... ) begin
                  reg dat_r ;
                  always @(posedge clk or negedge rstn ) begin
                     if( !rstn ) begin
                  end
               end
            endgenerate

      #. :W123: Signal/ variable that has been read out but is never set

      #. :W143: Macros redefinitions in the same file

      #. :W154: Implicit net declarations

         ::

            assign dat_c_w = dat_a_w + dat_b_w ;

      #. :W175: Parameters that are never used

      #. :W188: Assignments to input ports

      #. :W215: Bit-selects of integer or time variables

         ::

            integer i;

            always @(*)
               ...
               dat_r = i[1:0];
               ...
            end

      #. :W216: Part-selects of integer or time variables

      #. :W240: Input ports that are never read

      #. :W241: Output ports that are not completely set

      #. :W333: UDPs (user-defined primitives) that are never instantiated

      #. :W423: Ports that are re-declared with a different range in the same module

         ::

            input  [10-1 :0]   dat_i ;
            wire   [20-1 :0]   dat_i ;

      #. :W468: Variables used as array index that are narrower than the array width

         ::

            reg  [10-1 :0]   dat_r[128-1 :0] ;
            wire [3 -1 :0]   idx_w ;
            assign dat_w = dat_r[idx_w] ;

      #. :W493: Use of shared variables with global scope

      #. :W494: Inout ports that are never used

      #. :W494a: Input ports that are never read

      #. :W494b: Output ports that are never set

      #. :W495: Inout ports that are read but never set

      #. :W497: Bus signals that are not completely set in the design

      #. :W498: Bus signals that are not completely read in the design

      #. :W528: Signals or variables that are set but never read

      .. #. :W529: Preprocessor conditional directives

      .. #. :W557: Runs the W557a and W557b rules

   *  Lint_Tristate Rules

      #. :W438: Tristate descriptions that are not at the top-level of the design

      #. :W541: Inferred tristate nets

         ::

            assign dat_o = flg_r ? dat_w : 1'bz ;

   *  Assign Rules

      #. :W19: Usage of constants where the constant is wider than the usage context

         ::

            wire [2-1 :0]    dat_w ;

            assign flg_o = dat_w == 2'b0101 ;

      #. :W164: Assignments in which LHS width does not match with the RHS width of an expression

      #. :W164c: Assignments in which the LHS width is greater than the (implied) width of the RHS expression

      #. :W257: Delays

      #. :W280: Intra-assignment delays specified with nonblocking assignments

      #. :W306: integer type to real type conversions

      #. :W307: Unsigned type (reg type) to real type conversions

      #. :W308: real type to integer type conversions

      #. :W309: Unsigned type (reg type) to integer type conversions

      #. :W310: integer type to unsigned type (reg type) conversions

      #. :W311: real type to unsigned type (reg type) conversions

      #. :W312: real type to single-bit type conversions

      #. :W314: Multi-bit reg types to single-bit conversions

      #. :W317: Assignments to supply nets

      #. :W336: Blocking assignment used in sequential always constructs

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r = 'd0 ;
               end
               else begin
                  if( val ) begin
                     dat_r = dat_i ;
                  end
               end
            end

      #. :W397: Value assignments to input ports

      #. :W414: nonblocking assignments used in combinational always constructs

         ::

            always @(*) begin
               dat_w <= dat_i ;
            end

      #. :W446: Output ports that are read in the module where they are set

      #. :W474: Variables that are assigned but not deassigned

      #. :W475: Variables that are deassigned without being assigned

      #. :W476: Variables that are forced but are not released

      #. :W477: Variables that are released without being forced

      #. :W484: Possible loss of carry or borrow bits during assignments using addition and subtraction arithmetic operators

      #. :W505: Signals or variables that are being assigned values using both blocking and nonblocking assignments

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  if( val ) begin
                     dat_r = dat_i ;
                  end
               end
            end

   *  Function-Task Rules

      #. :W190: Tasks or procedures that are declared but not used in the design

      #. :W191: Functions that are declared but not used in the design

      #. :W243: Recursive task calls

      #. :W345: Presence of an event control in a task or procedure body may not be synthesizable

      #. :W346: Task descriptions with multiple event control statements

      #. :W372: User-defined PLI functions that are not registered in the Verilog Lint ruledeck file

      #. :W373: User-defined PLI tasks that are not registered in the Verilog Lint ruledeck file

      #. :W424: Functions that set global variables

      #. :W425: Functions that read global variables

      #. :W426: Tasks that set global variables

      #. :W427: Tasks that read global signals

      #. :W428: Task calls in combinational always constructs

      #. :W429: Task calls in sequential always constructs

      #. :W489: Functions where the last statement in the function description is not assigning to the function return value

      #. :W499: Functions where all bits of the function return value are not assigned in the function description

   *  Function-Subprogram Rules

      #. :W190: Tasks or procedures that are declared but not used in the design

      #. :W191: Functions that are declared but not used in the design

      #. :W345: Presence of an event control in a task or procedure body may not be synthesizable

      #. :W416: Functions where the range of the return type is not same as the function return value

      #. :W424: Functions that set global variables

      #. :W425: Functions that read global variables

      #. :W489: Functions where the last statement in the function description is not assigning to the function return value

   *  Delay Rules

      #. :W126: Non-integer delay values

      #. :W127: Delay values containing X or Z

      #. :W128: Negative delays

      #. :W129: Non-constant delay values

   *  Lint_Latch Rules

      #. :W18: Latches inferred in the design

   *  Instance Rules

      #. :W107: Bus connections to primitive gates

      #. :W110: Width mismatch between a module port and the net connected to the port in a module instance

      .. #. :W110a: Use same port index bounds in component instantiation and entity declaration.

      #. :W146: Module instances where the port association is by position

      #. :W156: Reverse connected buses

         ::

            test test(
               ...
               .dat_i    ( dat_w[0:19]    ),
               ...
            )

      #. :W210: Module/Interface instances with unconnected ports

      #. :W287a: Module instances where nets connected to input ports are not driven

      #. :W287b: Module instances where the output ports are not connected

         warning

         ::

            test test(
               ...
               //.dat_o    (    ),
               ...
            )

         preferred

         ::

            test test(
               ...
               .dat_o    ( /* UNUSED */    ),
               ...
            )

      #. :W287c: Module instances where the inout ports are not connected or connected net is hanging

      #. :W504: Port expression that uses integers

   *  Synthesis Rules

      .. #. :AllocExpr: Allocator expressions

      .. #. :ArrayEnumIndex: Arrays with enumeration type as index

      .. #. :No related reports or files.AssertStmt: ASSERT constructs

      #. :badimplicitSM1: Sequential descriptions where the clock and reset cannot be inferred

         ::

            always @(posedge clk or negedge rstn ) begin
               if( rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :badimplicitSM2: Sequential descriptions where the states are updated on different clock edges

      #. :badimplicitSM4: Sequential descriptions where event control expressions use with more than one clock edge

         ::

            always @(posedge clk or negedge clk or negedge rstn ) begin
               if( rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      .. #. :BlockHeader: Port or generics used in the block header statements

      #. :bothedges: Multiple edges of a variable used in the control list

         ::

            always @(posedge clk or posedge rstn or negedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      .. #. :BothPhase: Processes that are driven by both edge of a clock

      .. #. :ClockStyle: Un-synthesizable clocking styles

      .. #. :DisconnSpec: Disconnection specification constructs

      .. #. :EntityStmt: Statements in entity description

      .. #. :ExponOp: Non-static left operands of the exponentiation operator

      .. #. :ForLoopWait: WAIT statements used in FOR-LOOP constructs

      .. #. :IncompleteType: Incomplete Types

      #. :infiniteloop: while or forever loops without event control to break the loop

      .. #. :InitPorts: Default initial value settings for output and inout ports

      .. #. :IntGeneric: Non-integer types used in generic declarations

      .. #. :LinkagePort: Ports of type LINKAGE

      .. #. :LoopBound: LOOP constructs with locally non-static bounds

      #. :mixedsenselist: Mixed edge and non-edge conditions in sensitivity list of an always construct

      .. #. :MultiDimArr: Multi-dimensional arrays

      .. #. :MultipleWait: Multiple WAIT constructs of the same clock expression

      .. #. :NoTimeOut: Timeouts in WAIT constructs

      .. #. :PhysicalTypes: declarations of un-synthesizable physical constructs

      .. #. :PortType: Ports of unconstrained types

      .. #. :PreDefAttr: Un-synthesizable pre-defined attributes

      #. :readclock: Sequential descriptions where the clock signal is read inside the always construct

         ::

            always @(posedge clk or posedge rstn ) begin
               if( !rstn ) begin
                  dat_r <= 'd0 ;
               end
               else begin
                  if( clk == 1'b1 ) begin
                     ...
                  end
               end
            end

      .. #. :ResFunction: Resolutions functions

      .. #. :ResetSynthCheck: All synthesis issues related to reset

      .. #. :SigVarInit: Initial value assignment to signals and variables

      .. #. :SynthIfStmt: IF, IF-ELSIF, and IF-ELSIF-ELSE constructs that have un-synthesizable constructs

      .. #. :UserDefAttr: User-defined attributes

      .. #. :W43: wait statements used in the design

      #. :W182c: time variable declarations

      #. :W182g: tri0 declarations

      #. :W182h: tri1 declarations

      #. :W182k: trireg declarations

      #. :W182n: Switches (pmos, nmos, and cmos)

      #. :W213: PLI functions

      #. :W218: Event expressions that check for edge on a multi-bit signal

         ::

            wire [2-1 :0]    dat_i ;
            always @(posedge dat_i) begin
               dat_o = dat_i ;
            end

      #. :W239: Hierarchical name references

         ::

            assign dat_o = test.dat_w ;

      #. :W250: disable statements

      .. #. :W257: Delays

      #. :W293: Functions that return real values

      #. :W294: Un-synthesizable constructs

         ::

            real r = 0.025 ;

      #. :W295: event variables

         ::

            event w ;

      .. #. :W339: Runs W339a rule.

      #. :W339a: Identity operators  identity equal (===) and identity not equal (!==) operators

      #. :W430: initial constructs

      .. #. :W442: Runs W442a, W442b, W442c, and W442f rules

      #. :W442a: Un-synthesizable asynchronous reset sequences

         ::

            always @(posedge clk or negedge rstn ) begin
                  dat_b_r <= 'd0 ;
               if( !rstn ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W442b: Complex reset sequences

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn == flg_w ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      #. :W442c: Reset sequences where the reset signal is being modified by operators other than logical inverse (!) and bit-wise inverse (~) operators

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'd0 ;
               end
               else begin
                  ...
               end
            end

      .. #. :W442f: Reset sequences where reset signal is being compared using an operator other than the binary equal (==) operator

      #. :W464: Unsupported synthesis directives

      #. :W496a: Comparisons to tristate signals in control expressions

         ::

            always @(*) begin
               if( condition_w == 2'b1z ) begin
                  ...
               end
               else begin
                  ...
               end
            end

      #. :W496b: Comparisons to tristate signals in case construct control expressions

         ::

            always @(*) begin
                             dat_thermal_w = 4'b000 ;
               case( dat_bin_w )
                  2'b00 :    dat_thermal_w = 4'b000 ;
                  2'b01 :    dat_thermal_w = 4'b001 ;
                  2'b1z :    dat_thermal_w = 4'b111 ;
               endcase
            end

      #. :W503: event variables that are never triggered

      .. #. :W505: Signals or variables that are being assigned values using both blocking and nonblocking assignments

      .. #. :WhileInSubProg: WHILE constructs used in sub-program descriptions

   *  Expression Rules

      #. :W116: Unequal length operands in bitwise logical/ arithmetic/ ternary operator

      #. :W159: Control expressions that evaluate to a constant

      .. #. :W180: Constant value specifications where the specified constant value is narrower than the specified width

      #. :W224: Multi-bit expressions found where single-bit expressions were expected

         ::

            assign dat_c_w = (dat_a_w-dat_b_w) ? 'd1 : 'd0 ;

      #. :W289: real operands used in logical comparisons

      #. :W292: Logical comparison operations on real type operands

      #. :W341: Assignments to constants where the size of the assigned value is narrower than the constant and the high-order bit/byte are zero

      #. :W342: Assignments to constants where the size of the assigned value is narrower than the constant and the high-order bit/byte are X

      #. :W343: Assignments to constants where the size of the assigned value is narrower than the constant and the high-order bit/byte are Z

      #. :W362: Unequal widths in arithmetic comparison operations

         ::

            wire [7-1 :0]    dat_a_w ;
            wire [3-1 :0]    dat_b_w ;
            assign flg_w = (dat_a_w>dat_b_w) ? 'd1 : 'd0 ;

      #. :W443: Based numbers that contain the unknown character (X)

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'dx ;
               end
               else begin
                  ...
               end
            end

      #. :W444: All occurrences of the high impedance character (Z) or ? in the design

         ::

            always @(posedge clk or negedge rstn ) begin
               if( !rstn ) begin
                  dat_a_r <= 'd? ;
               end
               else begin
                  dat_a_r <= 'dz ;
               end
            end

      #. :W467: Based numbers that contain the dont care character (?)

      #. :W486: Shift operation overflows

         ::

            wire [5-1 :0]    dat_a_w ;
            wire [5-1 :0]    dat_b_w ;
            assign dat_b_w = dat_a_w << 'd2 ;

      #. :W490: Constant control expressions or sub-expressions

      #. :W491: case clause condition constants that are ?-extended

      #. :W561: Zero-width based numbers

         ::

            0'd0

      #. :W563: Unary reduction operations on single-bit expressions

         ::

            wire dat_a_w ;
            wire dat_b_w ;
            assign dat_b_w = | dat_a_w ;

      #. :W575: Logical not operators used on vector signals

         ::

            wire [10-1 :0]    dat_w ;
            wire              flg_w ;
            assign flg_w = !dat_w ;

      #. :W576: Logical operations performed on vector signals

         ::

            wire [10-1 :0]    dat_a_w ;
            wire [10-1 :0]    dat_b_w ;
            wire              flg_w ;
            assign flg_w = dat_a_w && dat_b_w ;

   *  MultipleDriver Rules

      #. :W259: Signals that have multiple drivers but no associated resolution function

      #. :W323: Non-tristate inout nets that are driven in more than one always construct or module instance

      #. :W415: Non-tristate nets that are driven in more than one always construct or module instance

      #. :W415a: Signals that are multiply assigned in the same always construct

      #. :W552: Flip-flop outputs whose different bit-selects are driven in different sequential always constructs

      #. :W553: Nets whose different bit-selects are driven in different combinational always constructs

   *  Simulation Rules

      .. #. :W17: Arrays in sensitivity lists that are not completely specified

      #. :W122: Signal that is read in a combinational process/ always block, but is not included in the sensitivity list

      #. :W167: Modules that do not have any port interface

      #. :W456: Signals that are in the sensitivity list of a combinational always construct but are not completely read in the construct

      #. :W456a: Signals that are in the sensitivity list of a combinational process block but are not read in the process block

      .. #. :W488: Bus signals that are in the sensitivity list of an always construct but are not completely read in the construct

      #. :W502: variable that is present in the sensitivity list and is modified in the always block

      #. :W526: IF-ELSE constructs that should be changed to case constructs to improve performance

   *  Event Rules

      .. #. :W218: Event expressions that check for edge on a multi-bit signal

      #. :W238: always construct where both blocking assignments and nonblocking assignments are used

      #. :W245: Reduction OR operator (|) or logical OR operator (||) used in the sensitivity list of an always construct

      #. :W253: Data event variables specified with an edge in a timing check system task call

      #. :W254: Reference event variables specified without an edge in a timing check system task call

      #. :W256: Notifiers that are not single-bit registers

      #. :W326: event variables used with edges

      #. :W421: always constructs that have neither a sensitivity list nor an event control statement

      .. #. :W503: event variables that are never triggered

   *  Loop Rules

      #. :W66: repeat constructs with non-static control expressions

         ::

            repeat( dat_w ) begin
               ...
            end

      #. :W352: for constructs with condition expression that evaluate to a constant

      .. #. :W478: This rule has been deprecated

      #. :W479: for constructs where the control expression does not set the value of the variable used in the step expression or always sets it to a constant value

      #. :W480: for constructs where the loop index variable evaluates to a non-integer

      #. :W481a: for constructs where the variable used in the step expression is not used in the condition expression

      #. :W481b: for constructs where the variable used in the initialization expression is not same as the variable used in the step expression

   *  Lint_Elab_Rules

      .. #. :W17: Arrays in sensitivity lists that are not completely specified

      .. #. :W69: case constructs that do not have all possible clauses described and also do not have the default clause

      .. #. :W71: case constructs that do not contain a default clause

      .. #. :W86: Arrays where all elements are not set

      .. #. :W88: Memories where all their elements are not set in the design

      .. #. :W107: Bus connections to primitive gates

      .. #. :W110: Width mismatch between a module port and the net connected to the port in a module instance

      .. #. :W110a: Use same port index bounds in component instantiation and entity declaration

      .. #. :W111: Arrays where all elements are not read in the process

      .. #. :W116: Unequal length operands in bitwise logical/ arithmetic/ ternary operator

      .. #. :W120: Variables that are declared but not used

      .. #. :W122: Signal that is read in a combinational process/ always block, but is not included in the sensitivity list

      .. #. :W123: Signal/ variable that has been read out but is never set

      .. #. :W156: Reverse connected buses

      #. :W162: Constant integer assignments to signals when the width of the signal is wider than the width of the constant integer

      #. :W163: Cases where a constant integer value is assigned to a vector of smaller size

      #. :W164a: Assignments in which the LHS width is less than the (implied) width of the RHS expression

      #. :W164b: Assignments in which the LHS width is greater than the (implied) width of the RHS expression

      .. #. :W164c: Assignments in which the LHS width is greater than the (implied) width of the RHS expression

      .. #. :W240: Input ports that are never read

      .. #. :W241: Output ports that are not completely set

      .. #. :W259: Signals that have multiple drivers but no associated resolution function

      .. #. :W263: Case clause labels whose widths do not match the width of the corresponding case construct selector

      .. #. :W287a: Module instances where nets connected to input ports are not driven

      #. :W316: Integer conversions where the left expression is wider than the right expression

      #. :W328: Constant conversions where the left expression is narrower than the right expression but the extra bits in the right expressions are all zeros

      .. #. :W362: Unequal widths in arithmetic comparison operations

      .. #. :W423: Ports that are re-declared with a different range in the same module

      .. #. :W446: Output ports that are read in the module where they are set

      .. #. :W453: Case constructs with large selector bit-width and more number of case clauses

      .. #. :W456: Signals that are in the sensitivity list of a combinational always construct but are not completely read in the construct

      .. #. :W456a: Signals that are in the sensitivity list of a combinational process block but are not read in the process block

      .. #. :W468: Variables used as array index that are narrower than the array width

      .. #. :W484: Possible loss of carry or borrow bits during assignments using addition and subtraction arithmetic operators

      .. #. :W486: Shift operation overflows

      .. #. :W488: Bus signals that are in the sensitivity list of an always construct but are not completely read in the construct

      .. #. :W494: Inout ports that are never used

      .. #. :W495: Inout ports that are read but never set

      .. #. :W497: Bus signals that are not completely set in the design

      .. #. :W498: Bus signals that are not completely read in the design

      .. #. :W502: Variable that is present in the sensitivity list and is modified in the always block

      .. #. :W504: Port expression that uses integers

      .. #. :W528: Signals or variables that are set but never read

      .. #. :W552: Flip-flop outputs whose different bit-selects are driven in different sequential always constructs

      .. #. :W553: Flip-flop outputs whose different bit-selects are driven in different sequential always constructs

   *  Verilint_Compat Rules

      .. #. :W162: Constant integer assignments to signals when the width of the signal is wider than the width of the constant integer

      .. #. :W163: Constant integer assignments to signals when the width of the signal is narrower than the width of the constant integer

      #. :W313: integer type to single-bit type conversions

      .. #. :W316: Integer conversions where the left expression is wider than the right expression

      .. #. :W326: event variables used with edges

      .. #. :W328: Constant conversions where the left expression is narrower than the right expression but the extra bits in the right expressions are all zeros

      #. :W348: Concatenation expressions where the width of an integer expression is unspecified

         ::

            assign dat_w = { dat_0_w ,dat_1_w ,dat_2_w+'d3 ,dat_4_w };

      .. #. :W474: Variables that are assigned but not deassigned

      .. #. :W475: Variables that are deassigned without being assigned

      .. #. :W476: Variables that are forced but are not released

      .. #. :W477: Variables that are released without being forced

      .. #. :W488: Bus signals that are in the sensitivity list of an always construct but are not completely read in the construct

      .. #. :W493: Use of shared variables with global scope

      .. #. :W546: Duplicate design unit previously declared in a file at a specified line number

   *  Miscellaneous Rules

      .. #. :W156: Reverse connected buses in instance port maps, signal or variable assignments, and block port maps

      #. :W189: Nested translate_off comments

      #. :W192: Empty BEGIN-END blocks

      #. :W193: Empty statements (isolated semicolons)

      #. :W208: Nested translate_on comments

      #. :W350: Control characters found in strings

      #. :W351: Control characters found in comment lines

      #. :W433: Multiple top-level modules

      #. :W527: Dangling ELSE statements

      #. :W546: Duplicate design unit

      #. :W701: Included files that are not required for analysis

      .. #. :LINT_abstract01: Generates relevant base policy constraints for block abstractions

      .. #. :LINT_blksgdc01: Migrates relevant top-level lint constraints to block boundaries

      .. #. :LINT_sca_validation: Reports unconstrained port of abstracted block driven by a constant value from top-level

   *  CDC Rule

      #. :Ac_unsync01: Asynchronous clock domain crossings for scalar signals that have at least one unsynchronized source

      #. :Ac_unsync02: Asynchronous clock domain crossings for vector signals having at least one unsynchronized source

      .. #. :Ac_sync01: Asynchronous clock domain crossings for scalar signals that have all the sources synchronized.

      .. #. :Ac_sync02: Asynchronous clock domain crossings for vector signals that have all sources synchronized

      .. #. :Ac_coherency06: Reports signals that are synchronized more than once in the same clock domain

      .. #. :Clock_sync05: Multi-sample inputs

      .. #. :Ac_crossing01: Generates spreadsheet for Crossing Matrix view

      .. #. :Clock_sync03: Runs the Clock_sync03a and Clock_sync03b rules

      .. #. :Clock_sync03b: Reports convergence of signals from different domains

      .. #. :Clock_sync06: Multi-transition outputs

      .. #. :Clock_sync08a: Bus-bits that are not synchronized using the recommended techniques (specific case)

      .. #. :Clock_sync09: Signals at clock domain crossings that are synchronized at more than one place

      #. :Ac_conv01: Same-domain signals that are synchronized with multi-flop and sync-cell synchronizers to another domain and that are converging after any number of sequential elements

      .. #. :Ac_conv03: Different-domain signals that are synchronized with multi-flop and sync-cell synchronizers to another domain and that are converging before encountering a sequential element

   *  Advanced Clock Functional Verification Rules

      .. #. :Ac_cdc01: Runs the Ac_cdc01a, Ac_cdc01b, and Ac_cdc01c rules

      #. :Ac_cdc01a: Fast-to-slow clock crossings where the data generated by the source register (fast clock) is not stable long enough for the destination register (slow clock) to properly capture the data when the clock crossing is found to be synchronized by the multi-flop synchronization scheme

      #. :Ac_cdc01b: Fast-to-slow clock crossings where the data generated by the source register (fast clock) is not stable long enough for the destination register (slow clock) to properly capture the data when the clock crossing is found to be synchronized by a scheme other than the multi-flop synchronization scheme

      #. :Ac_cdc01c: Fast-to-slow clock crossings where the data generated by the source register (fast clock) is not stable long enough for the destination register (slow clock) to properly capture the data when the clock crossing is found to be un-synchronized

      #. :Ac_cdc08: Synchronized multi-bit control buses where the bus is not Gray encoded

      .. #. :Ac_clockperiod03: Clocks with design cycles greater than the threshold value

      .. #. :Ac_conv02: Same-domain signals that are synchronized with multi-flop and sync-cell synchronizers to another domain and that are converging before encountering a sequential element

      .. #. :Ac_conv04: All the control bus clock domain crossings that do not follow gray encoding

      .. #. :Ac_conv05: The status of gray encoding check performed on the signals specified by the gray_signals constraint

      .. #. :Ac_datahold01a: Reports synchronized data clock domain crossings where data can be unstable

      .. #. :Clock_sync03a: Reports convergence of signals from same source domain separately synchronized in a single destination domain
