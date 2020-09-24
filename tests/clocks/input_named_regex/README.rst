Set input as clock by name (regex)
++++++++++++++++++++++++++++++++++

An input wire can be set as a clock by having ``clk`` in its name (case insensitive).

.. symbolator:: block.sim.v

|

.. no-license:: block.sim.v
   :language: verilog
   :caption: tests/clocks/input_named_regex/block.sim.v

As such, the ``is_clock`` attribute of wires with a variation of ``clk`` in their name is set to 1.

.. literalinclude:: block.model.xml
   :language: xml
   :caption: block.model.xml

.. literalinclude:: block.pb_type.xml
   :language: xml
   :caption: block.pb_type.xml
