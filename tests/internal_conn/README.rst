A test for cells with "passthrough" modes and direct pin-to-pin connections.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This tests checks two cases:

1. A cell may have some of its input pins connected directly to its output pins internally. In such a case that connection has to be expressed within its interconnect. This test does exactly that.

2. Given a cell which has a "passthrough" mode with no child cells and a direct input to output connection, no pb_type for the "passthrough" mode should be generated. Moreover, the interconnect that holds the input to output connection should be defined directly under the "mode" tag.

