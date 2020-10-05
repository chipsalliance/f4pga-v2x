Binding FASM features to parameters
+++++++++++++++++++++++++++++++++++

A fasm feature can be bound to a Verilog module parameter by applying the `(* FASM *)` attribute on the parameter definition. The feature name will have exactly the same name as the parameter and will be prepended with hierarchical prefixes.

.. symbolator:: module.sim.v

.. verilog-diagram:: module.sim.v
   :type: netlistsvg
   :module: MODULE

.. no-license:: module.sim.v
   :language: verilog
   :caption: tests/fasm/prefix/module.sim.v

The annotated parameters will be appended to the "fasm_params" section of the pb_type metadata:

.. literalinclude:: module.model.xml
   :language: xml
   :caption: module.model.xml

.. literalinclude:: module.pb_type.xml
   :language: xml
   :caption: module.pb_type.xml
