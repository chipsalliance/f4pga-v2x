LUT with FlipFlop Example
+++++++++++++++++++++++++

An example of the classical LUT with FlipFlop pair shown in |fig31|_ demonstrating the `<pack_pattern>` tag.

.. |fig31| replace:: ``Figure 31 - Pack Pattern Example``
.. _fig31: https://docs.verilogtorouting.org/en/latest/arch/reference/#id35

.. image:: ../../../tests/vtr/lutff-pair/lutff-pair.png
   :alt: Figure 31 from Verilog to Routing Documentation

*Fig. 31 - Pack Pattern Example*

|

.. symbolator:: ../../../tests/vtr/lutff-pair/pair.sim.v

.. .. verilog-diagram:: ../../../tests/vtr/lutff-pair/pair.sim.v
..    :type: netlistsvg
..    :module: PAIR

|

.. no-license::  ../../../tests/vtr/lutff-pair/pair.sim.v
   :language: verilog
   :caption: tests/vtr/lutff-pair/pair.sim.v

.. no-license:: ../../../tests/vtr/lutff-pair/golden.model.xml
   :language: xml
   :caption: tests/vtr/lutff-pair/golden.model.xml

.. no-license:: ../../../tests/vtr/lutff-pair/golden.pb_type.xml
   :language: xml
   :caption: tests/vtr/lutff-pair/golden.pb_type.xml

Blackbox detection
------------------

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
* All dependency models and ``pb_type``\ s are included in the output files

Carry chain inference
---------------------

* ``pack_pattern`` inference - ``pack_pattern``\ s defined on wires with ``pack`` attributes should be propagated to ``pb_type`` XMLs
