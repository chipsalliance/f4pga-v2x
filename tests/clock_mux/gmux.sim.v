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

// A model of a clock multiplexer with two clock inputs, one clock output and
// a select input.

(* whitebox *)
module GMUX (IP, IC, IS0, IZ);

    // 1st clock input
    (* CLOCK *)
    input  wire IP;

    // 2nd clock input
    (* CLOCK *)
    input  wire IC;

    // Select input
    input  wire IS0;

    // Clock output (has to be defined as a regular output port)
    (* DELAY_CONST_IP="1e-10" *)
    (* DELAY_CONST_IC="2e-10" *)
    (* DELAY_CONST_IS0="3e-10" *)
    (* COMB_INCLUDE_CLOCKS *)
    output wire IZ;

    // Behavioral model:
    assign IZ = IS0 ? IC : IP;

endmodule
