Manually set input as clock by setting the CLOCK attribute
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The following shows that ``input wire a`` is given the ``(* CLOCK *)`` attribute.

.. symbolator:: input_attr_clock.sim.v

|

.. no-license:: input_attr_clock.sim.v
   :language: verilog
   :caption: tests/clocks/input_attr_clock/input_attr_clock.sim.v

As such, the ``is_clock`` attribute of the ``a`` port is set to 1.

.. literalinclude:: input_attr_clock.model.xml
   :language: xml
   :caption: input_attr_clock.model.xml
