/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

`include "../../vtr/dff/dff.sim.v"
`include "../dsp_combinational/dsp_combinational.sim.v"

/* DSP Block with register on the output */
module DSP_OUT_REGISTERED (clk, a, b, m, out);
	localparam DATA_WIDTH = 4;

	input wire clk;
	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;
	output wire [DATA_WIDTH-1:0] out;

	/* Combinational logic */
	(* pack="DSP-DFF" *)
	wire [DATA_WIDTH-1:0] c_out;
	DSP_COMBINATIONAL comb (.a(a), .b(b), .m(m), .out(c_out));

	/* Output register on clk */
	genvar j;
	for (j=0; j<DATA_WIDTH; j=j+1) begin: output_dffs_gen
		DFF q_out_ff(.D(c_out[j]), .Q(out[j]), .CLK(clk));
	end
endmodule
