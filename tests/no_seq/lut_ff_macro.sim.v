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

(* whitebox *)
module LUT_FF_MACRO (I0, I1, I2, I3, CLK, Z, QZ);

    // LUT inputs
    (* NO_SEQ *)
    input  wire  I0;
    (* NO_SEQ *)
    input  wire  I1;
    (* NO_SEQ *)
    input  wire  I2;
    (* NO_SEQ *)
    input  wire  I3;

    // Clock input
    input  wire  CLK;

    // Combinational LUT output
    (* DELAY_CONST_I0="1e-10" *)
    (* DELAY_CONST_I1="1e-10" *)
    (* DELAY_CONST_I2="1e-10" *)
    (* DELAY_CONST_I3="1e-10" *)
    output wire  Z;

    // Registered LUT output
    (* DELAY_CONST_I0="2e-10" *)
    (* DELAY_CONST_I1="2e-10" *)
    (* DELAY_CONST_I2="2e-10" *)
    (* DELAY_CONST_I3="2e-10" *)
    (* CLK_TO_Q="CLK 1e-10" *)
    (* SETUP="CLK 1e-10" *)
    (* HOLD="CLK 1e-10" *)
    output reg   QZ;

    // LUT behavioral model
    parameter [15:0] INIT = 16'd0;
    assign Z = INIT[{I3, I2, I1, I0}];

    // FF behavioral model    
    always @(posedge CLK)
        QZ <= Z;

endmodule
