/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
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
