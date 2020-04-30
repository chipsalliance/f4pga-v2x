(* whitebox *)
module MODULE(I1, I2, O);
    input  wire I1;
    input  wire I2;
    output wire O;

    (* FASM *)
    parameter INIT = 0;
    (* FASM="INVERT" *)
    parameter IS_SOMETHING_INVERTED = 0;

    assign O = I1 | I2;

endmodule
