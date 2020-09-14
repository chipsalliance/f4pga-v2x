Pack pattern annotation example
+++++++++++++++++++++++++++++++

VPR requires that connections between primitives that need to be packed together be annotated with pack patterns. Moreover, a single connection may have multiple pack pattern annotations.

In V2X a pack pattern annotation can be specified for a given net using the `(* PACK *)` attribute. The value of the attribute can be either a single pack pattern name of a list of pack pattern names separated by semicolons.

This example below contains a model of a logic block that has a LUT4 connected to a FF through a MUX. The mux allows to dynamically select whether the FF input is driven by the LUT or an external input.

This is the HDL definition of the logic block

|

.. symbolator:: block.sim.v

.. verilog-diagram:: block.sim.v
   :type: netlistsvg
   :module: BLOCK

|

.. no-license:: block.sim.v
   :language: verilog
   :caption: tests/pack_pattern/block.sim.v

There are two pack patterns one for LUT, MUX and FF packed together and one for MUX and FF without the LUT. The connection between the LUT and the MUX gets a single pack pattern annotation while the one between MUX and FF gets two annotations.

The `(* PACK *)` attribute annotations result in pack_pattern tags to be added to the pb_type XML as it can be observed in the generated description below:

.. literalinclude:: block.model.xml
   :language: xml
   :caption: block.model.xml

.. literalinclude:: block.pb_type.xml
   :language: xml
   :caption: block.pb_type.xml
