# `clock mux` tests

This is an example of modeling a clock mux/buffer which has both clock inputs and outputs. According to the "Primitive Block Timing Modeling Tutorial" section "Clock Buffers & Muxes" of the VTR manual (https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#clock-muxes), a clock buffer or a clock mux has to have its outputs(s) as combinational sinks of clock input(s). This contradicts with how regular sequential blocks (like flip-flops) has to be modeled.

In this example the NO_COMB attribute is used. When it's value is forced to 0 then clock inputs may get combinational_sink annotations.
