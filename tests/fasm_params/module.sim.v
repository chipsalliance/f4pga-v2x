(* FASM_PARAMS = "FEATURE_INIT=INIT;ENABLE_INV=IS_SOMETHING_INVERTED" *)
(* whitebox *)
module MODULE(I1, I2, O);
    input  wire I1;
    input  wire I2;
    output wire O;

    parameter INIT = 0;
    parameter IS_SOMETHING_INVERTED = 0;

endmodule
