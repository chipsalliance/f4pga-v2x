/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
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
