Explicit combinational sink list
++++++++++++++++++++++++++++++++

This is an example of modeling a clock buffer which has both clock inputs and outputs. According to the "Primitive Block Timing Modeling Tutorial" section "Clock Buffers & Muxes" of the VTR manual, a clock buffer or a clock mux has to have its outputs(s) as combinational sinks of clock input(s). This contradicts with how regular sequential blocks (like flip-flops) has to be modeled. Therefore when modeling a clock buffer with V2X its clock input must have explicitly given cobinational sinks which are clock outputs.

For that there is the `COMB_SINKS` attribute which has to be applied to an input port. It should be assigned a string containing space separated list of port names that should be treated as combinational sinks of the input.
