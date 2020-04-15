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
module LOGICBOX (I, O);
	input wire I;

	// we need this delay to make VPR see
	// the connection between I and O
	(* DELAY_CONST_I="30e-12" *)
	output wire O;

	assign O=I;

endmodule
