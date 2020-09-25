Combinational DSP
+++++++++++++++++

A combinational DSP block capable of multiplication and division. Modeled as "combinational block" according to |fig60|_ of `Primitive Block Timing Modeling Tutorial <https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#primitive-block-timing-modeling-tutorial>`_.

.. |fig60| replace:: ``Figure 60``
.. _fig60: https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#combinational-block

|

.. symbolator::  dsp_combinational.sim.v

.. verilog-diagram:: dsp_combinational.sim.v
   :type: netlistsvg
   :module: DSP_COMBINATIONAL

|

.. no-license:: dsp_combinational.sim.v
   :language: verilog
   :caption: tests/dsp/dsp_combinational/dsp_combinational.sim.v

.. no-license:: dsp_combinational.model.xml
   :language: xml
   :caption: dsp_combinational.model.xml

.. no-license:: dsp_combinational.pb_type.xml
   :language: xml
   :caption: dsp_combinational.pb_type.xml

Detection of combinational connections
**************************************

* Output has combinational connection with input

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
