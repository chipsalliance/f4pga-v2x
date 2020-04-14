/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "./child/child.sim.v"

module PARENT (
  input  wire I0,
  input  wire I1,
  output wire O0,
  output wire O1
);

  CHILD child (
  .I(I0),
  .O(O0)
  );

  // An direct connection from an input to the output pins.
  assign O1 = I1;

endmodule
