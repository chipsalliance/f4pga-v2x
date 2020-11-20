/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier:     ISC
 */

module FF (
    input  wire C,
    input  wire D,
    output reg  Q
);

    always @(posedge C)
        Q <= D;

endmodule
