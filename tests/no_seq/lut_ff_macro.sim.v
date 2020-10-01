/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier: ISC
 */

(* whitebox *)
module LUT_FF_MACRO (I0, I1, I2, I3, CLK, Z, QZ);

    // LUT inputs
    (* NO_SEQ *)
    input  wire  I0;
    (* NO_SEQ *)
    input  wire  I1;
    (* NO_SEQ *)
    input  wire  I2;
    (* NO_SEQ *)
    input  wire  I3;

    // Clock input
    input  wire  CLK;

    // Combinational LUT output
    (* DELAY_CONST_I0="1e-10" *)
    (* DELAY_CONST_I1="1e-10" *)
    (* DELAY_CONST_I2="1e-10" *)
    (* DELAY_CONST_I3="1e-10" *)
    output wire  Z;

    // Registered LUT output
    (* DELAY_CONST_I0="2e-10" *)
    (* DELAY_CONST_I1="2e-10" *)
    (* DELAY_CONST_I2="2e-10" *)
    (* DELAY_CONST_I3="2e-10" *)
    (* CLK_TO_Q="CLK 1e-10" *)
    (* SETUP="CLK 1e-10" *)
    (* HOLD="CLK 1e-10" *)
    output reg   QZ;

    // LUT behavioral model
    parameter [15:0] INIT = 16'd0;
    assign Z = INIT[{I3, I2, I1, I0}];

    // FF behavioral model    
    always @(posedge CLK)
        QZ <= Z;

endmodule
