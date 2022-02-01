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

`ifndef DSP_COMB
`define DSP_COMB
(* whitebox *)
module DSP_COMBINATIONAL (
	a, b, m,
	out
);
	localparam DATA_WIDTH = 4;

	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;

	(* DELAY_CONST_a="30e-12" *)
	(* DELAY_CONST_b="30e-12" *)
	(* DELAY_CONST_m="10e-12" *)
	output wire [DATA_WIDTH-1:0] out;

	// Full adder combinational logic
	assign out = m ? a * b : a / b;
endmodule
`endif
