Set inputs as clock by name (multiple clock inputs)
+++++++++++++++++++++++++++++++++++++++++++++++++++

``input wire rdclk`` and ``input wire wrclk`` have ``clk`` in their names, hence are recognized as clock inputs by v2x.

.. symbolator:: ../../../tests/clocks/multiple_inputs_named_clk/multiple_inputs_named_clk.sim.v

|

.. no-license:: ../../../tests/clocks/multiple_inputs_named_clk/multiple_inputs_named_clk.sim.v
   :language: verilog
   :caption: tests/clocks/multiple_inputs_named_clk/multiple_inputs_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``rdclk`` and ``wrclk`` ports are set to 1.

.. literalinclude:: ../../../tests/clocks/multiple_inputs_named_clk/golden.model.xml
   :language: xml
   :caption: tests/clocks/multiple_inputs_named_clk/golden.model.xml