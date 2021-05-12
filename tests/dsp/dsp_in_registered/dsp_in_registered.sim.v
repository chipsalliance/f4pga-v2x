/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
 */

`include "../../vtr/dff/dff.sim.v"
`include "../dsp_combinational/dsp_combinational.sim.v"

/* DSP Block with register on all inputs */
module DSP_IN_REGISTERED (clk, a, b, m, out);
	localparam DATA_WIDTH = 4;

	input wire clk;
	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;
	output wire [DATA_WIDTH-1:0] out;

	/* Input registers */
	wire [DATA_WIDTH/2-1:0] q_a;
	wire [DATA_WIDTH/2-1:0] q_b;
	wire q_m;

	genvar i;
	for (i=0; i<DATA_WIDTH/2; i=i+1) begin
		DFF q_a_ff(.D(a[i]), .Q(q_a[i]), .CLK(clk));
		DFF q_b_ff(.D(b[i]), .Q(q_b[i]), .CLK(clk));
	end
	DFF m_ff(.D(m), .Q(q_m), .CLK(clk));

	/* Combinational Logic */
	DSP_COMBINATIONAL comb (.a(q_a), .b(q_b), .m(q_m), .out(out));
endmodule
