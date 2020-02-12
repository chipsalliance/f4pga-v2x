An example and test how to specify fasm prefixes for cells
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

A cell instance can be assigned a fasm prefix through the FASM_PREFIX attribute. This attribute can only be specified on instances, not on definitions!

Cell arrays can only be defined using a geneate statement. For cell arrays the resulting "num_pb" value of the generated pb_type is greater than one. So does the required number of fasm prefixes. To accomodate for that multiple prefixes have to be specified as a semicolon separated list. The prefixes will be assigned to cells in order they are given.

This test case illustrates specifying fasm prefixes both for individual cells as well as for cell arrays.
