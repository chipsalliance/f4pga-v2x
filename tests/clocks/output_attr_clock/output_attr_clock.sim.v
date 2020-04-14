/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 */

/*
 * `output wire o` should be detected as a clock because of the `(* CLOCK *)`
 * attribute.
 */
(* whitebox *)
module BLOCK(a, b, o);
	input wire a;
	input wire b;
	(* CLOCK *)
	output wire o;
endmodule
