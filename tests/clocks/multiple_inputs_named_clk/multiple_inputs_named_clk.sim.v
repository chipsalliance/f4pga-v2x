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
 * `input wire rdclk` and `input wire wrclk` should be detected as a clock
 * despite this being a black box module.
 */
(* whitebox *)
module BLOCK(a, rdclk, b, wrclk, c, o);
	input wire a;
	input wire rdclk;
	input wire b;
	input wire wrclk;
	input wire c;
	output wire o;
endmodule
