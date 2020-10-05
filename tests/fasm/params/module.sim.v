/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

(* whitebox *)
module MODULE(I1, I2, O);
    input  wire I1;
    input  wire I2;
    output wire O;

    (* FASM *)
    parameter INIT = 0;
    (* FASM *)
    parameter IS_SOMETHING_INVERTED = 0;

    assign O = I1 | I2;

endmodule
