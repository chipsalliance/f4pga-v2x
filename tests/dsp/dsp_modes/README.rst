DSP-style block with different modes
++++++++++++++++++++++++++++++++++++

The possible modes are

* Combinational only (i.e. |dsp_combinational|_)
* Register on one input (i.e. |dsp_partial_registered|_)
* Register on all inputs (i.e. |dsp_in_registered|_)
* Register on outputs (i.e. |dsp_out_registered|_).
* Register on both inputs and outputs (with same clock) (i.e. |dsp_inout_registered|_).

.. |dsp_partial_registered| replace:: ``dsp_partial_registered``
.. _dsp_partial_registered: #dsp-style-block-with-only-one-input-registered

.. |dsp_in_registered| replace:: ``dsp_in_registered``
.. _dsp_in_registered: #dsp-style-block-with-all-inputs-registered

.. |dsp_out_registered| replace:: ``dsp_out_registered``
.. _dsp_out_registered: #dsp-style-block-with-outputs-registered

.. |dsp_inout_registered| replace:: ``dsp_inout_registered``
.. _dsp_inout_registered: #dsp-style-block-with-inputs-and-outputs-registered-single-clock

.. symbolator::  ../../tests/dsp/dsp_modes/dsp_modes.sim.v

.. verilog-diagram:: ../../tests/dsp/dsp_modes/dsp_modes.sim.v
   :type: netlistsvg
   :module: DSP_MODES

|

.. no-license::  ../../tests/dsp/dsp_modes/dsp_modes.sim.v
   :language: verilog
   :caption: tests/dsp/dsp_modes/dsp_modes.sim.v

.. no-license:: ../../tests/dsp/dsp_modes/golden.model.xml
   :language: xml
   :caption: tests/dsp/dsp_modes/golden.model.xml

.. no-license:: ../../tests/dsp/dsp_modes/golden.pb_type.xml
   :language: xml
   :caption: tests/dsp/dsp_modes/golden.pb_type.xml

Blackbox detection
******************

* Model of the leaf ``pb_type`` is generated
* Leaf ``pb_type`` XML is generated
* All dependency models and ``pb_type``\ s are included in the output files

Modes generation
****************

* All the modes from list defined with ``MODES`` attribute
* Mode setting is included in ``pb_type`` generation (correct part of logic is used)
* Modes connections are generated correctly
