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

`include "routing/rmux.sim.v"
`include "../logicbox/logicbox.sim.v"
module USE_MUX (a, b, c, o1, o2);
	input wire a;
	input wire b;
	input wire c;
	output wire o1;
	output wire o2;

	wire logic_a;
	wire logic_b;
	wire logic_c;
	LOGICBOX lboxa (.I(a), .O(logic_a));
	LOGICBOX lboxb (.I(b), .O(logic_b));
	LOGICBOX lboxc (.I(c), .O(logic_c));

	parameter FASM_MUX1 = "I0";
	RMUX #(.MODE(FASM_MUX1)) mux1 (.I0(logic_a), .I1(logic_b), .O(o1));

	parameter FASM_MUX2 = "I0";
	RMUX #(.MODE(FASM_MUX2)) mux2 (.I0(logic_a), .I1(logic_c), .O(o2));
endmodule
