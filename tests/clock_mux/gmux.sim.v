/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

// A model of a clock multiplexer with two clock inputs, one clock output and
// a select input.

(* whitebox *)
module GMUX (IP, IC, IS0, IZ);

    // 1st clock input
    (* CLOCK, NO_COMB=0 *)
    input  wire IP;

    // 2nd clock input
    (* CLOCK, NO_COMB=0 *)
    input  wire IC;

    // Select input
    input  wire IS0;

    // Clock output (has to be defined as a regular output port)
    (* DELAY_CONST_IP="1e-10" *)
    (* DELAY_CONST_IC="2e-10" *)
    (* DELAY_CONST_IS0="3e-10" *)
    output wire IZ;


    // Behavioral model:
    assign IZ = IS0 ? IC : IP;

endmodule
