Set outputs as clock by name (multiple clock outputs)
++++++++++++++++++++++++++++++++++++++++++++++++++++++

`output wire rdclk` and `output wire wrclk` have `clk` in their names, hence are recognized as clock inputs by v2x.

.. symbolator:: ../../../tests/clocks/multiple_outputs_named_clk/multiple_outputs_named_clk.sim.v

.. verilog-diagram:: ../../../tests/clocks/multiple_outputs_named_clk/multiple_outputs_named_clk.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/multiple_outputs_named_clk/multiple_outputs_named_clk.sim.v

.. literalinclude:: ../../../tests/clocks/multiple_outputs_named_clk/multiple_outputs_named_clk.sim.v
   :language: verilog
   :start-after: */

As such, the `is_clock` attribute of the `rdclk` and `wrclk` ports are set to 1.

.. literalinclude:: ../../../tests/clocks/multiple_outputs_named_clk/golden.model.xml
   :language: xml