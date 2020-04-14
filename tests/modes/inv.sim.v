/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "./not/not.sim.v"

(* MODES="PASSTHROUGH;INVERT" *)
module INV(I, O);
    input  wire I;
    output wire O;

    parameter MODE="PASSTHROUGH";

    // Passthrough (no inversion) mode
    generate if (MODE == "PASSTHROUGH") begin
        assign O = I;

    // Inversion with placeable inverter
    end else if (MODE == "INVERT") begin
        NOT inverter(I, O);

    end endgenerate
endmodule
