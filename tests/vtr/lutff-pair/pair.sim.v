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

`include "lut/lut4.sim.v"
`include "dff/dff.sim.v"
`include "omux/omux.sim.v"

module PAIR (
	I,
	CLK,
	O
);
	input wire [3:0] I;
	input wire CLK;

	output wire O;

	(* pack="LUT2FF" *)
	wire lut_out;

	LUT4 lut (.I(I), .O(lut_out));

	wire ff_out;
	DFF dff (.CLK(CLK), .D(lut_out), .Q(ff_out));

	parameter FF_BYPASS = "F";
	OMUX #(.MODE(FF_BYPASS)) mux(.L(lut_out), .F(ff_out), .O(O));

endmodule
