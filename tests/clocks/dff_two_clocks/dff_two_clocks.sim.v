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

module BLOCK(c1, c2, a, b, c, o1, o2);
	input wire c1;
	input wire c2;
	input wire a;
	input wire b;
	input wire c;
	output wire o1;
	output wire o2;

	reg r1;
	reg r2;
        always @ ( posedge c1 ) begin
                r1 <= a | b;
        end
        always @ ( posedge c2 ) begin
                r2 <= b | c;
        end

	assign o1 = r1;
	assign o2 = r2;
endmodule
