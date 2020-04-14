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
module DFF (D, CLK, Q);

	input wire CLK;

	(* SETUP="CLK 10e-12" *)
	(* HOLD="CLK 10e-12" *)
	input wire D;

	(* CLK_TO_Q="CLK 10e-12" *)
	output reg Q;

	always @ ( posedge CLK ) begin
		Q <= D;
	end

`ifndef YOSYS
	specify
		specparam
			tplh$CLK$QP = 1.0,
			tphl$CLK$QP = 1.0,
			tplh$CLK$QN = 1.0,
			tphl$CLK$QN = 1.0,
			tsetup$D$CLK = 1.0,
			thold$D$CLK = 1.0,
			tminpwl$CLK = 1.0,
			tminpwh$CLK = 1.0;

		// PATH DELAYS
		if (flag)
			// Polarity of QP is positive referenced to D
			(posedge CLK *> (QP +: D)) = (tplh$CLK$QP, tphl$CLK$QP);
		if (flag)
			// Polarity of QN is negative referenced to D
			(posedge CLK *> (QN -: D)) = (tplh$CLK$QN, tphl$CLK$QN);

		// SETUP AND HOLD CHECKS
		$setuphold(posedge CLK &&& (flag == 1), posedge D, tsetup$D$CLK, thold$D$CLK, NOTIFIER);

		$setuphold(posedge CLK &&& (flag == 1), negedge D, tsetup$D$CLK, thold$D$CLK, NOTIFIER);

		// MINIMUM WIDTH CHECKING
		$width(negedge CLK, tminpwl$CLK, 0, NOTIFIER);
		$width(posedge CLK, tminpwh$CLK, 0, NOTIFIER);

	endspecify
`endif

endmodule
