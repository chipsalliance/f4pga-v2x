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

/*
 * `input wire a` should be detected as a clock because it drives the flip
 * flop. However, it has the attribute CLOCK set to 0 which should force it
 * to be a regular input.
 */
module BLOCK(a, b, c);
    (* CLOCK=0 *)
    input wire a;
    input wire b;
    output wire c;
    
    reg r;
    always @ ( posedge a ) begin
    	r <= b;
    end
    assign c = r;
endmodule
