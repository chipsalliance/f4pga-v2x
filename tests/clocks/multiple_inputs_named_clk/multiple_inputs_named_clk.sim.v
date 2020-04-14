/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 */

/*
 * `input wire rdclk` and `input wire wrclk` should be detected as a clock
 * despite this being a black box module.
 */
(* whitebox *)
module BLOCK(a, rdclk, b, wrclk, c, o);
	input wire a;
	input wire rdclk;
	input wire b;
	input wire wrclk;
	input wire c;
	output wire o;
endmodule
