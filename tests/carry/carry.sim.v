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
`include "cblock/cblock.sim.v"

module CARRY (
	I0,
	I1,
	O0,
	O1,
	CIN,
	COUT
);
	input wire [3:0] I0;
	input wire [3:0] I1;

	output wire O0;
	output wire O1;

	// Implicit carry pins
	input wire CIN;
	output wire COUT;

	// Carry between the two blocks
	wire c;

	CBLOCK cblock0 (.I(I0), .O(O0), .CIN(CIN), .COUT(c));
	CBLOCK cblock1 (.I(I1), .O(O1), .CIN(c), .COUT(COUT));

endmodule
