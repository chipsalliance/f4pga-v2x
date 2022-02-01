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

`include "./child/child.sim.v"

module PARENT (
  input  wire I0,
  input  wire I1,
  output wire O0,
  output wire O1
);

  CHILD child (
  .I(I0),
  .O(O0)
  );

  // An direct connection from an input to the output pins.
  assign O1 = I1;

endmodule
