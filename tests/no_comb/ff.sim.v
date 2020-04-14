/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
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
