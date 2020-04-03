// A model of a clock multiplexer with two clock inputs, one clock output and
// a select input.

(* whitebox *)
module GMUX (IP, IC, IS0, IZ);

    // 1st clock input
    (* ASYNC_CLOCK *)
    input  wire IP;

    // 2nd clock input
    (* ASYNC_CLOCK *)
    input  wire IC;

    // Select input
    input  wire IS0;

    // Clock output (has to be defined as a regular output port)
    output wire IZ;


    // Behavioral model:
    assign IZ = IS0 ? IC : IP;

endmodule
