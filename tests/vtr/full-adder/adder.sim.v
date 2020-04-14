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
module ADDER (
	a, b, cin,
	sum, cout
);
	input wire a;
	input wire b;
	(* carry = "ADDER" *)
	input wire cin;

	(* DELAY_CONST_a   = "300e-12" *)
	(* DELAY_CONST_b   = "300e-12" *)
	(* DELAY_CONST_cin = "300e-12" *)
	output wire sum;

	(* carry = "ADDER" *)
	(* DELAY_CONST_a   = "300e-12" *)
	(* DELAY_CONST_b   = "300e-12" *)
	(* DELAY_CONST_cin =  "10e-12" *)
	output wire cout;

	// Full adder combinational logic
	assign sum = a ^ b ^ cin;
	assign cout = ((a ^ b) & cin) | (a & b);

	// Timing parameters, not supported by Yosys at the moment.
`ifndef YOSYS
	`timescale 1ps/1ps
	specify
		specparam T1 300;
		specparam T2 10;
		// (input->output) min:typ:max

		(a => sum) 	= T1;
		(b => sum)	= T1;
		(cin => sum)	= T1;

		(a => cout)	= T1;
		(b => cout)	= T1;
		(cin => cout)	= T2;

	endspecify
`endif
endmodule
