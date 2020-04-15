D-Flipflop with two clocks
+++++++++++++++++++++++++++++++++++

`input wire c1` and `input wire c2` should be detected as clocks because they drive the flip flop.

.. symbolator:: ../../../tests/clocks/dff_two_clocks/dff_two_clocks.sim.v

.. literalinclude:: ../../../tests/clocks/dff_two_clocks/dff_two_clocks.sim.v
   :language: verilog

The `is_clock` attribute of the `c1` and `c2` ports are set to 1, and the ports `a`, `b`, `c`, `o1` and `o2` have their `clock` attribute set to the respective clocks they are driven by.

.. literalinclude:: ../../../tests/clocks/dff_two_clocks/golden.model.xml
   :language: xml
