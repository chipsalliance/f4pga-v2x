/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

module MUX (
    input  wire I0,
    input  wire I1,
    input  wire S,
    output wire O
);

    assign O = S ? I1 : I0;

endmodule
