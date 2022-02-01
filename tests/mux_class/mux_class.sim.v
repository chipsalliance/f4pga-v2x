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

(* CLASS="mux" *)
(* MODEL_NAME="MUX_MODEL_NAME" *)
(* whitebox *)
module MUX_CLASS(I0, I1, S, O);

	input wire I0;
	input wire I1;

	input wire S;

	(* DELAY_CONST_I0 = "1e-10" *)
	(* DELAY_CONST_I1 = "1e-10" *)
	(* DELAY_CONST_S = "1e-10" *)
	output wire O;

	assign O = S ? I1 : I0;
endmodule
