D-Flipflop with one clock
+++++++++++++++++++++++++++++++++++

The following shows a simple D-flip flop driven by one clock. `input wire a` should be detected as a clock because it drives the flip flop.

.. symbolator:: ../../../tests/clocks/dff_one_clock/dff_one_clock.sim.v

.. verilog-diagram:: ../../../tests/clocks/dff_one_clock/dff_one_clock.sim.v
   :type: netlistsvg
   :module: BLOCK

|

.. literalinclude:: ../../../tests/clocks/dff_one_clock/dff_one_clock.sim.v
   :language: verilog
   :start-after: */
   :caption: tests/clocks/dff_one_clock/dff_one_clock.sim.v

As you can see in the generated model, the `is_clock` attribute of the `a` port is set to 1, while the `b` and `c` ports have their `clock` attribute set to `a`.

.. literalinclude:: ../../../tests/clocks/dff_one_clock/golden.model.xml
   :language: xml
   :caption: tests/clocks/dff_one_clock/golden.model.xml
