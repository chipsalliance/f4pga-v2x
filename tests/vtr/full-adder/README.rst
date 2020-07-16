Full Adder Example
++++++++++++++++++

An example of the classical combinational `"full adder" <https://en.wikipedia.org/wiki/Adder_(electronics)#Full_adder>`_ circuit shown in |fig59|_.

.. |fig59| replace:: ``Figure 59 - Full Adder``
.. _fig59: https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#combinational-block

.. image:: ../../../tests/vtr/full-adder/full-adder.svg
   :alt: Figure 59 from Verilog to Routing Documentation

*Fig. 59 - Full Adder*

|

.. symbolator::  ../../../tests/vtr/full-adder/adder.sim.v

.. verilog-diagram:: ../../../tests/vtr/full-adder/adder.sim.v
   :type: netlistsvg
   :module: ADDER

|

.. no-license::  ../../../tests/vtr/full-adder/adder.sim.v
   :language: verilog
   :caption: tests/vtr/full-adder/adder.sim.v

.. no-license:: ../../../tests/vtr/full-adder/golden.model.xml
   :language: xml
   :caption: tests/vtr/full-adder/golden.model.xml

.. no-license:: ../../../tests/vtr/full-adder/golden.pb_type.xml
   :language: xml
   :caption: tests/vtr/full-adder/golden.pb_type.xml


Detection of combinational connections
**************************************

* Output has combinational connection with input

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated

Timings
*******

* All the timings defined for wires with attributes should be included in ``pb_type`` XML
