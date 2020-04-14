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
 * `input wire a` should be detected as a clock because it drives the flip
 * flop.
 */
module BLOCK(a, b, c, d);
	input wire a;
	input wire b;
	input wire c;
	output wire d;

	reg r;
        always @ ( posedge a ) begin
                r <= b | ~c;
        end
	assign d = r;
endmodule
