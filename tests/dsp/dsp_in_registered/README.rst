DSP-style block with all inputs registered
++++++++++++++++++++++++++++++++++++++++++

This uses the model from |fig60|_ and the |dsp_combinational|_ module.

.. symbolator::  ../../tests/dsp/dsp_in_registered/dsp_in_registered.sim.v

.. verilog-diagram:: ../../tests/dsp/dsp_in_registered/dsp_in_registered.sim.v
   :type: netlistsvg
   :module: DSP_IN_REGISTERED

|

.. no-license::  ../../tests/dsp/dsp_in_registered/dsp_in_registered.sim.v
   :language: verilog
   :caption: tests/dsp/dsp_in_registered/dsp_in_registered.sim.v

.. no-license:: ../../tests/dsp/dsp_in_registered/golden.model.xml
   :language: xml
   :caption: tests/dsp/dsp_in_registered/golden.model.xml

.. no-license:: ../../tests/dsp/dsp_in_registered/golden.pb_type.xml
   :language: xml
   :caption: tests/dsp/dsp_in_registered/golden.pb_type.xml

Detection of combinational connections
**************************************

* Output has combinational connection with input
* ``pack_pattern`` defined on wire connections with ``pack`` attribute

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
* All dependency models and ``pb_type``\ s are included in the output files
