Set input as clock by name (regex)
+++++++++++++++++++++++++++++++++++

An input wire can be set as a clock by having `clk` in its name (case insensitive).

.. symbolator:: ../../../tests/clocks/input_named_regex/input_named_regex.sim.v

.. literalinclude:: ../../../tests/clocks/input_named_regex/input_named_regex.sim.v
   :language: verilog

As such, the `is_clock` attribute of wires with a variation of `clk` in their name is set to 1.

.. literalinclude:: ../../../tests/clocks/input_named_regex/golden.model.xml
   :language: xml