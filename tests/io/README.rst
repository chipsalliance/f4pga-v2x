Tests for modelling I/O primitives
++++++++++++++++++++++++++++++++++

In VPR top-level I/O pins are represented using `.input` and `.output` BLIF models that are implemented by leaf pb_types. In order to model those using verilog you need to assing the specific `CLASS` attribute so the V2X would know that it has to use either `.input` or `.output` BLIF model for a cell.

The I/O BLIF models are built-in into the VPR so there is no need for generating models for them. By specifying that a cell is of an I/O class the V2X won't generate model for it.

This test verifies that functionality of the V2X.
