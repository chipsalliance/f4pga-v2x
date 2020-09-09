/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

(* FASM_FEATURES="IN_USE;ENABLE_FEATURE_X" *)
(* whitebox *)
module MODULE(I0, I1, O);
  input  wire I0;
  input  wire I1;
  output wire O;

  assign O = I0 | I1;

endmodule
