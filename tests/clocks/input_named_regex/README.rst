Set input as clock by name (regex)
+++++++++++++++++++++++++++++++++++

An input wire can be set as a clock by having ``clk`` in its name (case insensitive).

.. symbolator:: ../../../tests/clocks/input_named_regex/block.sim.v

|

.. literalinclude:: ../../../tests/clocks/input_named_regex/block.sim.v
   :language: verilog
   :start-after: */
   :caption: tests/clocks/input_named_regex/block.sim.v

As such, the ``is_clock`` attribute of wires with a variation of ``clk`` in their name is set to 1.

.. literalinclude:: ../../../tests/clocks/input_named_regex/golden.model.xml
   :language: xml
   :caption: tests/clocks/input_named_regex/golden.model.xml

.. literalinclude:: ../../../tests/clocks/input_named_regex/golden.pb_type.xml
   :language: xml
   :caption: tests/clocks/input_named_regex/golden.pb_type.xml