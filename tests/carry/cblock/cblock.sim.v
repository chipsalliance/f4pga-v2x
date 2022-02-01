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

`default_nettype none

(* whitebox *)
module CBLOCK (
	I,
	O,
	CIN,
	COUT
);
	input wire [3:0] I;
	(* carry="C" *)
	input wire CIN;

	(* DELAY_MATRIX_I="30e-12 30e-12 30e-12 30e-12" *)
	(* DELAY_CONST_CIN="30e-12" *)
	output wire O;

	(* carry="C" *)
	(* DELAY_MATRIX_I="30e-12 30e-12 30e-12 30e-12" *)
	(* DELAY_CONST_CIN="30e-12" *)
	output wire COUT;

	wire [4:0] internal_sum;

	assign internal_sum = I + CIN;
	assign O = internal_sum[4];
	assign COUT = internal_sum[3];
endmodule
