D-Flipflop with combinational logic
+++++++++++++++++++++++++++++++++++

`input wire a` should be detected as a clock because it drives the flip flop.

.. symbolator:: ../../tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v

.. literalinclude:: ../../tests/clocks/dff_comb_one_clock/dff_comb_one_clock.sim.v
   :language: verilog
