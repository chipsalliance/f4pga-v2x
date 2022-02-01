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

`include "routing/rmux.sim.v"
`include "../logicbox/logicbox.sim.v"
module USE_MUX (a, b, c, o1, o2);
	input wire a;
	input wire b;
	input wire c;
	output wire o1;
	output wire o2;

	wire logic_a;
	wire logic_b;
	wire logic_c;
	LOGICBOX lboxa (.I(a), .O(logic_a));
	LOGICBOX lboxb (.I(b), .O(logic_b));
	LOGICBOX lboxc (.I(c), .O(logic_c));

	parameter FASM_MUX1 = "I0";
	RMUX #(.MODE(FASM_MUX1)) mux1 (.I0(logic_a), .I1(logic_b), .O(o1));

	parameter FASM_MUX2 = "I0";
	RMUX #(.MODE(FASM_MUX2)) mux2 (.I0(logic_a), .I1(logic_c), .O(o2));
endmodule
