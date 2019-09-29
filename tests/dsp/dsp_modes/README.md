# `dsp_modes` test

Test for "DSP style" block with multiple different modes.

The modes possible are;

 * Combinational only
   (IE [`dsp_combinational`](../dsp_combinational/README.md)).

 * Register on one input
   (IE [`dsp_partial_registered`](../dsp_partial_registered/README.md)).

 * Register on all inputs
   (IE [`dsp_in_registered`](../dsp_in_registered/README.md)).

 * Register on outputs
   (IE [`dsp_out_registered`](../dsp_out_registered/README.md)).

 * Register on both inputs and outputs (with same clock)
   (IE [`dsp_inout_registered`](../dsp_inout_registered/README.md)).

 * Register on both inputs and outputs (with independent clocks)
   (IE [`dsp_inout_registered_dualclk`](../dsp_inout_registered_dualclk/README.md)).

 * Register on both inputs and outputs (with independent clocks)
   (IE [`dsp_inout_registered_dualclk`](../dsp_inout_registered_dualclk/README.md)).


## Blackbox detection

 - [ ] model of the leaf `pb_type` is generated
 - [ ] leaf `pb_type` XML is generated
 - [ ] all dependency models and `pb_type`s are included in the output files

## Modes generation

 - [ ] all the modes from list defined with `MODES` attribute
 - [ ] mode setting is included in `pb_type` generation (correct part of logic is used)
 - [ ] modes connections are generated correctly
