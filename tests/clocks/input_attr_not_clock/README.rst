Force input as regular input by setting the CLOCK attribute
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

``input wire a`` should be detected as a clock because it drives the flip flop. However, it has the attribute CLOCK set to 0 which should force it to be a regular input.

.. symbolator:: block.sim.v

.. verilog-diagram:: block.sim.v
   :type: netlistsvg
   :module: BLOCK

|

.. no-license:: block.sim.v
   :language: verilog
   :caption: tests/clocks/input_attr_not_clock/block.sim.v

As such, the ``is_clock`` attribute of the ``a`` port is not set.

.. literalinclude:: block.model.xml
   :language: xml
   :caption: block.model.xml

.. literalinclude:: block.pb_type.xml
   :language: xml
   :caption: block.pb_type.xml
