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

module BLOCK(c1, c2, a, b, c, o1, o2);
	input wire c1;
	input wire c2;
	input wire a;
	input wire b;
	input wire c;
	output wire o1;
	output wire o2;

	reg r1;
	reg r2;
        always @ ( posedge c1 ) begin
                r1 <= a | b;
        end
        always @ ( posedge c2 ) begin
                r2 <= b | c;
        end

	assign o1 = r1;
	assign o2 = r2;
endmodule
