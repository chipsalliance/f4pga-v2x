FASM prefix specification
+++++++++++++++++++++++++

This example illustrates specifying FASM prefixes both for individual cells as well as for cell arrays.

Complete FASM feature names are hierarchical. The hierarchy is built by concatenating prefixes assigned to pb_type in the pb_type hierarchy.

In V2X a FASM prefix may be assigned to a cell instance via the `(* FASM_PREFIX *)` attribute. It is crucial that it is specified on instances, not on module definitions!

Cell arrays can also be defined using generate statement. For a cell array the resulting "num_pb" value of the generated pb_type is equal to the array size. So is the required number of fasm prefixes. To accomodate for that multiple prefixes have to be specified in `(* FASM_PREFIX *)` as a semicolon separated list. The prefixes will be assigned to cells in the order they are given.

.. symbolator:: parent.sim.v

.. verilog-diagram:: parent.sim.v
   :type: netlistsvg
   :module: PARENT

.. no-license:: parent.sim.v
   :language: verilog
   :caption: tests/fasm/prefix/parent.sim.v

You may notice "fasm_prefix" metadata tags appended to pb_types

.. literalinclude:: parent.model.xml
   :language: xml
   :caption: parent.model.xml

.. literalinclude:: parent.pb_type.xml
   :language: xml
   :caption: parent.pb_type.xml
