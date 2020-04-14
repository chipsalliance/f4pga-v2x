/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

/*
 * `input wire clk` should be detected as a clock despite this being a black
 * box module.
 */
(* whitebox *)
module BLOCK(clk, a, o);
	input wire clk;
	input wire a;
	output wire o;
endmodule
