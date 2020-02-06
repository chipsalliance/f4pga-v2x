A test for cells with "passthrough" modes and direct pin-to-pin connections.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This test demonstrates two use cases.

1. A non-primitive cell that has direct input to output connections inside.

    Such a cell has child cells that are connected to its ports. But it also contains direct connection(s) between its input and output ports. In such a case the direct connections have to be expressed within its interconnect along with regular connections to child cells.


2. A cell with modes in which one of them is a "passthrough"

    A passthrough mode defines a direct input to output connection and no child cells. In such a case no pb_type is to be generated for the "passthrough" mode. Instead, an interconnect defining the direect connection is placed directly under the "mode" tag.
