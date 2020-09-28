Clock multiplexing primitive
++++++++++++++++++++++++++++

This is an example of modeling a clock mux/buffer which has both clock inputs and clock outputs.

According to the "Primitive Block Timing Modeling Tutorial" section "Clock Buffers & Muxes" of the `VTR documentation <https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#clock-muxes>`_, a clock buffer or a clock mux has to have its outputs(s) as combinational sinks of clock input(s). This contradicts with how regular sequential blocks (like flip-flops) have to be modeled.

V2X provides the attribute `(* NO_COMB *)` that when specified on a clock port and given explicitly the value of 0 will prevent it from getting combinational_sink annotations in XML.

.. symbolator:: gmux.sim.v

.. verilog-diagram:: gmux.sim.v
   :type: netlistsvg
   :module: GMUX

.. no-license:: gmux.sim.v
   :language: verilog
   :caption: tests/clock_mux/gmux.sim.v

In this example the `(* NO_COMB *)` attribute is used on clock inputs IP and IC so they don't get any combinational_sink tags.

.. literalinclude:: gmux.model.xml
   :language: xml
   :caption: gmux.model.xml

.. literalinclude:: gmux.pb_type.xml
   :language: xml
   :caption: gmux.pb_type.xml

