/*
 * Copyright 2020-2022 F4PGA Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`include "lut/lut4.sim.v"
`include "dff/dff.sim.v"

module PACK_PATTERN (
    CLK,
    LUT_IN,
    LUT_OUT,
    DFF_OUT
);
    input wire CLK;
    input wire [3:0] LUT_IN;

    output wire LUT_OUT;
    output wire DFF_OUT;

    (* pack *)
    wire w;

    LUT4 lut (.I(LUT_IN), .O(w));
    DFF dff (.CLK(CLK), .D(w), .Q(DFF_OUT));

    assign LUT_OUT = w;
endmodule
