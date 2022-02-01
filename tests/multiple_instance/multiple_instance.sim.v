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

`include "../vtr/full-adder/adder.sim.v"
module MULTIPLE_INSTANCE (a, b, c, d, cin, cout, sum);
	localparam DATA_WIDTH = 4;

	input  wire [DATA_WIDTH-1:0] a;
	input  wire [DATA_WIDTH-1:0] b;
	input  wire [DATA_WIDTH-1:0] c;
	input  wire [DATA_WIDTH-1:0] d;
	output wire [DATA_WIDTH*2-1:0] sum;

	input  wire [DATA_WIDTH-1:0] cin;
	output wire [DATA_WIDTH-1:0] cout;

	wire [DATA_WIDTH-1:0] a2b;

	genvar i;
	/* n = 0..DATA_WIDTH
	 *
	 *       cin[n]
	 *        ↓
	 *   a[n] + b[n] → sum[n]
	 *        ↓
	 *   c[n] + d[n] → sum[4+n]
	 *        ↓
	 *      cout[n]
	 */
	for(i=0; i<DATA_WIDTH; i=i+1) begin
		ADDER comb_apb (.a(a[i]), .b(b[i]), .cin(cin[i]), .cout(a2b[i]),  .sum(sum[i]));
		ADDER comb_cpd (.a(c[i]), .b(d[i]), .cin(a2b[i]), .cout(cout[i]), .sum(sum[DATA_WIDTH+i]));
	end

endmodule
