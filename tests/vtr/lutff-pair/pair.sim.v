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

`include "lut/lut4.sim.v"
`include "ff/ff.sim.v"
`include "omux/omux.sim.v"

module PAIR (
	I,
	CLK,
	O
);
	input wire [3:0] I;
	input wire CLK;

	output wire O;

	(* pack="LUT2FF" *)
	wire lut_out;

	LUT4 lut (.I(I), .O(lut_out));

	wire ff_out;
	DFF ff (.CLK(CLK), .D(lut_out), .Q(ff_out));

	parameter FF_BYPASS = "F";
	OMUX #(.MODE(FF_BYPASS)) mux(.L(lut_out), .F(ff_out), .O(O));

endmodule
