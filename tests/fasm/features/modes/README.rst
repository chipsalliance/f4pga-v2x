FASM features for pb_types with modes
+++++++++++++++++++++++++++++++++++++

When a pb_type has multiple modes feature lists for each modes may be specified through the `(* FASM_FEATURES_<mode> *)` attribute(s). Each mode specific feature list will be joined with the common feature list provided using the `(* FASM_FEATURES *)` attribute.


.. symbolator:: module.sim.v

.. verilog-diagram:: module.sim.v
   :type: netlistsvg
   :module: MODULE

.. no-license:: module.sim.v
   :language: verilog
   :caption: tests/fasm/features/modes/module.sim.v

Features from the common feature list will be appended to the pb_type that contains the "mode" tag. Features from mode specific lists will be appended to pb_types that will represent the modes.

.. literalinclude:: module.model.xml
   :language: xml
   :caption: module.model.xml

.. literalinclude:: module.pb_type.xml
   :language: xml
   :caption: module.pb_type.xml
