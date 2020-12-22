/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

module LUT (
    input  wire [3:0] I,
    output wire       O
);

    parameter [15:0] INIT = 'd0;

    assign O = INIT[i];

endmodule
