Manually set output as clock by setting the CLOCK attribute
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The following shows that `output wire o` is given the `(* CLOCK *)` attribute.

.. symbolator:: ../../../tests/clocks/output_attr_clock/output_attr_clock.sim.v

.. verilog-diagram:: ../../../tests/clocks/output_attr_clock/output_attr_clock.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/output_attr_clock/output_attr_clock.sim.v

.. literalinclude:: ../../../tests/clocks/output_attr_clock/output_attr_clock.sim.v
   :language: verilog

As such, the `is_clock` attribute of the `o` port is set to 1.

.. literalinclude:: ../../../tests/clocks/output_attr_clock/golden.model.xml
   :language: xml