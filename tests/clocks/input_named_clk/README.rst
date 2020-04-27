Set input as clock by name (clk)
+++++++++++++++++++++++++++++++++++

An input wire can be set as a clock by assigning ``clk`` as its name.

.. symbolator:: ../../../tests/clocks/input_named_clk/input_named_clk.sim.v

|

.. literalinclude:: ../../../tests/clocks/input_named_clk/input_named_clk.sim.v
   :language: verilog
   :start-after: */
   :caption: tests/clocks/input_named_clk/input_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``clk`` port is set to 1, without needing to set anything else in the verilog code.

.. literalinclude:: ../../../tests/clocks/input_named_clk/golden.model.xml
   :language: xml
   :caption: tests/clocks/input_named_clk/golden.model.xml