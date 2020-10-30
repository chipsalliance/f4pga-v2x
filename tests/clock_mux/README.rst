Clock multiplexing primitive
++++++++++++++++++++++++++++

This is an example of modeling a clock mux/buffer which utilizes both clock inputs and clock outputs.

By default, clocks are excluded from the combinational sink list. IE They do not have `combinational_sink_ports` property associated with them. However, clock multiplexers violate this rule as their input clocks do not drive any sequential logic. They are passed to output(s) instead. VPR requires `Clock buffers & muxes <https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#clock-muxes>`_ to be defined in this way.


V2X provides the attribute `(* COMB_INCLUDE_CLOCKS *)` that when specified on an output port makes appear on the `combinational_sink_ports` list of its related input port(s) even if it is marked as a clock input.

.. symbolator:: gmux.sim.v

.. verilog-diagram:: gmux.sim.v
   :type: netlistsvg
   :module: GMUX

.. no-license:: gmux.sim.v
   :language: verilog
   :caption: tests/clock_mux/gmux.sim.v

In this example the `(* COMB_INCLUDE_CLOCKS *)` attribute is set on the `IZ` output making it appear in combinational sinks lists of its associated clock input ports.

.. literalinclude:: gmux.model.xml
   :language: xml
   :caption: gmux.model.xml

.. literalinclude:: gmux.pb_type.xml
   :language: xml
   :caption: gmux.pb_type.xml

