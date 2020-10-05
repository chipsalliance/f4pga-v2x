FASM features for pb_types
++++++++++++++++++++++++++

A VPR pb_type can be assigned with a number of fasm features that are emitted when it is used. https://docs.verilogtorouting.org/en/latest/utils/fasm/#fasm-metadata

In V2X the list of those features is defined via the `(* FASM_FEATURES *)` attribute of the Verilog module definition which represents a pb_type. The list contains a set of semicolon separated fasm feature names. It is an error to specify `(* FASM_FEATURES *)` on a module instance. All FASM feature names will be prepended with hierarchical prefixes.

.. symbolator:: module.sim.v

.. verilog-diagram:: module.sim.v
   :type: netlistsvg
   :module: MODULE

.. no-license:: module.sim.v
   :language: verilog
   :caption: tests/fasm/features/no_modes/module.sim.v

This results in the fasm features to be appended to the "fasm_features" pb_type metadata tag in the output XML:

.. literalinclude:: module.model.xml
   :language: xml
   :caption: module.model.xml

.. literalinclude:: module.pb_type.xml
   :language: xml
   :caption: module.pb_type.xml
