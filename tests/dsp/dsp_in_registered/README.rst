DSP-style block with all inputs registered
++++++++++++++++++++++++++++++++++++++++++

A combinational DSP block with registered inputs. Modeled as a complex block. 

.. symbolator::  dsp_in_registered.sim.v

.. verilog-diagram:: dsp_in_registered.sim.v
   :type: netlistsvg
   :module: DSP_IN_REGISTERED

|

.. no-license::  dsp_in_registered.sim.v
   :language: verilog
   :caption: tests/dsp/dsp_in_registered/dsp_in_registered.sim.v

.. no-license:: dsp_in_registered.model.xml
   :language: xml
   :caption: dsp_in_registered.model.xml

.. no-license:: dsp_in_registered.pb_type.xml
   :language: xml
   :caption: dsp_in_registered.pb_type.xml

Detection of combinational connections
**************************************

* Output has combinational connection with input
* ``pack_pattern`` defined on wire connections with ``pack`` attribute

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
* All dependency models and ``pb_type``\ s are included in the output files
