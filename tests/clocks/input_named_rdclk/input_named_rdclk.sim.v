/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 */

/*
 * `input wire rdclk` should be detected as a clock despite this being a black
 * box module.
 */
(* whitebox *)
module BLOCK(rdclk, a, o);
	input wire rdclk;
	input wire a;
	output wire o;
endmodule
