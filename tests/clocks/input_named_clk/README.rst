Set input as clock by name (clk)
++++++++++++++++++++++++++++++++

An input wire can be set as a clock by assigning ``clk`` as its name.

.. symbolator:: input_named_clk.sim.v

|

.. no-license:: input_named_clk.sim.v
   :language: verilog
   :caption: tests/clocks/input_named_clk/input_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``clk`` port is set to 1, without needing to set anything else in the verilog code.

.. literalinclude:: input_named_clk.model.xml
   :language: xml
   :caption: input_named_clk.model.xml
