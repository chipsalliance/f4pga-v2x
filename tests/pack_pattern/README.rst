Pack pattern annotation
+++++++++++++++++++++++

This example shows that v2x prevents annotating a top-level port of a pb_type 
when a net of that port is forking. This enables using pack patterns, 
e.g., for LUT to FF connections when the LUT output is also connected to 
a top-level output port. 

.. symbolator:: pack_pattern.sim.v

.. verilog-diagram:: pack_pattern.sim.v
   :type: netlistsvg
   :module: PACK_PATTERN

.. no-license::  pack_pattern.sim.v
   :language: verilog
   :caption: pack_pattern.sim.v

.. no-license:: pack_pattern.model.xml
   :language: xml
   :caption: pack_pattern.model.xml

.. no-license:: pack_pattern.pb_type.xml
   :language: xml
   :caption: pack_pattern.pb_type.xml
