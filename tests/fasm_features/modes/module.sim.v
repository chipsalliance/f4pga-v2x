/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

`include "./gate/gate.sim.v"

(* FASM_FEATURES="IN_USE" *)
(* FASM_FEATURES_MODE_B="SEL_MODE_B;ENABLE_SOMETHING" *)
(* MODES="MODE_A;MODE_B" *)
module MODULE(I0, I1, O);
  input  wire I0;
  input  wire I1;
  output wire O;

  parameter MODE = "";

  generate if (MODE == "MODE_A") begin
    assign O = I0;
  end else if (MODE == "MODE_B") begin
    GATE gate (I0, I1, O);
  end endgenerate

endmodule
