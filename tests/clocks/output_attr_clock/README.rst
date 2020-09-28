Manually set output as clock by setting the CLOCK attribute
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The following shows that ``output wire o`` is given the ``(* CLOCK *)`` attribute.

.. symbolator:: output_attr_clock.sim.v

|

.. no-license:: output_attr_clock.sim.v
   :language: verilog
   :caption: tests/clocks/output_attr_clock/output_attr_clock.sim.v

As such, the ``is_clock`` attribute of the ``o`` port is set to 1.

.. literalinclude:: output_attr_clock.model.xml
   :language: xml
   :caption: output_attr_clock.model.xml
