# Classical D-Flip-Flop test

An example of the classical D-Flip-Flop.

This is shown in `Figure 43 - DFF` of the
["Sequential block (no internal paths)"](https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#sequential-block-no-internal-paths)
section in the
[Primitive Block Timing Modeling Tutorial](https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#)
of the
[Verilog to Routing documentation](https://docs.verilogtorouting.org)
and reproduced below;

> ![Figure 43 from Verilog to Routing Documentation](dff.svg)
> *Fig. 43 DFF*

## Clock associations inference

 - [ ] automatic inference is signal is associated with any clock and include the info in the model
 - [ ] automatic clock detection (signals named `clk` are considered as clocks)

## Blackbox detection

 - [ ] model of the leaf `pb_type` is generated
 - [ ] leaf `pb_type` XML is generated

## Timings

 - [ ] all the timings defined for wires with attributes should be included in `pb_type` XML
