.. -----------------------------------------------------------------------------
   ..
   ..  Filename       : index.rst
   ..  Author         : Huang Leilei
   ..  Status         : draft
   ..  Created        : 2025-02-18
   ..  Description    : how to
   ..
.. -----------------------------------------------------------------------------

What's
======

What's Synchronized Asynchronous Reset
--------------------------------------

*  Synchronized Reset

   ::

      always @(posedge clk ) begin
         if( !rstn ) begin
            dat_r <= 'd0 ;
         end
         else begin
            dat_r <= dat_i ;
         end
      end

*  Asynchronized Reset

   ::

      always @(posedge clk or negedge rstn ) begin
         if( !rstn ) begin
            dat_r <= 'd0 ;
         end
         else begin
            dat_r <= dat_i ;
         end
      end

*  Synchronized Asynchronized Reset

   ::

      always @(posedge clk or negedge rstn ) begin
         if( !rstn ) begin
            rstn_chain_r <= 'd0 ;
         end
         else begin
            rstn_chain_r <= {rstn_chain_r,1'b1} ;
         end
      end

      assign rstn_new = rstn_chain_r[CHAIN_WD-1] ;

      always @(posedge clk or negedge rstn_new ) begin
         if( !rstn_new ) begin
            dat_r <= 'd0 ;
         end
         else begin
            dat_r <= dat_i ;
         end
      end

   Sure, this logic is usually put inside module clkgen.

*  "rstn" may come from de-glitched pad rstn, signal locked from PLL or any other async source.


What's Data Width Extenstion
----------------------------

*  A self-determined expression is one where the bit length of the expression is
   solely determined by the expression itself—for example, an expression
   representing a delay value.

*  A context-determined expression is one where the bit length of the expression
   is determined by the bit length of the expression and by the fact that it is
   part of another expression. For example, the bit size of the right-hand
   expression of an assignment depends on itself and the size of the left-hand
   side.

*  Multiplication may be performed without losing any overflow bits by assigning
   the result to something wide enough to hold it.

   .. table::
      :align: left
      :widths: auto

      +---------------------------+----------------------------+---------------------------------------+
      | Expression                | Bit length                 | Comments                              |
      +===========================+============================+=======================================+
      | unsized constant number   | same as integer            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | sized constant number     | as given                   |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | i op j, where op is     | max(L(i), L(j))            |                                       |
      | | + - * / % & | ^         |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | op i, where op is       | L(i)                       |                                       |
      | | ~                       |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | i op j, where op is     | 1 bit                      | operands are sized to max(L(i),L(j)). |
      | | === !== == != > >= < <= |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | i op j, where op is     | 1 bit                      | all operands are self-determined.     |
      | | && ||                   |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | op i, where op is       | 1 bit                      | all operands are self-determined.     |
      | | & | ^ !                 |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | | i op j, where op is     | L(i)                       | j is self-determined.                 |
      | | >> << >>> <<<           |                            |                                       |
      +---------------------------+----------------------------+---------------------------------------+
      | i ? j : k                 | max(L(j), L(k))            | i is self-determined.                 |
      +---------------------------+----------------------------+---------------------------------------+
      | {i,...,j}                 | L(i) + ... + L(j)          | all operands are self-determined.     |
      +---------------------------+----------------------------+---------------------------------------+
      | {i{j,...,k}}              | L(i) * (L(j) + ... + L(k)) | all operands are self-determined.     |
      +---------------------------+----------------------------+---------------------------------------+

*  codes with bug

   ::

      wire [16-1 :0]    a ;
      wire [16-1 :0]    b ;
      wire [16-1 :0]    c ;
      assign c = (a + b) >> 1 ;

*  a possible fix

   ::

      assign c = (a + b + 0) >> 1 ;

*  a better fix

   ::

      wire [17-1 :0]    t ;
      assign c = t >> 1 ;
      assign t = a + b ;


What's Metastability
--------------------

*  sample a synced signal

   .. image:: meta_1.png
      :width: 500

*  sample an unsynced signal

   .. image:: meta_2.png
      :width: 500

*  if so, it seems there is no damage, when the sampling clock is very slow

   .. image:: meta_3.png
      :width: 500

*  but in fact, the real damage of meta is that different follower may see different value

   .. image:: meta_4.png
      :width: 500

   .. image:: meta_5.png
      :width: 300

*  that's why synchronizers could fix this issue

   .. image:: meta_6.png
      :width: 500


What's Clock Gating
-------------------

*  a SEQ logic with enable

   .. image:: cg_1.png
      :width: 300

*  a better implementation

   .. image:: cg_2.png
      :width: 300

*  actual circuit uses

   .. image:: cg_3.png
      :width: 300

*  how can we get such a circuit?

   *  auto generated

      ::

         always @(posedge clk or negative rstn ) begin
            if( !rstn ) begin
               dat_r <= 'd0 ;
            end
            else begin
               if( val_i ) begin
                  dat_r <= dat_i ;
               end
             // never write else
             //else begin
             //   dat_r <= dat_r ;
             //end
            end
         end

      ::

         compile_ultra -gate_clock

      ::

         report_clock_gating -ungated

   *  manually insert

      for example, the clock path of SRAMs.


What's Glitch in Simulation
---------------------------

*  sometimes when we "wait" a output signal from DUT,
   It may be trigger unexpectedly.

   ::

      initial begin
         ...
         wait( dut.done_o );
         $finish ;
      end

   ::

      test(
         ...
         done_o
      );

      output done_o ;

      assign done_o = val_i && cnt_x_done_w && cnt_y_done_w ;

*  it comes from the glitch during simulation.

*  sample it either in design or in testbench.

*  due to the same reason, better change inputs at neg edges of clocks.
