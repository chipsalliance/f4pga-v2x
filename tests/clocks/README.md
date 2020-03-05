# `clocks` tests

This directory contains test for the clock detection functionality for the
`vlog_to_model.py` and `vlog_to_pbtype.py` tool.


## Detection of clock signals

 - [ ] Signal name matches the regexp `[a-z_]*clk[a-z0-9]*$`
 - [ ] Manually set via the `(* CLOCK *)` or `(* CLOCK=1 *)` Verilog attribute.
 - [ ] Manually cleared via the `(* CLOCK=0 *)` Verilog attribute.
 - [ ] Signal drives synchronous logic (IE flipflop).
 - [ ] Detection in recursive module includes.

## Detection of clock association

 - [ ] Clock comes from synchronous logic
 - [ ] Manually associated via `(* ASSOC_CLOCK="<clock signal"> *)` Verilog
       attribute.
 - [ ] Detection in recursive module includes.

