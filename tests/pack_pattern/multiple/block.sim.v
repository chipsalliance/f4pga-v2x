/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

`include "lut/lut.sim.v"
`include "mux/mux.sim.v"
`include "ff/ff.sim.v"

module BLOCK (
    input  wire       C,
    input  wire [3:0] I,
    input  wire       D,
    input  wire       S,
    output wire       Q
);

    // LUT
    (* PACK="lut_mux_ff" *)
    wire lut_out;

    LUT lut_cell (
        .I (I),
        .O (lut_out)
    );

    // Mux
    (* PACK="lut_mux_ff;mux_ff" *)
    wire mux_out;

    MUX mux_cell (
        .I0 (lut_out),
        .I1 (D),
        .S  (S),
        .O  (mux_out)
    );

    // FF
    FF ff_cell (
        .C  (C),
        .D  (mux_out),
        .Q  (Q)
    );

endmodule
