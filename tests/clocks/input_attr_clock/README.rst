Manually set input as clock by setting the CLOCK attribute
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The following shows that `input wire a` is given the `(* CLOCK *)` attribute.

.. symbolator:: ../../../tests/clocks/input_attr_clock/input_attr_clock.sim.v

.. verilog-diagram:: ../../../tests/clocks/input_attr_clock/input_attr_clock.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/input_attr_clock/input_attr_clock.sim.v

.. literalinclude:: ../../../tests/clocks/input_attr_clock/input_attr_clock.sim.v
   :language: verilog

As such, the `is_clock` attribute of the `a` port is set to 1.

.. literalinclude:: ../../../tests/clocks/input_attr_clock/golden.model.xml
   :language: xml