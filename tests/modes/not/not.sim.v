/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

(* whitebox *)
module NOT (I, O);

  input  wire I;
  (* DELAY_CONST_I="1e-10" *)
  output wire O;

  assign O = ~I;

endmodule
