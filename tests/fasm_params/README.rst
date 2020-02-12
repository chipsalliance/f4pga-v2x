An example and test how to specify fasm parameters
++++++++++++++++++++++++++++++++++++++++++++++++++

Fasm parameters define fasm features that are controlled by specific parameters of a cell.

First a cell has to have a parameter (its name does not matter). Then the binding between the parameter and a fasm feature is defined through the FASM_PARAMS attribute of a module definition. Value of that attribute defines a comma separated list of fasm features and module parameters.
