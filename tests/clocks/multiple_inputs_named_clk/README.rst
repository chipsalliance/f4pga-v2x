Set inputs as clock by name (multiple clock inputs)
+++++++++++++++++++++++++++++++++++++++++++++++++++

`input wire rdclk` and `input wire wrclk` have `clk` in their names, hence are recognized as clock inputs by v2x.

.. symbolator:: ../../../tests/clocks/multiple_inputs_named_clk/multiple_inputs_named_clk.sim.v

.. literalinclude:: ../../../tests/clocks/multiple_inputs_named_clk/multiple_inputs_named_clk.sim.v
   :language: verilog

As such, the `is_clock` attribute of the `rdclk` and `wrclk` ports are set to 1.

.. literalinclude:: ../../../tests/clocks/multiple_inputs_named_clk/golden.model.xml
   :language: xml