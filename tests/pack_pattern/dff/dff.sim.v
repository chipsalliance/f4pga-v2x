/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:	ISC
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
