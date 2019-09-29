# `dsp_partial_registered` test

Test for "DSP style" block with one input registered.

The tests use model from [`fig42-dff`](FIXME) and
[`dsp_combinational`](../dsp_combinational/README.md) tests.

## Detection of combinational connections

 - [ ] output has combinational connection with input
 - [ ] `pack_pattern` defined on wire connections with `pack` attribute

## Blackbox detection

 - [ ] model of the leaf `pb_type` is generated
 - [ ] leaf `pb_type` XML is generated
 - [ ] all dependency models and `pb_type`s are included in the output files

