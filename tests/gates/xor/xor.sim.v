/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "../nor/nor.sim.v"

module XOR (
    input  A,
    input  B,
    output Y
);

    wire S00;
    NOR nor00 (.A(A), .B(B), .Y(S00));

    wire S10;
    wire S11;
    NOR nor10 (.A(A), .B(S00), .Y(S10));
    NOR nor11 (.A(B), .B(S00), .Y(S11));

    wire S20;
    NOR nor20 (.A(S10), .B(S11), .Y(S20));

    NOR nor30 (.A(S20), .B(S20), .Y(Y));

endmodule
