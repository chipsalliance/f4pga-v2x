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

/* 
 * Generated with v2x/mux_gen.py
 */

`default_nettype none


(* CLASS="routing" *)
(* MODES="L; F" *)
(* whitebox *)
module OMUX(L, F, O);

	input wire L;
	input wire F;

	parameter MODE = "";

	output wire O;

	generate
		if ( MODE == "L" )
		begin:SELECT_L
			assign O = L;
		end
		else if ( MODE == "F" )
		begin:SELECT_F
			assign O = F;
		end
		else
		begin
			//$error("omux: Invalid routing value %s (options are: L, F)", MODE);
		end
	endgenerate
endmodule
