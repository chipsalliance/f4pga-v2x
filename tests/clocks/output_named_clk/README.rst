Set output as clock by name (clk)
+++++++++++++++++++++++++++++++++

An output wire can be set as a clock by assigning ``clk`` as its name.

.. symbolator:: ../../../tests/clocks/output_named_clk/output_named_clk.sim.v

|

.. literalinclude:: ../../../tests/clocks/output_named_clk/output_named_clk.sim.v
   :language: verilog
   :start-after: */
   :caption: tests/clocks/output_named_clk/output_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``clk`` output port is set to 1.

.. literalinclude:: ../../../tests/clocks/output_named_clk/golden.model.xml
   :language: xml
   :caption: tests/clocks/output_named_clk/golden.model.xml