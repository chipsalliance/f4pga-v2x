Force input as regular input by setting the CLOCK attribute
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

`input wire a` should be detected as a clock because it drives the flip flop. However, it has the attribute CLOCK set to 0 which should force it to be a regular input.

.. symbolator:: ../../../tests/clocks/input_attr_not_clock/block.sim.v

.. verilog-diagram:: ../../../tests/clocks/input_attr_not_clock/block.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/input_attr_not_clock/block.sim.v

.. literalinclude:: ../../../tests/clocks/input_attr_not_clock/block.sim.v
   :language: verilog

As such, the `is_clock` attribute of the `a` port is not set.

.. literalinclude:: ../../../tests/clocks/input_attr_not_clock/golden.model.xml
   :language: xml