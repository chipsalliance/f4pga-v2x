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

(* whitebox *)
module ADDER (
	a, b, cin,
	sum, cout
);
	input wire a;
	input wire b;
	(* carry = "ADDER" *)
	input wire cin;

	(* DELAY_CONST_a   = "300e-12" *)
	(* DELAY_CONST_b   = "300e-12" *)
	(* DELAY_CONST_cin = "300e-12" *)
	output wire sum;

	(* carry = "ADDER" *)
	(* DELAY_CONST_a   = "300e-12" *)
	(* DELAY_CONST_b   = "300e-12" *)
	(* DELAY_CONST_cin =  "10e-12" *)
	output wire cout;

	// Full adder combinational logic
	assign sum = a ^ b ^ cin;
	assign cout = ((a ^ b) & cin) | (a & b);

	// Timing parameters, not supported by Yosys at the moment.
`ifndef YOSYS
	`timescale 1ps/1ps
	specify
		specparam T1 300;
		specparam T2 10;
		// (input->output) min:typ:max

		(a => sum) 	= T1;
		(b => sum)	= T1;
		(cin => sum)	= T1;

		(a => cout)	= T1;
		(b => cout)	= T1;
		(cin => cout)	= T2;

	endspecify
`endif
endmodule
