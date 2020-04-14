/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 */

/*
 * `output wire rdclk` and `output wire wrclk` should be detected as a clock
 * despite this being a black box module.
 */
(* whitebox *)
module BLOCK(a, b, rdclk, o, wrclk);
	input wire a;
	input wire b;
	output wire rdclk;
	output wire o;
	output wire wrclk;
endmodule
