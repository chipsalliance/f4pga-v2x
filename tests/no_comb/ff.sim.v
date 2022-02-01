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
module FF(clk, D, S, R, E, Q);
	input wire clk;
	(* SETUP="clk 10e-12" *) (* NO_COMB *)
	input wire D;
	(* SETUP="clk 10e-12" *) (* NO_COMB *)
	input wire E;
	(* SETUP="clk 10e-12" *) (* NO_COMB *)
	input wire S;
	(* SETUP="clk 10e-12" *) (* NO_COMB *)
	input wire R;
	(* CLK_TO_Q = "clk 10e-12" *)
	output reg Q;
	always @(posedge clk or posedge S or posedge R) begin
		if (S)
			Q <= 1'b1;
		else if (R)
			Q <= 1'b0;
		else if (E)
			Q <= D;
	end
endmodule
