`include "./child/child.sim.v"

module PARENT (
  input  wire I0,
  input  wire I1,
  output wire O0,
  output wire O1
);

  // A child cell was connected properly
  CHILD child (
  .I(I0),
  .O(O0)
  );

  // Interconnect for this wasn't generated!
  assign O1 = I1;

endmodule
