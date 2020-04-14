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

`ifndef DSP_COMB
`define DSP_COMB
(* whitebox *)
module DSP_COMBINATIONAL (
	a, b, m,
	out
);
	localparam DATA_WIDTH = 4;

	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;

	(* DELAY_CONST_a="30e-12" *)
	(* DELAY_CONST_b="30e-12" *)
	(* DELAY_CONST_m="10e-12" *)
	output wire [DATA_WIDTH-1:0] out;

	// Full adder combinational logic
	assign out = m ? a * b : a / b;
endmodule
`endif
