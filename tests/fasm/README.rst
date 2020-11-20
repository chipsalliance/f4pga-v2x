FASM annotation support
=======================

These examples illustrate how to apply FASM annotations to various elements of the FPGA architecture description.

FASM annotation of elements of FPGA architecture model is necessary for VPR to produce a list of FASM features once a design is routed. The features may be then used to generate a bitstream for a FPGA. More on FASM output support in VPR can be found in the `documentation <https://docs.verilogtorouting.org/en/latest/utils/fasm/?highlight=fasm#fpga-assembly-fasm-output-support>`_.

.. toctree::
   prefix/README.rst
   features/no_modes/README.rst
   features/modes/README.rst
   params/README.rst
