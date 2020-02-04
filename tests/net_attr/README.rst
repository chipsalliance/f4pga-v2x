Test for multiple occurrence of the same numerical net id in the "netnames" list.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

When connecting a signal through multiple wires Yosys assigns name of each of them to the same net id. Such a case triggered a bug in V2X causing it to crash. This test verifies that the reworked handling of "netnames" in V2X behaves properly.
