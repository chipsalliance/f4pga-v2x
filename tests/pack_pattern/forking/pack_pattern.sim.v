/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "lut/lut4.sim.v"
`include "dff/dff.sim.v"

module PACK_PATTERN (
    CLK,
    LUT_IN,
    LUT_OUT,
    DFF_OUT
);
    input wire CLK;
    input wire [3:0] LUT_IN;

    output wire LUT_OUT;
    output wire DFF_OUT;

    (* pack *)
    wire w;

    LUT4 lut (.I(LUT_IN), .O(w));
    DFF dff (.CLK(CLK), .D(w), .Q(DFF_OUT));

    assign LUT_OUT = w;
endmodule
