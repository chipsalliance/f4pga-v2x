D-Flipflop with combinational logic
+++++++++++++++++++++++++++++++++++

The following shows a combinational logic design driven by a clock. `input wire a` should be detected as a clock because it drives the flip flop.

.. symbolator:: ../../../tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v

.. verilog-diagram:: ../../../tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v
   :type: netlistsvg
   :module: BLOCK
   :caption: tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v

.. literalinclude:: ../../../tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v
   :language: verilog
   :start-after:  */

The `is_clock` attribute of the `a` port is set to 1, and the ports `b`, `c` and `d` have their `clock` attribute set to `a`.

.. literalinclude:: ../../../tests/clocks/dff_comb_one_clock/golden.model.xml
   :language: xml