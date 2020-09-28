Set output as clock by name (clk)
+++++++++++++++++++++++++++++++++

An output wire can be set as a clock by assigning ``clk`` as its name.

.. symbolator:: output_named_clk.sim.v

|

.. no-license:: output_named_clk.sim.v
   :language: verilog
   :caption: tests/clocks/output_named_clk/output_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``clk`` output port is set to 1.

.. literalinclude:: output_named_clk.model.xml
   :language: xml
   :caption: output_named_clk.model.xml
