Classical D-Flip-Flop test
++++++++++++++++++++++++++

An example of the classical D-Flip-Flop shown in |fig60|_.

.. |fig60| replace:: ``Figure 60 - DFF``
.. _fig60: https://docs.verilogtorouting.org/en/latest/tutorials/arch/timing_modeling/#sequential-block-no-internal-paths

.. image:: dff.svg
   :alt: Figure 60 from Verilog to Routing Documentation

*Fig. 60 - DFF*

|


|

.. no-license:: dff.sim.v
   :language: verilog
   :caption: dff.sim.v

.. no-license:: dff.model.xml
   :language: xml
   :caption: dff.model.xml

.. no-license:: dff.pb_type.xml
   :language: xml
   :caption: dff.pb_type.xml

Clock associations inference
****************************

* Automatic inference is signal is associated with any clock and include the info in the model
* Automatic clock detection (signals named ``clk`` are considered as clocks)

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated

Timings
*******

* All the timings defined for wires with attributes should be included in ``pb_type`` XML
