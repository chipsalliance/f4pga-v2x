DSP-style block with inputs and outputs registered using separate clocks
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

A combinational DSP block with registered inputs and outputs. Separate clock is used for inputs and outputs. Modeled as a complex block. 

.. symbolator::  dsp_inout_registered_dualclk.sim.v

.. verilog-diagram:: dsp_inout_registered_dualclk.sim.v
   :type: netlistsvg
   :module: DSP_INOUT_REGISTERED_DUALCLK

|

.. no-license::  dsp_inout_registered_dualclk.sim.v
   :language: verilog
   :caption: tests/dsp/dsp_inout_registered_dualclk/dsp_inout_registered_dualclk.sim.v

.. no-license:: dsp_inout_registered_dualclk.model.xml
   :language: xml
   :caption: dsp_inout_registered_dualclk.model.xml

.. no-license:: dsp_inout_registered_dualclk.pb_type.xml
   :language: xml
   :caption: dsp_inout_registered_dualclk.pb_type.xml

Detection of combinational connections
**************************************

* Output has combinational connection with input
* ``pack_pattern`` defined on wire connections with ``pack`` attribute

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
* All dependency models and ``pb_type``\ s are included in the output files
