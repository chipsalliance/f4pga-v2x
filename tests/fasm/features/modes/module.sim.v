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
(* FASM_FEATURES_MODE_A="SEL_MODE_A;ENABLE_SOMETHING_A" *)
(* FASM_FEATURES_MODE_B="SEL_MODE_B;ENABLE_SOMETHING_B" *)
(* MODES="MODE_A;MODE_B;MODE_C" *)
module MODULE(I0, I1, O);

  parameter MODE = "MODE_A";

  input  wire I0;
  input  wire I1;
  output wire O;

  generate if (MODE == "MODE_A") begin
    GATE gate (I1, I0, O);
  end else if (MODE == "MODE_B") begin
    GATE gate (I0, I1, O);
  end else if (MODE == "MODE_C") begin
    assign O = I0;
  end endgenerate

endmodule
