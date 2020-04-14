/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 */

/* Simple model of a PLL which divides the input block by 64 */
module SIMPLE_PLL (in_clock, out_clock);

	input wire in_clock;

	(* CLOCK *)
	output wire out_clock;

	reg [63:0] counter;
	always @(posedge in_clock) begin
		counter = counter + 1;
	end

	assign out_clock = counter[63];
endmodule
