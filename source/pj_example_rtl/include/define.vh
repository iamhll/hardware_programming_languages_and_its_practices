//------------------------------------------------------------------------------
  //
  //  Filename       : define.vh
  //  Author         : Huang Leilei
  //  Status         : draft
  //  Created        : 2025-02-18
  //  Description    : [definition] of [all]
  //
//------------------------------------------------------------------------------

`timescale 1ns/1ps

// NOTE: do remember revert those items before each commitment.
`define KNOB_LIB_BEHAVE
//`define KNOB_LIB_FPGA

`ifndef KNOB_LIB_BEHAVE
  `define KNOB_LIB_FPGA
`endif


// I would rather use this define istead of $clog2
// !!! 'd0 is used instead of -1 to avoid VER-318 warnings.
`define FUNC_LOG2(x)    ( ((x) <= ('d1<<'d01)) ? 'd01    \
                        : ((x) <= ('d1<<'d02)) ? 'd02    \
                        : ((x) <= ('d1<<'d03)) ? 'd03    \
                        : ((x) <= ('d1<<'d04)) ? 'd04    \
                        : ((x) <= ('d1<<'d05)) ? 'd05    \
                        : ((x) <= ('d1<<'d06)) ? 'd06    \
                        : ((x) <= ('d1<<'d07)) ? 'd07    \
                        : ((x) <= ('d1<<'d08)) ? 'd08    \
                        : ((x) <= ('d1<<'d09)) ? 'd09    \
                        : ((x) <= ('d1<<'d10)) ? 'd10    \
                        : ((x) <= ('d1<<'d11)) ? 'd11    \
                        : ((x) <= ('d1<<'d12)) ? 'd12    \
                        : ((x) <= ('d1<<'d13)) ? 'd13    \
                        : ((x) <= ('d1<<'d14)) ? 'd14    \
                        : ((x) <= ('d1<<'d15)) ? 'd15    \
                        : ((x) <= ('d1<<'d16)) ? 'd16    \
                        : ((x) <= ('d1<<'d17)) ? 'd17    \
                        : ((x) <= ('d1<<'d18)) ? 'd18    \
                        : ((x) <= ('d1<<'d19)) ? 'd19    \
                        : ((x) <= ('d1<<'d20)) ? 'd20    \
                        : ((x) <= ('d1<<'d21)) ? 'd21    \
                        : ((x) <= ('d1<<'d22)) ? 'd22    \
                        : ((x) <= ('d1<<'d23)) ? 'd23    \
                        : ((x) <= ('d1<<'d24)) ? 'd24    \
                        : ((x) <= ('d1<<'d25)) ? 'd25    \
                        : ((x) <= ('d1<<'d26)) ? 'd26    \
                        : ((x) <= ('d1<<'d27)) ? 'd27    \
                        : ((x) <= ('d1<<'d28)) ? 'd28    \
                        : ((x) <= ('d1<<'d29)) ? 'd29    \
                        : ((x) <= ('d1<<'d30)) ? 'd30    \
                        : ((x) <= ('d1<<'d31)) ? 'd31    \
                        : 'd0                            \
)
