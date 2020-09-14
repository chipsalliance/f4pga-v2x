Forced non-sequential relations to an input
+++++++++++++++++++++++++++++++++++++++++++

There are cases when a primitive needs to have different input/output port relations that it can be inferred from its internal behavioral model. This is due to the way that VPR requires primitives to be modelled.

V2X allows forcing certain inputs to have no sequential relations to any outputs. Such an input port need to be annotated using the `(* NO_SEQ *)` attribute.

This example shows a LOGIC cell macro primitive that models a whole LOGIC cell of Quicklogic EOS S3 FPGA architecture. The primitive is defined according to `VTR documentation <https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#sequential-block-with-internal-paths-and-combinational-input>`_.

.. symbolator:: logic_macro.sim.v

.. verilog-diagram:: logic_macro.sim.v
   :type: netlistsvg
   :module: LOGIC_MACRO

.. no-license:: logic_macro.sim.v
   :language: verilog
   :caption: tests/no_seq/logic_macro.sim.v

Input ports annotated with the `(* NO_SEQ *)` attribute are combinationaly related to TZ and CZ outputs and sequentially related to the QZ output. According to the VPR documentation there should be no clock relation to them defined in the pb_type XML and this is what the `(* NO_SEQ *)` attribute ensures.

.. literalinclude:: logic_macro.model.xml
   :language: xml
   :caption: logic_macro.model.xml

.. literalinclude:: logic_macro.pb_type.xml
   :language: xml
   :caption: logic_macro.pb_type.xml
