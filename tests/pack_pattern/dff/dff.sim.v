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
module DFF (CLK, D, Q);

	input wire CLK;

	(* SETUP="CLK 10e-12" *)
	(* HOLD="CLK 10e-12" *)
	input wire D;

	(* CLK_TO_Q="CLK 10e-12" *)
	output reg Q;
	(* ASSOC_CLOCK="CLK" *)

	always @ ( posedge CLK ) begin
		Q <= D;
	end
endmodule
