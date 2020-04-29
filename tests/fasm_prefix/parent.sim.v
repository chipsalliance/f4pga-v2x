`include "./gate/gate.sim.v"
`include "./ff/ff.sim.v"

module PARENT (CLK, I0, I1, I2, O0, O1, O2, Y);
  (* CLOCK *)
  input  wire CLK;
  input  wire I0;
  input  wire I1;
  input  wire I2;
  output wire O0;
  output wire O1;
  output wire O2;
  output wire [1:0] Y;

  // Explicit instances of multiple children of the same type.
  (* FASM_PREFIX = "FASM_PREFIX_FOR_GATE_A" *)
  GATE gate_a (I0, I1, O0);
  (* FASM_PREFIX = "FASM_PREFIX_FOR_GATE_B" *)
  GATE gate_b (I0, I1, O1);

  // Multiple children defined using the generate statement. Each instance is
  // assigned a different fasm prefix.
  genvar i;
  generate for (i=0; i<2; i=i+1) begin
    (* FASM_PREFIX = "PREFIX_FOR_GATE_I0;PREFIX_FOR_GATE_I1" *)
    GATE gate (I0, I1, Y[i]);
  end endgenerate

  // An instance of a single child cell.
  (* FASM_PREFIX = "FASM_PREFIX_FOR_FF" *)
  FF ff (CLK, I2, O2);

endmodule
