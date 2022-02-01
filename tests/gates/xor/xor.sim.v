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

`include "../nor/nor.sim.v"

module XOR (
    input  A,
    input  B,
    output Y
);

    wire S00;
    NOR nor00 (.A(A), .B(B), .Y(S00));

    wire S10;
    wire S11;
    NOR nor10 (.A(A), .B(S00), .Y(S10));
    NOR nor11 (.A(B), .B(S00), .Y(S11));

    wire S20;
    NOR nor20 (.A(S10), .B(S11), .Y(S20));

    NOR nor30 (.A(S20), .B(S20), .Y(Y));

endmodule
