/*
 * Copyright 2020-2022 F4PGA Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`include "../../vtr/dff/dff.sim.v"
`include "../dsp_combinational/dsp_combinational.sim.v"

/* DSP Block with register on both the inputs and the output */
module DSP_INOUT_REGISTERED (clk, a, b, m, out);
	localparam DATA_WIDTH = 4;

	input wire clk;
	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;
	output wire [DATA_WIDTH-1:0] out;

	/* Input registers */
	(* pack = "DFF-DSP" *)
	wire [DATA_WIDTH/2-1:0] q_a;
	(* pack = "DFF-DSP" *)
	wire [DATA_WIDTH/2-1:0] q_b;
	(* pack = "DFF-DSP" *)
	wire q_m;

	genvar i;
	for (i=0; i<DATA_WIDTH/2; i=i+1) begin: input_dffs_gen
		DFF q_a_ff(.D(a[i]), .Q(q_a[i]), .CLK(clk));
		DFF q_b_ff(.D(b[i]), .Q(q_b[i]), .CLK(clk));
	end
	DFF m_ff(.D(m), .Q(q_m), .CLK(clk));

	/* Combinational logic */
	(* pack = "DFF-DSP" *)
	wire [DATA_WIDTH-1:0] c_out;
	DSP_COMBINATIONAL comb (.a(q_a), .b(q_b), .m(q_m), .out(c_out));

	/* Output register */
	wire [DATA_WIDTH-1:0] q_out;
	genvar j;
	for (j=0; j<DATA_WIDTH; j=j+1) begin: output_dffs_gen
		DFF q_out_ff(.D(c_out[j]), .Q(out[j]), .CLK(clk));
	end

endmodule
