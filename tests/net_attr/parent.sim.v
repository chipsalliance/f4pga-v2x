`include "./child/child.sim.v"

module PARENT(
    input  wire I,
    output wire O
);

    wire hop1 = I;

    CHILD child (
    .I(hop1),
    .O(O)
    );

endmodule
