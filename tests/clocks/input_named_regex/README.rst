Set input as clock by name (regex)
+++++++++++++++++++++++++++++++++++

An input wire can be set as a clock by having `clk` in its name (case insensitive).

.. symbolator:: ../../../tests/clocks/input_named_regex/block.sim.v

.. verilog-diagram:: ../../../tests/clocks/input_named_regex/block.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/input_named_regex/block.sim.v

.. literalinclude:: ../../../tests/clocks/input_named_regex/block.sim.v
   :language: verilog
   :start-after: */

As such, the `is_clock` attribute of wires with a variation of `clk` in their name is set to 1.

.. literalinclude:: ../../../tests/clocks/input_named_regex/golden.model.xml
   :language: xml