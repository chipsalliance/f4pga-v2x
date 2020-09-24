Set outputs as clock by name (multiple clock outputs)
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``output wire rdclk`` and ``output wire wrclk`` have ``clk`` in their names, hence are recognized as clock inputs by v2x.

.. symbolator:: multiple_outputs_named_clk.sim.v

|

.. no-license:: multiple_outputs_named_clk.sim.v
   :language: verilog
   :caption: tests/clocks/multiple_outputs_named_clk/multiple_outputs_named_clk.sim.v

As such, the ``is_clock`` attribute of the ``rdclk`` and ``wrclk`` ports are set to 1.

.. literalinclude:: multiple_outputs_named_clk.model.xml
   :language: xml
   :caption: multiple_outputs_named_clk.model.xml
